//
//  VGGradientSwitch.m
//  VGGradientSwitchDemo
//
//  Created by Vein on 2017/2/12.
//  Copyright © 2017年 gwr. All rights reserved.
//

#import "VGKnobView.h"
#import "VGSwitchAnimationManager.h"
#import "VGGradientSwitch.h"

#define VG_UIColorFromRGBAlpha(rgb, a)                           \
    ([UIColor colorWithRed:(float)(((rgb >> 16) & 0xFF) / 255.0f) \
    green:(((rgb >> 8) & 0xFF) / 255.0f)         \
    blue:(((rgb)&0xFF) / 255.0f)                \
    alpha:a])

@interface VGGradientSwitch () <CAAnimationDelegate>

@property (assign, nonatomic) CGFloat borderWidth;
@property (strong, nonatomic) CAShapeLayer *borderShape;
@property (strong, nonatomic) UIView *gradientView;

@property (assign, nonatomic) CGFloat knobMargin;
@property (strong, nonatomic) VGKnobView *knob;
@property (strong, nonatomic) VGSwitchAnimationManager *manager;

@property (assign, nonatomic, getter=isAnimating) BOOL animating;

@end

@implementation VGGradientSwitch

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat height = 30;
        CGFloat width = height * 1.75;
        self.frame = CGRectMake(0, 0, width, height);
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
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.backgroundColor = [UIColor clearColor];
    self.on = YES;
    self.borderShape = [self setupBorder];
    [self setupGradientView];
    [self.layer addSublayer:self.borderShape];
    self.knob = [self setupKnob];
    [self addSubview:self.knob];
    self.manager = [[VGSwitchAnimationManager alloc] init];
    self.manager.rect = self.knob.frame;
}

#pragma mark - Knob
- (VGKnobView *)setupKnob{
    CGFloat w = self.frame.size.height - _knobMargin * 2;
    VGKnobView *knob = [[VGKnobView alloc] initWithFrame:CGRectMake(_knobMargin, _knobMargin, w, w)];
    return knob;
}

#pragma mark - Border
- (CAShapeLayer *)setupBorder{
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CAShapeLayer *borderShape = [CAShapeLayer layer];
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height) cornerRadius:height / 2];
    borderShape.path = borderPath.CGPath;
    borderShape.fillColor = [UIColor clearColor].CGColor;
    UIColor *color = VG_UIColorFromRGBAlpha(0x183937, 0.8);
    borderShape.strokeColor = color.CGColor;
    borderShape.lineWidth = self.borderWidth;
    return borderShape;
}

#pragma mark - GradientView
- (void)setupGradientView
{
    UIColor *offColor1 = VG_UIColorFromRGBAlpha(0xef9c29, 1);
    UIColor *offColor2 = VG_UIColorFromRGBAlpha(0xe76b39, 1);
    
    UIColor *onColor1 = VG_UIColorFromRGBAlpha(0x08ded6, 1);
    UIColor *onColor2 = VG_UIColorFromRGBAlpha(0x18deb9, 1);
    
    CGFloat w = self.frame.size.width;

    self.gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) * 3, CGRectGetHeight(self.frame))];
    self.gradientView.backgroundColor = [UIColor clearColor];
    CAGradientLayer *gradientLayer = [self setupGradientLayerWithColors:@[(__bridge id)onColor1.CGColor,
                                                                           (__bridge id)onColor2.CGColor,
                                                                           (__bridge id)offColor1.CGColor,
                                                                           (__bridge id)offColor2.CGColor] toWidth:w*3];
    [self.gradientView.layer addSublayer:gradientLayer];
    [self addSubview:self.gradientView];
}

- (CAGradientLayer *)setupGradientLayerWithColors:(NSArray *)colors toWidth:(CGFloat)width{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = @[@0, @.33, @.63, @1];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, width, CGRectGetHeight(self.frame));
    return gradientLayer;
}

#pragma mark - Animation
- (void)offAnimation{
    self.animating = YES;
    [self setKnobShapeLayerHiddenWithIsOn:YES];
    CGFloat w = self.frame.size.height - _knobMargin * 2;
    
    CAAnimationGroup *tickAnimationGroup = [self.manager tickToDotAnimationFromValues:@[(__bridge id)self.knob.tickPath.CGPath,
                                                                                        (__bridge id)self.knob.dotPath.CGPath]];
    
    CAAnimationGroup *crossAnimationGroup1 = [self.manager dotToCrossAnimationFromValues:@[(__bridge id)self.knob.dotPath.CGPath,
                                                                                        (__bridge id)self.knob.crossPath1.CGPath] keyTimes:@[@.05, @.35]
                                                                                        duration:.55];
    CAAnimationGroup *crossAnimationGroup2 = [self.manager dotToCrossAnimationFromValues:@[(__bridge id)self.knob.dotPath.CGPath,
                                                                                          (__bridge id)self.knob.crossPath2.CGPath] keyTimes:@[@0, @.3]  duration:.5];
    crossAnimationGroup2.delegate = self;
    
    [self.knob.tickShapeLayer addAnimation:tickAnimationGroup forKey:kTickToDotAnimationKey];
    
    [UIView animateKeyframesWithDuration:.5 delay:.1 options:UIViewKeyframeAnimationOptionCalculationModePaced animations:^{
        self.knob.frame = CGRectMake(CGRectGetWidth(self.frame)-_knobMargin - w, _knobMargin, w, w);
        self.gradientView.frame = CGRectMake(-CGRectGetWidth(self.frame) *2, 0, CGRectGetWidth(self.frame) *3, CGRectGetHeight(self.frame));
    } completion:^(BOOL finished) {
        [self setKnobShapeLayerHiddenWithIsOn:NO];
        [self.knob.crossShapeLayer1 addAnimation:crossAnimationGroup1 forKey:kDotToCrossAnimationKey];
        [self.knob.crossShapeLayer2 addAnimation:crossAnimationGroup2 forKey:kDotToCrossAnimationKey];
    }];
}

- (void)onAnimation{
    self.animating = YES;
    [self setKnobShapeLayerHiddenWithIsOn:NO];
    
    CGFloat w = self.frame.size.height - _knobMargin * 2;
    
    CAAnimationGroup *tickAnimationGroup = [self.manager dotToTickAnimationFromValues:@[(__bridge id)self.knob.dotPath.CGPath,
                                                                                        (__bridge id)self.knob.tickPath.CGPath]];
    tickAnimationGroup.delegate = self;
    CAAnimationGroup *crossAnimationGroup1 = [self.manager crossToDotAnimationFromValues:@[(__bridge id)self.knob.crossPath1.CGPath
                                                                                           ,(__bridge id)self.knob.dotPath.CGPath]
                                                                                    keyTimes:@[@0, @.3]
                                                                                    duration:.5];
    CAAnimationGroup *crossAnimationGroup2 = [self.manager crossToDotAnimationFromValues:@[(__bridge id)self.knob.crossPath2.CGPath,
                                                                                           (__bridge id)self.knob.dotPath.CGPath] keyTimes:@[@.05, @.35]  duration:.55];
    
    [self.knob.crossShapeLayer1 addAnimation:crossAnimationGroup1 forKey:kCrossToDotAnimationKey];
    [self.knob.crossShapeLayer2 addAnimation:crossAnimationGroup2 forKey:kCrossToDotAnimationKey];
    
    [UIView animateKeyframesWithDuration:.5 delay:.1 options:UIViewKeyframeAnimationOptionCalculationModePaced animations:^{
        self.knob.frame = CGRectMake(_knobMargin, _knobMargin, w, w);
        self.gradientView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) *3, CGRectGetHeight(self.frame));
        
    } completion:^(BOOL finished) {
        [self setKnobShapeLayerHiddenWithIsOn:YES];
        [self.knob.tickShapeLayer addAnimation:tickAnimationGroup forKey:kDotToTickAnimationKey];
    }];
}

#pragma mark - Touch Hit
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (!self.isAnimating) {
        if (self.isOn) {
            [self offAnimation];
        }
        else{
            [self onAnimation];
        }
    }
}


#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        if (anim == [self.knob.crossShapeLayer2 animationForKey:kDotToCrossAnimationKey]) {
            self.animating = NO;
            self.on = NO;
        }
        else if(anim == [self.knob.tickShapeLayer animationForKey:kDotToTickAnimationKey]){
            self.animating = NO;
            self.on = YES;
        }
        if (self.action) {
            self.action(self.on);
        }
    }
}

#pragma Set On
- (void)setOn:(BOOL)on{
    _on = on;
    CGFloat w = self.frame.size.height - _knobMargin * 2;
    CGFloat h = self.frame.size.height;
    [self setKnobShapeLayerHiddenWithIsOn:_on];
    if (_on) {
        _knob.frame = CGRectMake(_knobMargin, _knobMargin, w, w);
        _gradientView.frame = CGRectMake(0, 0, self.frame.size.width *3, h);
    }else{
        _knob.frame = CGRectMake(CGRectGetWidth(self.frame)-_knobMargin - w, _knobMargin, w, w);
        _gradientView.frame = CGRectMake(-CGRectGetWidth(self.frame) *2, 0, CGRectGetWidth(self.frame) *3, h);
    }
}

- (void)setOn:(BOOL)on animated:(BOOL)animated{
    if(self.on == on) return;
    
    if (animated) {
        if (on) {
            [self onAnimation];
        }else{
            [self offAnimation];
        }
    }else{
        self.on = on;
    }
}

- (void)setKnobShapeLayerHiddenWithIsOn:(BOOL)isOn{
    if (isOn) {
        _knob.tickShapeLayer.hidden = NO;
        _knob.crossShapeLayer1.hidden = YES;
        _knob.crossShapeLayer2.hidden = YES;
    }else{
        _knob.tickShapeLayer.hidden = YES;
        _knob.crossShapeLayer1.hidden = NO;
        _knob.crossShapeLayer2.hidden = NO;

    }
}

#pragma mark - Setter&Getter

- (CGFloat)borderWidth{
    return self.frame.size.height / 7;
}

- (CGFloat)knobMargin{
    return self.frame.size.height / 12;
}

- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    _borderShape.strokeColor = borderColor.CGColor;
}

- (void)setKnobColor:(UIColor *)knobColor{
    _knobColor = knobColor;
    _knob.tickShapeLayer.strokeColor = knobColor.CGColor;
    _knob.crossShapeLayer1.strokeColor = knobColor.CGColor;
    _knob.crossShapeLayer2.strokeColor = knobColor.CGColor;
}

- (void)setKnobStrokeWidth:(CGFloat)knobStrokeWidth{
    _knobStrokeWidth = knobStrokeWidth;
    _knob.tickShapeLayer.lineWidth = knobStrokeWidth;
    _knob.crossShapeLayer1.lineWidth = knobStrokeWidth;
    _knob.crossShapeLayer2.lineWidth = knobStrokeWidth;
}

@end
