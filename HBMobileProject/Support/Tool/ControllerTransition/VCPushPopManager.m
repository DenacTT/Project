//
//  VCPushPopManager.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/7/4.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "VCPushPopManager.h"

@implementation VCPushPopManager

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    switch (self.operation) {
        case UINavigationControllerOperationPush:
        {
            CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            toVC.view.frame = frame;
            toVC.view.alpha = 0.f;
            [containerView addSubview:toVC.view];
            
            [UIView animateWithDuration:duration animations:^{
                toVC.view.alpha = 1.f;
            } completion:^(BOOL finished) {
                [fromVC.view removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
        }
            break;
        case UINavigationControllerOperationPop:
        {
            [containerView insertSubview:toVC.view belowSubview:fromVC.view];//将toVC的view添加到fromVC的下面,作为fromVC的子视图.
            CGRect frame = [transitionContext initialFrameForViewController:fromVC];
            fromVC.view.frame = frame;
            [UIView animateWithDuration:duration animations:^{
                fromVC.view.frame = CGRectMake(0, frame.origin.y+ScreenHeight, ScreenWidth, ScreenHeight);
            } completion:^(BOOL finished) {
                [fromVC.view removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
        }
            break;
            
        default:
            break;
    }
}

@end
