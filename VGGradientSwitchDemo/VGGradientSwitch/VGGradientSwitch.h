//
//  VGGradientSwitch.h
//  VGGradientSwitchDemo
//
//  Created by Vein on 2017/2/12.
//  Copyright © 2017年 gwr. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE @interface VGGradientSwitch : UIView

/**
 The switch border color
 */
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

/**
 The knob stroke color
 */
@property (strong, nonatomic) IBInspectable UIColor *knobColor;

/**
 The knob stroke width
 */
@property (assign, nonatomic) IBInspectable CGFloat knobStrokeWidth;

/**
 The switch status
 */
@property (assign, nonatomic,getter=isOn) IBInspectable BOOL on;

/**
 The switch to change state action
 */
@property (copy, nonatomic) void (^action)(BOOL);

- (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action

@end

NS_ASSUME_NONNULL_END
