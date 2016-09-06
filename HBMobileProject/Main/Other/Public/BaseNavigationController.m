//
//  BaseNavigationController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // 隐藏第二级底部的 tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
