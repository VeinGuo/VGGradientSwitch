//
//  VGSwitchAnimationManager.h
//  VGGradientSwitchDemo
//
//  Created by gwr on 2017/2/13.
//  Copyright © 2017年 gwr. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString  *kTickToDotAnimationKey = @"kTickToDotAnimationKey";
static NSString  *kDotToTickAnimationKey = @"kDotToTickAnimationKey";
static NSString  *kCrossToDotAnimationKey = @"kCrossToDotAnimationKey";
static NSString  *kDotToCrossAnimationKey = @"kDotToCrossAnimationKey";

@interface VGSwitchAnimationManager : NSObject

@property (assign, nonatomic) CGRect rect;

- (CAAnimationGroup *)dotToTickAnimationFromValues:(NSArray *)values;
- (CAAnimationGroup *)tickToDotAnimationFromValues:(NSArray *)values;

- (CAAnimationGroup *)dotToCrossAnimationFromValues:(NSArray *)values keyTimes:(NSArray *)keyTimes duration:(CGFloat)duration;
- (CAAnimationGroup *)crossToDotAnimationFromValues:(NSArray *)values keyTimes:(NSArray *)keyTimes duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
