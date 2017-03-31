//
//  CircleView.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXEasing.h"

@interface CircleView : UIView

/**
 *  线条宽度
 */
@property (nonatomic)         CGFloat   lineWidth;

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor  *lineColor;

/**
 *  YES,顺时针.NO逆时针
 */
@property (nonatomic)         BOOL      clockWise;

/**
 *  起始角度, 1.5*M_PI 为12点钟方向.
 */
@property (nonatomic)         CGFloat   startAngle;

/**
 *  便利构造器方法
 */
+ (instancetype)circleViewWithFrame:(CGRect)frame lineWidth:(CGFloat)width lineColor:(UIColor *)color
                          clockWise:(BOOL)clockWise startAngle:(CGFloat)angle;

/**
 *  Start strokeStart animation.
 *  开始 strokeStart 动画
 *  @param value    StrokeEnd value, range is [0, 1].
 *  @param func     Easing function point.
 *  @param animated Animated or not.
 *  @param duration The animation's duration.
 */
- (void)strokeStart:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration;

/**
 *  Start strokeEnd animation.
 *  开始 strokeEnd 动画
 *  @param value    StrokeEnd value, range is [0, 1].
 *  @param func     Easing function point.
 *  @param animated Animated or not.
 *  @param duration The animation's duration.
 */
- (void)strokeEnd:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration;

@end
