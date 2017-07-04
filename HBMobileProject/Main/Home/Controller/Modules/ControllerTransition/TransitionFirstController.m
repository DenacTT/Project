//
//  TransitionFirstController.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/7/3.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "TransitionFirstController.h"
#import "TransitionSecondController.h"
#import "PingTransition.h"

@interface TransitionFirstController ()

@end

@implementation TransitionFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _button.frame = CGRectMake(10, ScreenHeight-74, 40, 40);
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 20;
//    _button.center = self.view.center;
    _button.backgroundColor = [UIColor lightGrayColor];
    [_button setTitle:@"push" forState:(UIControlStateNormal)];
    
    [_button addTarget:self action:@selector(pushController:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate = self;
}

- (void)pushController:(UIButton *)button  {
    
    TransitionSecondController *secondVC = [[TransitionSecondController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        PingTransition *ping = [[PingTransition alloc] init];
        return ping;
    }else{
        return nil;
    }
}

@end
