//
//  PingTransition.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/7/3.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "PingTransition.h"
#import "TransitionFirstController.h"
#import "TransitionSecondController.h"

@implementation PingTransition

#pragma mark - UIViewControllerAnimatedTransitioning
// 返回动画的时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

// 在进行切换的时候将调用该方法，对于切换时的UIView的设置和动画都在这个方法中完成
/*
 1、通过转场的上下文transitionContext可以获取到转场前后的ViewController,从而拿到转场前后的view
 2、将控制器的view添加到containerView中,containerView是用来将转场前后的view添加进去来进行,动画初始frame和最后frame等的设置都在这个方法中实现.
 3、设置转场动画的方向,路线.
 4、开始转场动画;
 5、动画结束后,我们必须向context报告VC切换完成，是否成功.系统在接收到这个消息后，将对VC状态进行维护.
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    
    // 获取到两个ViewController
    TransitionFirstController *fromVC = (TransitionFirstController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    TransitionSecondController *toVC = (TransitionSecondController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 将控制器的view添加到containerView中,尤其需要注意添加的顺序.
    UIView *contView = [transitionContext containerView];
    [contView addSubview:fromVC.view];
    [contView addSubview:toVC.view];
    
    // 创建两个圆形的UIBezierPath实例:一个是button的size,另外一个则拥有足够覆盖屏幕的半径,最终的动画则是在这两个贝塞尔路径之间进行的.
    UIButton *button = fromVC.button;
    CGPoint finalPoint;
    // 判断触发点在那个象限
    if(button.frame.origin.x > (toVC.view.bounds.size.width / 2)){
        if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第一象限
            finalPoint = CGPointMake(button.center.x, button.center.y - CGRectGetMaxY(toVC.view.bounds) + button.height/2);
        }else{
            //第四象限
            finalPoint = CGPointMake(button.center.x, button.center.y);
        }
    }else{
        if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第二象限
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - CGRectGetMaxY(toVC.view.bounds) + button.height/2);
        }else{
            //第三象限
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - 0);
        }
    }
    
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));
    UIBezierPath *maskStartPath = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    UIBezierPath *maskFinalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    // 创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalPath.CGPath;//将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    toVC.view.layer.mask = maskLayer;
    
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalPath.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];//时长和转场时长保持一致.
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationEnded:(BOOL) transitionCompleted {
    
}

#pragma mark - CABasicAnimation
/// 动画完成后的一些清理工作.
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    // 告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:![self. transitionContext transitionWasCancelled]];
    // 清除 fromVC 的 mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
