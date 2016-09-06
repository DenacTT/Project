//
//  AppDelegate.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//登录首页
- (void)setupLoginViewController;

//跳转到首页
- (void)setupHomeViewController;

@end

