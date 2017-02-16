//
//  VGKnobView.h
//  VGGradientSwitchDemo
//
//  Created by gwr on 2017/2/13.
//  Copyright © 2017年 gwr. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// switch上按钮
@interface VGKnobView : UIView

@property (strong, nonatomic) CAShapeLayer *tickShapeLayer;
@property (strong, nonatomic) CAShapeLayer *crossShapeLayer1;
@property (strong, nonatomic) CAShapeLayer *crossShapeLayer2;

@property (strong, nonatomic) UIBezierPath *dotPath;
@property (strong, nonatomic) UIBezierPath *tickPath;
@property (strong, nonatomic) UIBezierPath *crossPath1;
@property (strong, nonatomic) UIBezierPath *crossPath2;


@end

NS_ASSUME_NONNULL_END
