//
//  VGKnobView.m
//  VGGradientSwitchDemo
//
//  Created by gwr on 2017/2/13.
//  Copyright © 2017年 gwr. All rights reserved.
//

#import "VGKnobView.h"

@interface VGKnobView ()

@end


@implementation VGKnobView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.backgroundColor = [UIColor clearColor];
    self.tickShapeLayer.path = self.tickPath.CGPath;
    self.crossShapeLayer1.path = self.crossPath1.CGPath;
    self.crossShapeLayer2.path = self.crossPath2.CGPath;
    self.crossShapeLayer1.hidden = YES;
    self.crossShapeLayer2.hidden = YES;
    
    [self.layer addSublayer:self.tickShapeLayer];
    [self.layer addSublayer:self.crossShapeLayer1];
    [self.layer addSublayer:self.crossShapeLayer2];
}

- (CAShapeLayer *)defaultShapeLayer{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 2;
    return layer;
}

- (CAShapeLayer *)tickShapeLayer{
    if (!_tickShapeLayer) {
        _tickShapeLayer = [self defaultShapeLayer];
    }
    return _tickShapeLayer;
}

- (CAShapeLayer *)crossShapeLayer1{
    if (!_crossShapeLayer1) {
        _crossShapeLayer1 = [self defaultShapeLayer];
    }
    return _crossShapeLayer1;
}

- (CAShapeLayer *)crossShapeLayer2{
    if (!_crossShapeLayer2) {
        _crossShapeLayer2 = [self defaultShapeLayer];
    }
    return _crossShapeLayer2;
}

- (UIBezierPath *)dotPath{
    if (!_dotPath) {
        _dotPath = [UIBezierPath bezierPath];
        [_dotPath moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.width/2)];
        [_dotPath addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.width/2)];
    }
    return _dotPath;
}

- (UIBezierPath *)tickPath{
    if (!_tickPath) {
        _tickPath = [UIBezierPath bezierPath];
        [_tickPath moveToPoint:CGPointMake(self.frame.size.width/8 * 3, self.frame.size.width/2)];
        
        CGPoint p1 = CGPointMake(self.frame.size.width/2, self.frame.size.width/8 * 5);
        [_tickPath addLineToPoint:p1];
        
        CGPoint p2 = CGPointMake(self.frame.size.width/8 * 6, self.frame.size.width/8 * 3);
        [_tickPath addLineToPoint:p2];
    }
    return _tickPath;
}

- (UIBezierPath *)crossPath1{
    if (!_crossPath1) {
        _crossPath1 = [UIBezierPath bezierPath];
        [_crossPath1 moveToPoint:CGPointMake(self.frame.size.width/9 * 6, self.frame.size.width/9 * 3)];
        
        CGPoint p1 = CGPointMake(self.frame.size.width/9 * 3, self.frame.size.width/9 * 6);
        [_crossPath1 addLineToPoint:p1];
    }
    return _crossPath1;
}

- (UIBezierPath *)crossPath2{
    if (!_crossPath2) {
        _crossPath2 = [UIBezierPath bezierPath];
        [_crossPath2 moveToPoint:CGPointMake(self.frame.size.width/9 * 3, self.frame.size.width/9 * 3)];
        
        CGPoint p2 = CGPointMake(self.frame.size.width/9 * 6, self.frame.size.width/9 * 6);
        [_crossPath2 addLineToPoint:p2];
    }
    return _crossPath2;
}

@end
