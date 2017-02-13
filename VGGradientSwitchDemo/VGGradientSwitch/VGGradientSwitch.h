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

@property (assign, nonatomic,getter=isOn)IBInspectable BOOL on;
@property (copy, nonatomic) void (^action)(BOOL);

- (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action

@end

NS_ASSUME_NONNULL_END
