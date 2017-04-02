//
//  CABaseAnimationDemo.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/4/1.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "CABaseAnimationDemo.h"

@interface CABaseAnimationDemo ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CABaseAnimationDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.isUseBackBtn = YES;
    self.isUseRightBtn = YES;
    [self.rightBtn setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:self.imageView];
    
// http://www.jianshu.com/p/679d1e552dc0#
// http://www.jianshu.com/p/d05d19f70bac#
//  动画类继承关系
//                                            |--- CASBaseAnimation (.formValue .toValue)
//                |--- CAPropertyAnimation ---|
//                |                           |--- CAKeyframeAnimation (.values .path .keyTimes)
//                |
// CAAnimation----|--- CAAnimationGroup (.animations)
//                |
//                |
//                |--- CATransition (.filter)
//
    
    // 简介: CAAnimation,所有动画的基类,不能直接使用.
    // 1. CAPropertyAnimation 属性动画,也是一个基类,包含有: CABaseAnimation 和 CAKeyframeAnimation 两个子类, 通过控制属性值变化来产生动画.
    // 2. CAAnimationGroup 动画组, 可以同时添加多种动画.
    // 3. CATransition 转场动画,给视图切换的时候添加动画效果.
    
    
    // 创建一个 View, 并获取其 CALayer
    // 初始化一个 CAAnimation 对象,并进行相关属性的设置
    // 通过调用 CALayer 的 addAnimation:forKey: 方法,增加 CAAnimation 对象到 CALayer 中, 添加完动画以后就能执行动画了.
    // 通过调用 CALayer 的 removeAnimationForKey: 方法可以停止 CALayer 中的动画.
    
    
    // CAPropertyAnimation
    /* 
     CAPropertyAnimation, 是 CAAnimation 的子类,是一个抽象类,想要创建动画对象,需要使用它的两个子类: CABaseAnimation 和 CAKeyframeAnimation  
     属性介绍:
     - keyPath: 通过指定 CALayer 的一个属性名称为 keyPath (NSString类型),并对 CALayer 的这个属性的值进行修改,达到相应的动画效果.
     -
    */
    
    
}


- (void)clickRightBtn {
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.toValue = @0.5;
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses = YES;
    animation.duration = 0.25;
    
    [self.imageView.layer addAnimation:animation forKey:NSInvalidArgumentException];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _imageView.center = self.view.center;
        _imageView.image = Image(@"sb_home_finish_yuan");
    }
    return _imageView;
}

@end
