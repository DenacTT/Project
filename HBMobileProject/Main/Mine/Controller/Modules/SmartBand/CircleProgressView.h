//
//  CircleProgressView.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//  圆形进度条

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView

// 线条宽度,默认4.f
@property (nonatomic, assign) CGFloat lineWidth;

// 线条颜色,默认白色
@property (nonatomic, strong) UIColor *lineColor;

// YES,顺时针.NO逆时针,默认顺时针方向
@property (nonatomic, assign) BOOL clockWise;

// 起始角度,默认12点钟位置开始,1.5*M_PI
@property (nonatomic, assign) CGFloat startAngle;

// 停止角度,默认12点钟方向结束,1.5*M_PI+2*M_PI
@property (nonatomic, assign) CGFloat endAngle;


// 是否需要底部背景
@property (nonatomic, assign) BOOL isNeedBackground;

// 背景线条宽度,默认2.f
@property (nonatomic, assign) CGFloat bgLineWidth;

// 背景线条颜色
@property (nonatomic, strong) UIColor *bgLineColor;


// 是否需要背景图片
@property (nonatomic, assign) BOOL isNeedBgImg;

// 背景图片name
@property (nonatomic, strong) NSString *bgImgName;


// 是否需要动画完成后的回调
@property (nonatomic, assign) BOOL isNeedCallBack;

// 动画完成回调 block
@property (nonatomic, copy) void (^finishedBlock)();

/**
 *  便利构造器方法
 */
+ (instancetype)circleProgressViewWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor clockWise:(BOOL)clockWise startAngle:(CGFloat)startAngle;

/**
 * 设置完圆形进度条的相关属性后调用该方法,可以覆盖便利构造器中相关属性的设置;
 */
- (void)makeConfigEffective;

/**
 *  开始 strokeEnd 动画
 *  @param value    StrokeEnd value, range is [0, 1].
 *  @param animated Animated or not.
 *  @param finished call back
 */
- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end
