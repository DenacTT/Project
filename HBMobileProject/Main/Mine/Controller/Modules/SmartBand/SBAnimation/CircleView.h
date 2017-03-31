//
//  CircleView.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@end
