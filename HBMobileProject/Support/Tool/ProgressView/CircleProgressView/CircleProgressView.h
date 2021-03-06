//
//  CircleProgressView.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//  圆形进度条

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView

// 背景层layer
@property (nonatomic, strong) CAShapeLayer *bgCircleLayer;
// 进度层layer
@property (nonatomic, strong) CAShapeLayer *circleLayer;

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
// 背景图片
@property (nonatomic, strong) UIImageView  *bgImageView;


// 是否需要动画完成后的回调 (需要 - setStrokeEnd:animated: 的 animated 设置为 YES)
@property (nonatomic, assign) BOOL isNeedCallBack;
// 动画完成回调 block
@property (nonatomic, copy) void (^finishedBlock)();

/**
 *  便利构造器方法
 *  @param frame        frame
 *  @param lineWidth    线条宽度
 *  @param lineColor    线条颜色
 *  @param clockWise    绘制方向,默认是顺时针方向, YES;
 *  @param startAngle   开始绘制的角度,默认是12点钟方向所在角度,即 1.5*M_PI
 *  
 *  return a CircleProgressView instance
 */
+ (instancetype)circleProgressViewWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor clockWise:(BOOL)clockWise startAngle:(CGFloat)startAngle;

/**
 * 设置完圆形进度条的相关属性后调用该方法,可以覆盖便利构造器中相关属性的设置;
 */
- (void)makeConfigEffective;

/**
 *  开始 strokeEnd 动画
 *  @param value    StrokeEnd value,取值范围0~1
 *  @param animated 是否需要动画
 */
- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end
