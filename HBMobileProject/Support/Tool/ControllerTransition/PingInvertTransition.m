//
//  PingInvertTransition.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/7/3.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "PingInvertTransition.h"
#import "TransitionFirstController.h"
#import "TransitionSecondController.h"

@implementation PingInvertTransition

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

/*
 1、我们需要得到参与切换的两个ViewController的信息，使用context的方法拿到它们的参照
 2、将控制器的view添加到containerView中
 3、设置转场动画的方向,路线
 4、开始转场动画
 5、在动画结束后我们必须向context报告VC切换完成，是否成功.系统在接收到这个消息后，将对VC状态进行维护.
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    
    TransitionSecondController *fromVC = (TransitionSecondController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    TransitionFirstController *toVC = (TransitionFirstController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    // 将控制器的view添加到containerView中,尤其需要注意添加的顺序.
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    UIButton *button = fromVC.button;
    CGPoint finalPoint;
    //判断触发点在哪个象限
    if(button.frame.origin.x > (toVC.view.bounds.size.width / 2)){
        if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第一象限
            finalPoint = CGPointMake(button.center.x, button.center.y - CGRectGetMaxY(toVC.view.bounds));
        }else{
            //第四象限
            finalPoint = CGPointMake(button.center.x, button.center.y);
        }
    }else{
        if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第二象限
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - CGRectGetMaxY(toVC.view.bounds));
        }else{
            //第三象限
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - 0);
        }
    }
    
    CGFloat radius = sqrt(finalPoint.x * finalPoint.x + finalPoint.y * finalPoint.y);
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalPath.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pingAnimation.fromValue = (__bridge id)(startPath.CGPath);
    pingAnimation.toValue   = (__bridge id)(finalPath.CGPath);
    pingAnimation.duration  = [self transitionDuration:transitionContext];
    pingAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pingAnimation.delegate = self;
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert"];
    
//    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    alphaAnimation.fromValue = @(1);
//    alphaAnimation.toValue   = @0;
//    alphaAnimation.duration  = [self transitionDuration:transitionContext];
//    alphaAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    alphaAnimation.delegate = self;
    
//    [maskLayer addAnimation:alphaAnimation forKey:@"alphaAnimation"];
    
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}


@end
