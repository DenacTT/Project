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
@property (nonatomic, assign) CGFloat lineWidth;

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor  *lineColor;

/**
 *  YES,顺时针.NO逆时针
 */
@property (nonatomic, assign) BOOL clockWise;

/**
 *  起始角度, 1.5*M_PI 为12点钟方向.
 */
@property (nonatomic, assign) CGFloat startAngle;

/**
 *  Start strokeEnd animation.
 *
 *  @param value    StrokeEnd value, range is [0, 1].
 *  @param func     Easing function point.
 *  @param animated Animated or not.
 *  @param duration The animation's duration.
 */
- (void)strokeEnd:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration;

/**
 *  Start strokeStart animation.
 *
 *  @param value    StrokeEnd value, range is [0, 1].
 *  @param func     Easing function point.
 *  @param animated Animated or not.
 *  @param duration The animation's duration.
 */
- (void)strokeStart:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration;

/**
 *  Convenient constructor.
 *
 *  @param frame     View frame.
 *  @param width     Line width.
 *  @param color     Line color.
 *  @param clockWise Clockwise or not.
 *  @param angle     Start angle, range is 0°~360°.
 *
 *  @return CircleView instance.
 */
+ (instancetype)circleViewWithFrame:(CGRect)frame lineWidth:(CGFloat)width lineColor:(UIColor *)color
                          clockWise:(BOOL)clockWise startAngle:(CGFloat)angle;
@end
