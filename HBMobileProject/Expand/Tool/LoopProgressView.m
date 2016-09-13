//
//  LoopProgressView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//  圆环形进度条(进度条 数字同步) http://www.cnblogs.com/fcug/p/5195522.html

#import "LoopProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define ViewWidth self.frame.size.width             //环形进度条的视图宽度
#define ProgressWidth 2.5                                   //环形进度条的圆环宽度
#define Radius ViewWidth/2 - ProgressWidth    //环形进度条的半径

@interface LoopProgressView ()
{
    CAShapeLayer *archLayer;
    UILabel *label;
    NSTimer *progressTimer;
}

@property (nonatomic, assign) CGFloat i;

@end

@implementation LoopProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 重写 drawRect 方法进行绘图操作,程序会自动调用该方法进行绘图.
// drawRect 方法是在Controller->loadView, Controller->viewDidLoad 两方法之后掉用的.

- (void)drawRect:(CGRect)rect
{
    _i = 0;
    
    CGContextRef progressContext = UIGraphicsGetCurrentContext(); /* 只能在drawRect里调用UIGraphicsGetCurrentContext() 因为在drawRect之前，系统会往栈里面压入一个valid的CGContextRef，除非自己去维护一个CGContextRef，否则不应该在其他地方取CGContextRef。*/
    CGContextSetLineWidth(progressContext, ProgressWidth);
    CGContextSetRGBStrokeColor(progressContext, 209.0/255.0, 209.0/255.0, 209.0/255.0, 1);
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.width * 0.5;
    
    // 绘制环形进度条底框
    CGContextAddArc(progressContext, xCenter, yCenter, Radius, 0, 2 * M_PI, 0);
    CGContextDrawPath(progressContext, kCGPathStroke);
    
    // 绘制环形进度环
    CGFloat to = self.progress * M_PI * 2;  // - M_PI * 0.5 为改变初始位置
    
    // 显示进度数字字号
    int fontNum = ViewWidth / 6;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Radius + 10, ViewWidth / 6)];
    label.center = CGPointMake(xCenter, yCenter);
    label.font = [UIFont boldSystemFontOfSize:fontNum];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"0%";
    [self addSubview:label];
    
    // 贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(xCenter, yCenter) radius:Radius startAngle:0 endAngle:to clockwise:YES];
    archLayer = [CAShapeLayer layer];
    archLayer.path = path.CGPath;
    archLayer.fillColor = [UIColor clearColor].CGColor;
    archLayer.strokeColor = [UIColor colorWithRed:227.0 / 255.0 green:91.0 / 255.0 blue:90.0 / 255.0 alpha:0.7].CGColor;
    archLayer.lineWidth = ProgressWidth;
    archLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:archLayer];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self drawLineAniamtion:archLayer];
    });
    
}

- (void)drawLineAniamtion:(CALayer *)layer
{

}

@end
