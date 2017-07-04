//
//  TransitionSecondController.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/7/3.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "TransitionSecondController.h"
#import "TransitionFirstController.h"
#import "PingInvertTransition.h"

@interface TransitionSecondController ()

@end

@implementation TransitionSecondController
{
    UIPercentDrivenInteractiveTransition *percentTransition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _button.frame = CGRectMake(10, ScreenHeight-74, 40, 40);
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 20;
//    _button.center = self.view.center;
    _button.backgroundColor = [UIColor orangeColor];
    [_button setTitle:@"pop" forState:(UIControlStateNormal)];
    
    [_button addTarget:self action:@selector(popController:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
    
    // 创建一个侧滑手势
    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    edgeGes.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgeGes];
}

- (void)popController:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

/// locationInView:和translationInView:的区别
- (void)edgePan:(UIPanGestureRecognizer *)gesture {
    
    // locationInView: 获取到的是手指点击屏幕实时的坐标点
    // translationInView: 获取到的是手指移动后相对于手势起始点的偏移量
    CGPoint point = [gesture locationInView:self.view];
    CGPoint transPoint = [gesture translationInView:self.view];
    NSLog(@"\n%f++++%f\n %f-----%f",point.x,point.y,transPoint.x,transPoint.y);
    
    CGFloat percent = [gesture translationInView:self.view].x / ScreenWidth;
    percent = MIN(1.0, (MAX(0.0, percent)));
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        percentTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        [percentTransition updateInteractiveTransition:percent];
    }else if (gesture.state == UIGestureRecognizerStateEnded ||
              gesture.state == UIGestureRecognizerStateCancelled) {
        if (percent > 0.5) {
            [percentTransition finishInteractiveTransition];
        } else {
            [percentTransition cancelInteractiveTransition];
        }
        percentTransition = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate = self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPop) {
        PingInvertTransition *pingInvert = [[PingInvertTransition alloc] init];
        return pingInvert;
    }else{
        return nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return percentTransition;
}


@end
