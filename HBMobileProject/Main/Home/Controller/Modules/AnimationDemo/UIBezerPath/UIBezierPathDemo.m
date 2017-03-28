//
//  UIBezierPathDemo.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/25.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//  http://www.jianshu.com/p/b561e208f51f

#import "UIBezierPathDemo.h"
#import "UIBezierPathView.h"

@interface UIBezierPathDemo ()

@end

@implementation UIBezierPathDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUseBackBtn  = YES;
    
    UIBezierPathView *bezView = [[UIBezierPathView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, ScreenWidth, ScreenHeight)];
    bezView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bezView];
    
    // 本文乃 UIBezierPath 学习笔记,采用 MarkDown 语法书写.具体转至UIBezierPathView.m文件中查看
    
    /***************** TopicMainList ***********************
     
     - 一, UIBezierPath 简介
     - 二, UIBezierPath 初始化方法
     - 三, UIBezierPath 常用属性说明
     - 四, UIBezierPath 构建Path方法
     - 五, 图形上下文中的路径操作
     - 六, 由简入繁绘制贝塞尔曲线
     - 七, 报错等相关信息说明
     - 八, 引用文献说明
     
     
     > ##### 一, UIBezierPath 简介
     
     **UIBezierPath(贝塞尔曲线)**,位于 UIKit 框架,使用此类可以定义简单的形状,如椭圆或者矩形,或者有多个直线和曲线段组成的形状.我们可以使用直线段去创建矩形和多边形,使用曲线段去创建弧(arc),圆或者其他复杂的曲线形状. 曲线定义: 起始点,终止点(锚点),控制点.通过调整控制点,贝塞尔曲线会发生变化.
     
     线性贝塞尔曲线函数中的t会经由起始点P0至终止点P1的B（t）所描述的曲线。例如当t=0.25时，B（t）即一条由点P0至P1路径的四分之一处。就像由0至1的连续t，B（t）描述一条由P0至P1的直线>
     
     二次贝塞尔曲线,为建构二次贝塞尔曲线,需要两个控制点Q0和Q1作为由0至1的控制:
     由P0至P1的控制点Q0,描述一条线性贝塞尔曲线;
     由P1至P2的控制点Q1,描述一条线性贝塞尔曲线;
     由Q0至Q1的连续点B（t）,描述一条二次贝塞尔曲线;
     
     更多关于贝塞尔曲线的介绍,可以参考[维基百科](http://www.wikiwand.com/zh-cn/%E8%B2%9D%E8%8C%B2%E6%9B%B2%E7%B7%9A)的相关介绍
     
     
     > ##### 二初始化方法
     
     // 初始化方法,需要用实例方法添加线条.使用比较多,可以根据需要任意定制样式,画任何我们想画的图形.
     + (instancetype)bezierPath;
     
     // 返回一个矩形 path
     + (instancetype)bezierPathWithRect:(CGRect)rect;
     
     // 返回一个圆形或者椭圆形 path
     + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;
     
     // 返回一个带圆角的矩形 path ,矩形的四个角都是圆角;
     + (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
     
     // 返回一个带圆角的矩形 path , UIRectCorner 枚举值可以设置只绘制某个圆角;
     + (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
     
     // 返回一段圆弧,参数说明: center: 弧线中心点的坐标 radius: 弧线所在圆的半径 startAngle: 弧线开始的角度值 endAngle: 弧线结束的角度值 clockwise: 是否顺时针画弧线.
     + (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
     
     // 用一条 CGpath 初始化
     + (instancetype)bezierPathWithCGPath:(CGPathRef)CGPath;
     
     // 返回一个反转当前路径的路径对象.(反方向绘制path)
     - (UIBezierPath *)bezierPathByReversingPath;
     
     
     > ##### 三, UIBezierPath 常用属性
     
     1.`CGPath`: 将`UIBezierPath`类转换成`CGPath`
     2.`currentPoint`: 当前path的位置，可以理解为path的**终点**
     3.`lineWidth`: 线条宽度
     4.`lineCapStyle`: 端点样式
     5.`lineJoinStyle`: 连接类型
     6.`flatness`: 绘线的精细程度，默认为0.6，数值越大，需要处理的时间越长
     7.`usesEvenOddFillRule`: 判断奇偶数组的规则绘制图像路径
     8.`miterLimit`: 最大斜接长度（只有在使用kCGLineJoinMiter是才有效,最大限制为10）， 边角的角度越小，斜接长度就会越大，为了避免斜接长度过长，使用lineLimit属性限制，如果斜接长度超过miterLimit，边角就会以KCALineJoinBevel类型来显示
     
     // lineCapStyle     // 端点类型
     kCGLineCapButt,     // 无端点
     kCGLineCapRound,    // 圆形端点
     kCGLineCapSquare    // 方形端点（样式上和kCGLineCapButt是一样的，但是比kCGLineCapButt长一点）
     
     // lineJoinStyle     // 交叉点的类型
     kCGLineJoinMiter,    // 尖角衔接
     kCGLineJoinRound,    // 圆角衔接
     kCGLineJoinBevel     // 斜角衔接
     
     // 为path绘制虚线，dash数组存放各段虚线的长度，count是数组元素数量，phase是起始位置
     // - setLineDash:count:phase:
     // - getLineDash:count:phase:
     
     
     > ##### 四, UIBezierPath 构建Path
     
     - (void)moveToPoint:(CGPoint)point;
     // 以 point点 开始作为起点, 一般用`+ (instancetype)bezierPath`创建的贝塞尔曲线，先用该方法标注一个起点，再调用其他的创建线条的方法来绘制曲线
     
     // 绘制二次贝塞尔曲线的关键方法,即从path的最后一点开始添加一条线到point点
     - (void)addLineToPoint:(CGPoint)point;
     
     // 绘制二次贝塞尔曲线的关键方法,和`-moveToPoint:`配合使用. endPoint为终止点,controlPoint为控制点.
     - (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
     
     // 绘制三次贝塞尔曲线的关键方法,以三个点画一段曲线. 一般和moveToPoint:配合使用.
     // 其中,起始点由`-moveToPoint:`设置,终止点位为`endPoint:`, 控制点1的坐标controlPoint1,控制点2的坐标是controlPoint2.
     - (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
     
     // 绘制一段圆弧, center:原点坐标,radius:半径,startAngle:起始角度,endAngle:终止角度,clockwise顺时针/逆时针方向绘制
     - (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
     
     // 闭合线
     - (void)closePath;
     
     // 移除所有的点,从而有效地删除所有子路径
     - (void)removeAllPoints;
     
     // 追加指定的bezierPath到路径上
     - (void)appendPath:(UIBezierPath *)bezierPath;
     
     // 用仿射变换矩阵变换路径的所有点
     - (void)applyTransform:(CGAffineTransform)transform;
     
     
     > ##### 五, 图形上下文中的路径操作
     
     // 填充路径
     - (void)fill;
     
     // 各个点连线
     - (void)stroke;
     
     // 填充模式, alpha 设置
     // blendMode : https://onevcat.com/2013/04/using-blending-in-ios/
     - (void)fillWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
     
     // 链接模式, alpha 设置
     - (void)strokeWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
     
     // 图形绘制超出当前路径范围,则不可见
     - (void)addClip;
     
     > ##### 六, 由简入繁绘制贝塞尔曲线
     1. 初始化一个 UIBezierPath 对象
     2. 设置相关的属性;
     3. 调用 `-moveToPoint:` 方法设置线段的起点;
     4. 添加线段或者曲线段去构建一个或者多个子路径;
     
     > ##### 七, 报错等相关信息说明
     
     
     > ##### 八, 引用文献说明
     [wikiwand](http://www.wikiwand.com/zh-cn/%E8%B2%9D%E8%8C%B2%E6%9B%B2%E7%B7%9A)
     [UIBezierPath 学习笔记](http://www.jianshu.com/p/31a509b06e71)
     UIBezierPath 通过贝塞尔曲线画圆环 创建一个环形进度指示器 http://blog.csdn.net/u013282507/article/details/50247001
     [CAShapeLayer](http://www.jianshu.com/p/01c0fdcbc44f)
     
     *******************************************************/
}


@end
