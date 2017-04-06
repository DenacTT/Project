//
//  CABaseAnimationDemo.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/4/1.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "CABaseAnimationDemo.h"

@interface CABaseAnimationDemo ()

@property (nonatomic, strong) UIImageView *imageView1;

@property (nonatomic, strong) UIImageView *imageView2;

@property (nonatomic, strong) UIImageView *bgView;

@end

@implementation CABaseAnimationDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.isUseBackBtn = YES;
    self.isUseRightBtn = YES;
    [self.rightBtn setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:self.imageView1];
    [self.view addSubview:self.imageView2];
    
    // 创建一个 View, 并获取其 CALayer
    // 初始化一个 CAAnimation 对象,并进行相关属性的设置
    // 通过调用 CALayer 的 addAnimation:forKey: 方法,增加 CAAnimation 对象到 CALayer 中, 添加完动画以后就能执行动画了.
    // 通过调用 CALayer 的 removeAnimationForKey: 方法可以停止 CALayer 中的动画.
    
}

- (void)clickRightBtn {
    
    // CABaseAnimation
    /******************
    CABasicAnimation *animation = [CABasicAnimation animation];
    //默认绕z轴旋转
    animation.keyPath = @"transform.rotation";
    //只设置 toValue, 动画会在图层对应当前值与 toValue 中间渐变
    animation.fromValue = @(0.1);
    animation.toValue = @(M_PI);
    //动画重复次数
    animation.repeatCount = 1;
    //动画自动逆向进行
    animation.autoreverses = YES;
    //设置动画持续时间
    animation.duration = 0.4;
    //将动画添加到layer上
    [self.imageView1.layer addAnimation:animation forKey:NSInvalidArgumentException];
    
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"transform.rotation";
    animation2.fromValue = @(0.1);
    animation2.byValue = @(M_PI_4);
    animation2.toValue = @(M_PI);
    
    animation2.beginTime = CACurrentMediaTime()+0.1;
    animation2.duration = 0.5;
    animation2.speed = 3;
    animation2.repeatCount = 1;
    animation2.autoreverses = NO;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.imageView2.layer addAnimation:animation2 forKey:NSInvalidArgumentException];
    ********************/
    
    
    // CAkeyframeAnimation
    /*******************
    // 摇一摇动画
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animation];
    //默认绕 z 轴转动
    shakeAnimation.keyPath = @"transform.rotation";
    //设置角度变化值
    CGFloat angle = M_PI_4/4;
    shakeAnimation.values  = @[@(angle), @(-angle), @(angle)];
    //设置关键帧动画每帧的执行时间，这里不设置也行，默认平均分配时间
    shakeAnimation.keyTimes = @[@0, @0.5, @1];
    //设置动画重复次数
    shakeAnimation.repeatCount = MAXFLOAT;
    //执行效果
//    shakeAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //相邻动画的过度方式
    shakeAnimation.calculationMode = kCAAnimationCubic;
    [self.imageView1.layer addAnimation:shakeAnimation forKey:nil];
    
    //创建贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 550)];
    [path addCurveToPoint:CGPointMake(300, 550) controlPoint1:CGPointMake(150, 450) controlPoint2:CGPointMake(250, 600)];
    //设置关键帧动画
    CAKeyframeAnimation *bezierAnimation = [CAKeyframeAnimation animation];
    bezierAnimation.path = path.CGPath;
    bezierAnimation.keyPath = @"position";
    bezierAnimation.duration = 5.f;
    bezierAnimation.rotationMode = kCAAnimationRotateAuto;//自动旋转 layer 角度与 path相切
    bezierAnimation.repeatCount = MAXFLOAT;
    bezierAnimation.autoreverses = YES;
    [self.imageView1.layer addAnimation:bezierAnimation forKey:nil];
    
    //缩放动画
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animation];
    scaleAnimation.keyPath  = @"transform.scale";
    scaleAnimation.values   = @[@0.0, @0.1, @1.05, @1.0, @0.1, @0.0];
    scaleAnimation.duration = 1.2;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = MAXFLOAT;
    [self.imageView2.layer addAnimation:scaleAnimation forKey:nil];
    *****************/
    
    
    //CAAnimationGroup
    
    CAKeyframeAnimation *starAnimation = [CAKeyframeAnimation animation];
    starAnimation.keyPath  = @"transform.scale";
    starAnimation.values   = @[@0.0, @0.1, @1.05, @0.1, @0.0];
    starAnimation.keyTimes = @[@0.0, @0.2, @0.8, @1.0];
    starAnimation.duration = 1.2;
    starAnimation.autoreverses = NO;
    starAnimation.repeatCount = MAXFLOAT;
    [self.imageView1.layer addAnimation:starAnimation forKey:nil];
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animation];
    scaleAnimation.keyPath  = @"transform.scale";
    scaleAnimation.values   = @[@0.0, @0.1, @1.05, @0.1, @0.0];
    scaleAnimation.keyTimes = @[@0.1, @0.2, @0.8, @1.0];
    scaleAnimation.duration = 1.2;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.repeatCount = MAXFLOAT;
    [self.imageView2.layer addAnimation:scaleAnimation forKey:nil];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 2;
    animationGroup.animations = @[starAnimation, scaleAnimation];
    animationGroup.repeatCount = MAXFLOAT;
    [self.bgView.layer addAnimation:animationGroup forKey:nil];
    
    
    // CATransition
    /********************
    CATransition *animation = [CATransition animation];
    //动画时间
    animation.duration = 2.0f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.removedOnCompletion = NO;
    //过渡效果
    animation.type = @"pageCurl";
    //过渡方向
    animation.subtype = kCATransitionFromRight;
    //动画停止(在整体动画的百分比).
    animation.endProgress = 0.7;
    [self.imageView1.layer addAnimation:animation forKey:nil];
    **********************/
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

#pragma mark - Getter
- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _imageView1.center = self.view.center;
        _imageView1.image = Image(@"sb_home_star");
    }
    return _imageView1;
}

- (UIImageView *)imageView2 {
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _imageView2.center = self.view.center;
        _imageView2.image = Image(@"sb_home_finish_yuan");
    }
    return _imageView2;
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _bgView.center = self.view.center;
    }
    return _bgView;
}

@end
