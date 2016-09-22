//
//  AppDelegate.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "AppDelegate.h"
#import "LogInViewController.h"
#import "ConfigTabBarController.h"

#import <QPSDK/QPSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    AppDelegateHelper *appDelegateHelper = [[AppDelegateHelper alloc] init];
    /* 配置趣拍 */
    [appDelegateHelper qupaiSDKSetup];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupLoginViewController];
    [self setupNavigationBarAppearance];
    
    return YES;
}

#pragma mark - setUpLoginViewController
//登录页
- (void)setupLoginViewController
{
    LogInViewController *logInViewController = [[LogInViewController alloc] init];
    [self.window setRootViewController:logInViewController];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
}

//首页
- (void)setupHomeViewController
{
    ConfigTabBarController *tabBarController = [[ConfigTabBarController alloc] init];
    [self.window setRootViewController:tabBarController.tabBarController];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
}

/**
 *  设置 navigationBar 样式
 */
- (void)setupNavigationBarAppearance
{
//    UINavigationBar *navigationBarApppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = Image(@"navigationbar_background_tall");
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: RGB(240, 240, 240),
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    //    [navigationBarAppearance setBackgroundImage:backgroundImage
    //                                  forBarMetrics:UIBarMetricsDefault];
    //    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
