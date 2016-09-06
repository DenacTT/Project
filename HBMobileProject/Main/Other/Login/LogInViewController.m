//
//  LogInViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "LogInViewController.h"

@implementation LogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //登录成功后跳转到首页
    [((AppDelegate *)AppDelegateInstance) setupHomeViewController];
    
}

@end
