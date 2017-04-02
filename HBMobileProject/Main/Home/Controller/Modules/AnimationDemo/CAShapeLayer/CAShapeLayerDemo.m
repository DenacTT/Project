//
//  CAShapeLayerDemo.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/27.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "CAShapeLayerDemo.h"
#import "LXCircleAnimationView.h"
#import "CircleView.h"

@interface CAShapeLayerDemo ()

@property (nonatomic, strong) CAShapeLayer *shapLayer;

@property (nonatomic, strong) LXCircleAnimationView *circleProgressView;

@property (nonatomic, strong) CircleView *circleView;

@end

@implementation CAShapeLayerDemo
{
    double _time;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUseBackBtn = YES;
    self.isUseRightBtn = YES;
    [self.rightBtn setTitle:@"开始" forState:UIControlStateNormal];
    
    /**********************
     
    > ##### 1.CAShapeLayer简介
    **CAShapeLayer** 是一个通过矢量图形来绘制的图层子类,继承自**CALayer**,这意味着他可以使用 CALayer 所有的属性值来可以指定颜色、线宽等属性，但不同于CALayer的是:CAShapeLayer需要用 CGPath 来定义想要绘制的图形,最后 CAShapeLayer 才能渲染出来了.
     1.CAShapeLayer继承自CALayer,意味着它可以使用 CALayer 所有的属性值;
     2.CAShapeLayer需要与 UIBezierPath 配合使用才有意义,才能呈现出效果,UIBezierPath 与 CAShapeLayer 可以比喻为骨肉的关系.
     3.在上篇文章[iOS UIBezierPath(贝塞尔曲线)](http://www.jianshu.com/p/b561e208f51f)中,我们使用 UIBezierPath 绘制图形的时候,需要在 View 的`-drawRect`方法中才能绘制.使用 CAShapeLayer 与 UIBezierPath 可以不在`-drawRect`方法中随心所欲绘制出一些想要的效果.
     4.CAShapeLayer (属于CoreAnimation框架)直接提交到手机的 GPU 中,直接使用硬件加速渲染图形.相较于View的 drawRect方法(属于CoreGraphic框架)使用 CPU 渲染而言,其效率极高,能够大大优化内存使用情况.关于`drawRect`方法与 CAShapeLayer绘图在内存消耗方面的详细分析,可以参考[内存恶鬼drawRect](http://bihongbo.com/2016/01/03/memoryGhostdrawRect )
    
     > ##### 2.UIBezierPath 与 CAShapeLayer 的关系
     1，CAShapeLayer中shape代表形状的意思，所以需要形状才能生效;
     2，UIBezierPath 可以创建基于矢量的路径;
     3，UIBezierPath 给 CAShapeLayer 提供路径，CAShapeLayer 在提供的路径中进行渲染。路径会闭环，所以绘制出了Shape;
     4，用于 CAShapeLayer 的 UIBezierPath 作为Path，其path是一个首尾相接的闭环的曲线，即使该贝塞尔曲线不是一个闭环的曲线;
     
     > ##### 3.CAShapeLayer 常见属性
     
     // CAShapeLayer 绘制的路径
     @property(nullable) CGPathRef path;
     
     //路径中的填充颜色
     @property(nullable) CGColorRef fillColor;
     
     //填充规则
     @property(copy) NSString *fillRule;
     
     //画笔颜色（路径的颜色，边框颜色）
     @property(nullable) CGColorRef strokeColor;
     
     //这是一组范围值，路径绘制开始和结束的范围（0 -> 1）,常用于动画,进度条动画就是用了CAShapeLayer的这两个属性来做的，keyPath为@"strokeEnd"
     @property CGFloat strokeStart;
     @property CGFloat strokeEnd;
     
     //设置虚线显示的起点距离，设置为8，则显示长度8之后的线
     @property CGFloat lineDashPhase;
     
     //设置虚线线段的长度和空格的长度，@[@20,@30,@40,@50],画20空30画40空50
     @property(nullable, copy) NSArray *lineDashPattern;
     
     // 线条宽度
     @property CGFloat lineWidth;
     
     // 端点.交叉点类型
     @property(copy) NSString *lineCap;
     @property(copy) NSString *lineJoin;
     
     // lineCapStyle     // 端点类型
     kCGLineCapButt,     // 无端点
     kCGLineCapRound,    // 圆形端点
     kCGLineCapSquare    // 方形端点（样式上和kCGLineCapButt是一样的，但是比kCGLineCapButt长一点）
     
     // lineJoinStyle     // 交叉点的类型
     kCGLineJoinMiter,    // 尖角衔接
     kCGLineJoinRound,    // 圆角衔接
     kCGLineJoinBevel     // 斜角衔接
     
     // 最大斜接长度
     @property CGFloat miterLimit;// 最大斜接长度（只有在使用kCGLineJoinMiter是才有效,最大限制为10）， 边角的角度越小，斜接长度就会越大，为了避免斜接长度过长，使用lineLimit属性限制，如果斜接长度超过miterLimit，边角就会以KCALineJoinBevel类型来显示
     
     > ##### 4.CAShapeLayer 绘图实现:
     
     > ##### 文献参考:
     [](http://www.cocoachina.com/ios/20160711/17007.html)
     // http://www.cocoachina.com/ios/20160214/15251.html
     // http://www.cocoachina.com/ios/20161202/18252.html
     // 内存恶鬼drawRect http://bihongbo.com/2016/01/03/memoryGhostdrawRect/
     
     **********************/
    
//    // 创建 CAShapeLayer
//    self.shapLayer = [CAShapeLayer layer];
//    _shapLayer.frame = CGRectMake(50, 100, 200, 200);
//    _shapLayer.lineWidth = 2.f;
//    _shapLayer.fillColor = [UIColor whiteColor].CGColor;
//    _shapLayer.strokeColor = [UIColor orangeColor].CGColor;
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_shapLayer.frame];
//    _shapLayer.path = path.CGPath;
//    [self.view.layer addSublayer:_shapLayer];
//    
//    // 设置 stock 起点
//    _shapLayer.strokeStart = 0;
//    _shapLayer.strokeEnd = 0.75;
    
    self.view.backgroundColor = [UIColor blackColor];
    self.circleProgressView = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake(40.f, 70.f, ScreenWidth - 80.f, ScreenWidth - 80.f)];
    self.circleProgressView.bgImage = [UIImage imageNamed:@"sb_home_star@2x"];
    //调用此方法
    self.circleProgressView.percent = 88.f;
    [self.view addSubview:self.circleProgressView];
    
    
    self.circleView = [CircleView circleViewWithFrame:CGRectMake(self.view.center.x-50, 400, 100, 100)
                                             lineWidth:2
                                             lineColor:[UIColor grayColor]
                                             clockWise:YES
                                            startAngle:0];
    [self.view addSubview:_circleView];
}

- (void)clickRightBtn {
    _shapLayer.strokeStart = 0;
    _shapLayer.strokeEnd = 0;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeatCycle) userInfo:nil repeats:YES];
    
    CGFloat percent        = arc4random() % 100 / 100.f;
    CGFloat anotherPercent = arc4random() % 100 / 100.f;
    CGFloat largePercent   = (percent < anotherPercent ? anotherPercent : percent);
    [self.circleView strokeEnd:largePercent animationType:ElasticEaseInOut animated:YES duration:2.f];
}

- (void)repeatCycle {
    CGFloat oneValue =  arc4random() % 100 /100;
    CGFloat twoValue =  arc4random() % 100 /100;
    
    self.shapLayer.strokeStart = MIN(oneValue, twoValue);
    self.shapLayer.strokeEnd = MAX(oneValue, twoValue);
}

@end
