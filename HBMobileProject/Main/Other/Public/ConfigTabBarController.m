//
//  ConfigTabBarController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "ConfigTabBarController.h"
//#import "CommonMacro.h"

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

#import "HomeViewController.h"
#import "DiscoverViewController.h"
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
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    UIViewController *homeNavigationController = [[BaseNavigationController alloc] initWithRootViewController:homeViewController];
    
    DiscoverViewController *discoverViewController = [[DiscoverViewController alloc] init];
    UIViewController *discoverNavigationController = [[BaseNavigationController alloc] initWithRootViewController:discoverViewController];
    
    MessageViewController *messageViewConreoller = [[MessageViewController alloc] init];
    UIViewController *messageNavigationController = [[BaseNavigationController alloc] initWithRootViewController:messageViewConreoller];
    
    MineViewController *mineViewController = [[MineViewController alloc] init];
    UIViewController *mineNavigationController = [[BaseNavigationController alloc] initWithRootViewController:mineViewController];
    
    NSArray *viewControllers = @[
                                 homeNavigationController,
                                 discoverNavigationController,
                                 messageNavigationController,
                                 mineNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController
{
    NSDictionary *homeTabBarItemAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"tabbar_home_os7",
                                                 CYLTabBarItemSelectedImage : @"tabbar_home_selected_os7",
                                                 };
    
    NSDictionary *discoverTabBarItemAttributes = @{
                                                   CYLTabBarItemTitle : @"发现",
                                                   CYLTabBarItemImage : @"tabbar_discover_os7",
                                                   CYLTabBarItemSelectedImage : @"tabbar_discover_selected_os7",
                                                   };
    
    NSDictionary *messageTabBarItemAttributes = @{
                                                 CYLTabBarItemTitle : @"消息",
                                                  CYLTabBarItemImage : @"tabbar_message_center_os7",
                                                  CYLTabBarItemSelectedImage : @"tabbar_message_center_selected_os7",
                                                  };
    
    NSDictionary *mineTabBarItemAttributes = @{
                                              CYLTabBarItemTitle : @"我的",
                                               CYLTabBarItemImage : @"tabbar_profile_os7",
                                               CYLTabBarItemSelectedImage : @"tabbar_profile_selected_os7"
                                               };
    
    NSArray *tabBarItemsAttributes = @[
                                       homeTabBarItemAttributes,
                                       discoverTabBarItemAttributes,
                                       messageTabBarItemAttributes,
                                       mineTabBarItemAttributes
                                       ];
    return tabBarItemsAttributes;
}

- (void)customTabBarAppearance:(CYLTabBarController *)tabBarController
{
    tabBarController.tabBarHeight = 44.f;
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setBackgroundImage:Image(@"tabbar_background_os7")];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:Image(@"tabbar_background_os7")];
}

@end
