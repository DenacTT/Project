//
//  UIBezierPathView.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/25.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "UIBezierPathView.h"

#define kLineW ScreenWidth-10*2
#define kMargin 10

@implementation UIBezierPathView

// 重写 drawRect 方法
- (void)drawRect:(CGRect)rect {
    
    //由于UIBezierPath绘制出来的是矢量图形(即layer路径)并不能真正的展示出来,因此,想让它显示在图层上,需要设置线条颜色
    [[UIColor orangeColor] set];
    
    // 示例代码:
    // 1. 绘制一条直线,即一次贝塞尔曲线
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 1.f;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    path.miterLimit = 10.f;
    path.flatness = 10.f;
    path.usesEvenOddFillRule = YES;
    // 设置起始点
    [path moveToPoint:CGPointMake(kMargin, kMargin)];
    // 添加子路径
    [path addLineToPoint:CGPointMake(kLineW, kMargin)];//添加一条子路径
    // 根据坐标点连线
    [path stroke];
    
    // 2.绘制一条折线,其实就是增加一个端点
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(kMargin, kMargin*2)];
    [path1 addLineToPoint:CGPointMake(kLineW, kMargin*2)];//添加一条子路径
    [path1 addLineToPoint:CGPointMake(kLineW, kMargin*3)];//添加两条子路径
    [path1 closePath];//当构建子路径数>=2条时,可以调用`closePath`方法来闭合路径.
    [path1 stroke];
    
    // 3.绘制一个矩形
    // 方法1: 类似上面,用点去绘制;
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(kMargin, kMargin*4)];
    [path2 addLineToPoint:CGPointMake(kLineW, kMargin*4)];
    [path2 addLineToPoint:CGPointMake(kLineW, kMargin*5)];
    [path2 addLineToPoint:CGPointMake(kMargin, kMargin*5)];
    [path2 stroke];
    
    // 方法2: 初始化方法直接绘制
    UIBezierPath *path3 = [UIBezierPath bezierPathWithRect:CGRectMake(kMargin, kMargin*6, kLineW, kMargin*5)];
    [path3 fill];// 设置填充
    [path3 stroke];
    
    // 4. 绘制带圆角的矩形
    UIBezierPath *path4 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kMargin, kMargin*13, kLineW, kMargin*5) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(kMargin, kMargin)];
    [path4 fillWithBlendMode:kCGBlendModeMultiply alpha:0.3];
    [path4 stroke];
    
    // 5. 绘制椭圆
    UIBezierPath *path5 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.center.x-100, kMargin*20, 200, 50)];
    [path5 fillWithBlendMode:kCGBlendModeOverlay alpha:0.5];
    [path5 stroke];
    
    // 6. 绘制圆形
    UIBezierPath *path6 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kMargin*5, kMargin*26, 100, 100)];
    [path6 stroke];
    
    // 7. 绘制一段圆弧
    UIBezierPath *path7 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kMargin*30, kMargin*31) radius:50 startAngle:1.5*3.1415926 endAngle:3.1415926 clockwise:YES];
    [path7 stroke];
    
    // 8.绘制扇形
    UIBezierPath * path8 = [UIBezierPath bezierPath]; // 创建路径
    [path8 moveToPoint:CGPointMake(100, kMargin*45)]; // 设置起始点
    [path8 addArcWithCenter:CGPointMake(100, kMargin*45) radius:50 startAngle:0 endAngle:3.14159/2 clockwise:NO];
    //[[UIColor lightGrayColor] setStroke];
    //[[UIColor lightGrayColor] setFill];
    [path8 closePath];
    [path8 stroke];
    [path8 fill];
    
    // 8. 绘制竖直虚线
    UIBezierPath *verticalLinePath = [UIBezierPath bezierPath];
    CGFloat dash[] = {3.0, 3.0};
    [verticalLinePath setLineDash:dash count:2 phase:0.0];
    [verticalLinePath moveToPoint: CGPointMake(5, 0)];
    [verticalLinePath addLineToPoint: CGPointMake(5, ScreenHeight*2)];
    [verticalLinePath stroke];
    
    // 9.绘制二次贝塞尔曲线
    UIBezierPath *path9 = [UIBezierPath bezierPath];
    [path9 moveToPoint:CGPointMake(250, 450)];
    [path9 addQuadCurveToPoint:CGPointMake(350, 450) controlPoint:CGPointMake(300, 550)];
    [path9 stroke];
    
    // 10.绘制三次贝塞尔曲线
    UIBezierPath *path10 = [UIBezierPath bezierPath];
    [path10 moveToPoint:CGPointMake(50, 550)];
    [path10 addCurveToPoint:CGPointMake(300, 550) controlPoint1:CGPointMake(150, 450) controlPoint2:CGPointMake(250, 600)];
    [path10 stroke];
    
    
    // 由于UIBezierPath绘制出来的是矢量图形(即layer路径)并不能真正的展示出来,因此,想让它显示在图层上,需要设置线条颜色,有以下方法:
    // 1.直接设置 color, 相对局限
    // [[UIColor orangeColor] set];
    
    // 2. 和 CAShapeLayer 搭配使用, shape外形,顾名思义就是用来呈现layer外形的.
    // http://www.jianshu.com/p/01c0fdcbc44f
    //UIBezierPath *pathA = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 100, 100)];
    //CAShapeLayer *layerA = [[CAShapeLayer alloc] init];
    // 设置线条宽度
    //layerA.lineWidth = 1.f;
    // 线条填充色
    //layerA.strokeColor = [UIColor orangeColor].CGColor;
    // 背景填充色
    //layerA.fillColor = [UIColor whiteColor].CGColor;
    // 设置路径
    //layerA.path = path.CGPath;
    //[self.layer addSublayer:layerA];
}

@end
