//
//  ConfigTabBarController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "ConfigTabBarController.h"
#import "CommonMacro.h"

@import Foundation;
@import UIKit;

@interface BaseNavigationController : UINavigationController
@end

@implementation BaseNavigationController

//当 push 到下级页面时隐藏底部的 tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end

#pragma mark - ConfigTabBarController

#import "DiscoverViewController.h"
#import "FollowViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

@interface ConfigTabBarController ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation ConfigTabBarController

/**
 *  @author HarbingWang, 16-09-06 20:09:51
 *
 *  loadTabBarController
 */
- (CYLTabBarController *)tabBarController
{
    if (_tabBarController == nil)
    {
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        [self customTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers
{
    DiscoverViewController *discoverViewController = [[DiscoverViewController alloc] init];
    UIViewController *discoverNavigationController = [[BaseNavigationController alloc] initWithRootViewController:discoverViewController];
    
    FollowViewController *followViewController = [[FollowViewController alloc] init];
    UIViewController *followNavigationController = [[BaseNavigationController alloc] initWithRootViewController:followViewController];
    
    MessageViewController *messageViewConreoller = [[MessageViewController alloc] init];
    UIViewController *messageNavigationController = [[BaseNavigationController alloc] initWithRootViewController:messageViewConreoller];
    
    MineViewController *mineViewController = [[MineViewController alloc] init];
    UIViewController *mineNavigationController = [[BaseNavigationController alloc] initWithRootViewController:mineViewController];
    
    NSArray *viewControllers = @[
                                 discoverNavigationController,
                                 followNavigationController,
                                 messageNavigationController,
                                 mineNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController
{
    NSDictionary *discoverTabBarItemAttributes = @{
                                                   CYLTabBarItemTitle : @"发现",
                                                   CYLTabBarItemImage : @"home_normal",
                                                   CYLTabBarItemSelectedImage : @"home_highlight",
                                                   };
    
    NSDictionary *followTabBarItemAttributes = @{
                                                 CYLTabBarItemTitle : @"关注",
                                                 CYLTabBarItemImage : @"mycity_normal",
                                                 CYLTabBarItemSelectedImage : @"mycity_highlight",
                                                 };
    
    NSDictionary *messageTabBarItemAttributes = @{
                                                 CYLTabBarItemTitle : @"消息",
                                                  CYLTabBarItemImage : @"message_normal",
                                                  CYLTabBarItemSelectedImage : @"message_highlight",
                                                  };
    
    NSDictionary *mineTabBarItemAttributes = @{
                                              CYLTabBarItemTitle : @"我的",
                                               CYLTabBarItemImage : @"account_normal",
                                               CYLTabBarItemSelectedImage : @"account_highlight"
                                               };
    
    NSArray *tabBarItemsAttributes = @[
                                       discoverTabBarItemAttributes,
                                       followTabBarItemAttributes,
                                       messageTabBarItemAttributes,
                                       mineTabBarItemAttributes
                                       ];
    return tabBarItemsAttributes;
}

- (void)customTabBarAppearance:(CYLTabBarController *)tabBarController
{
    tabBarController.tabBarHeight = 40.f;
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:Image(@"tapbar_top_line")];
    
}

@end
