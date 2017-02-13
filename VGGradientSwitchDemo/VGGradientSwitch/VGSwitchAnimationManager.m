//
//  VGSwitchAnimationManager.m
//  VGGradientSwitchDemo
//
//  Created by gwr on 2017/2/13.
//  Copyright © 2017年 gwr. All rights reserved.
//

#import "VGSwitchAnimationManager.h"

@implementation VGSwitchAnimationManager

/**
 点 -> 勾
 */
- (CAAnimationGroup *)dotToTickAnimationFromValues:(NSArray *)values{
    
    CAKeyframeAnimation *lineAnimation = [self lineAnimationWithKeyTimes:@[@0,@0.3] beginTime:0 values:values];
    
    CABasicAnimation *scaleAnimation = [self transformAnimation];
    scaleAnimation.duration = .1;
    scaleAnimation.beginTime = .2;
    
    CAAnimationGroup *lineGroup = [CAAnimationGroup animation];
    lineGroup.animations = @[lineAnimation,scaleAnimation];
    lineGroup.duration = .5;
    lineGroup.repeatCount = 1;
    lineGroup.removedOnCompletion = NO;
    lineGroup.fillMode = kCAFillModeForwards;
    lineGroup.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return lineGroup;
}

/**
 勾 -> 点
 */
- (CAAnimationGroup *)tickToDotAnimationFromValues:(NSArray *)values{
    
    CABasicAnimation *scaleAnimation = [self transformAnimation];
    scaleAnimation.duration = .05;
    scaleAnimation.beginTime = 0;
    
    CAKeyframeAnimation *lineAnimation = [self lineAnimationWithKeyTimes:@[@.1,@0.4] beginTime:0 values:values];
    
    CAAnimationGroup *lineGroup = [CAAnimationGroup animation];
    lineGroup.animations = @[scaleAnimation,lineAnimation];
    lineGroup.duration = .5;
    lineGroup.repeatCount = 1;
    lineGroup.removedOnCompletion = NO;
    lineGroup.fillMode = kCAFillModeForwards;
    lineGroup.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return lineGroup;
}

/**
 点 -> 叉
 */
- (CAAnimationGroup *)dotToCrossAnimationFromValues:(NSArray *)values keyTimes:(NSArray *)keyTimes duration:(CGFloat)duration{
    
    CAKeyframeAnimation *lineAnimation = [self lineAnimationWithKeyTimes:keyTimes beginTime:0 values:values];
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CABasicAnimation *scaleAnimation = [self transformAnimation];
    CGFloat beginTime = [keyTimes.lastObject floatValue];
    scaleAnimation.beginTime = beginTime-.15;
    scaleAnimation.duration = .1;
    scaleAnimation.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CAAnimationGroup *lineGroup = [CAAnimationGroup animation];
    lineGroup.animations = @[lineAnimation,scaleAnimation];
    lineGroup.duration = duration;
    lineGroup.repeatCount = 1;
    lineGroup.removedOnCompletion = NO;
    lineGroup.fillMode = kCAFillModeForwards;
    
    return lineGroup;
}

/**
 叉 -> 点
 */
- (CAAnimationGroup *)crossToDotAnimationFromValues:(NSArray *)values keyTimes:(NSArray *)keyTimes duration:(CGFloat)duration{
    
    CAKeyframeAnimation *lineAnimation = [self lineAnimationWithKeyTimes:keyTimes beginTime:0 values:values];
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    CABasicAnimation *scaleAnimation = [self transformAnimation];
    scaleAnimation.beginTime = 0;
    scaleAnimation.duration = .1;
    
    CAAnimationGroup *lineGroup = [CAAnimationGroup animation];
    lineGroup.animations = @[scaleAnimation, lineAnimation];
    lineGroup.duration = duration;
    lineGroup.repeatCount = 1;
    lineGroup.removedOnCompletion = NO;
    lineGroup.fillMode = kCAFillModeForwards;
    
    return lineGroup;
}

- (CAKeyframeAnimation *)lineAnimationWithKeyTimes:(NSArray *)keyTimes beginTime:(CGFloat)beginTime values:(NSArray *)values{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    animation.values = values;
    animation.keyTimes = keyTimes;
    animation.beginTime = beginTime;
    return animation;
}

- (CABasicAnimation *)transformAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D tr = CATransform3DIdentity;
    tr = CATransform3DTranslate(tr, _rect.size.width/2, _rect.size.height/2, 0);
    tr = CATransform3DScale(tr, 1.2, 1.2, 1);
    tr = CATransform3DTranslate(tr, -_rect.size.width/2, -_rect.size.height/2, 0);
    animation.toValue = [NSValue valueWithCATransform3D:tr];
    animation.autoreverses = YES;
    animation.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return animation;
}

@end
