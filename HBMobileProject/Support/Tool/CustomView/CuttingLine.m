//
//  CuttingLine.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/14.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//   https://my.oschina.net/227/blog/387122
//   http://www.cnblogs.com/wendingding/p/3782489.html

#import "CuttingLine.h"

@implementation CuttingLine

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _pointPerCount = 1.f;
        _pointAglinCount = 2.f;
    }
    return self;
}

/**
 * 画线的三个步骤:
 * 获取上下文
 * 绘图
 * 渲染
 */
- (void)drawRect:(CGRect)rect
{
    // 1.获取上下文
    CGContextRef kContext = UIGraphicsGetCurrentContext();
    
    // 1.1属性设置
    /* 设置线条两端为圆角 */
    CGContextSetLineCap(kContext, kCGLineCapRound);
    
    /* 设置kContext 是否允许抗锯齿 */
    CGContextSetAllowsAntialiasing(kContext, YES);
    CGContextSetStrokeColorWithColor(kContext, [self strokeColor].CGColor);
    
    /* 设置细线块粒大小 */
    CGFloat lengths[] = {_pointPerCount, _pointAglinCount};
    CGContextSetLineDash(kContext, 0, lengths, 2);
    
    // 2.绘图
    CGContextMoveToPoint(kContext, 0, self.height);
    CGContextAddLineToPoint(kContext, self.frame.size.width, self.height);
    
    // 3.渲染
    CGContextStrokePath(kContext);
}

@end
