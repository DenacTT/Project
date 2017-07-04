//
//  VCTransitionDemoOne.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/7/4.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "VCTransitionDemoOne.h"
#import "VCTransitionDemoTwo.h"
#import "VCPushPopManager.h"

@interface VCTransitionDemoOne ()<UINavigationControllerDelegate>

@property (nonatomic, strong) VCPushPopManager *manager;
@property (nonatomic, strong) UIButton *button;

@end

@implementation VCTransitionDemoOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _button.frame = CGRectMake(10, 74, 40, 40);
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
    
    VCTransitionDemoTwo *vc = [[VCTransitionDemoTwo alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        self.manager.operation = operation;
        return _manager;
    }else{
        return nil;
    }
}

- (VCPushPopManager *)manager {
    if (!_manager) {
        _manager = [[VCPushPopManager alloc] init];
    }
    return _manager;
}

@end
