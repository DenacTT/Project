//
//  StatusBarHUD.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "StatusBarHUD.h"

static UIWindow *window;
static NSTimer *timer;
static CGFloat const StatusBarHeight = 20;

static CGFloat const AnimationDuration = 0.25;
static CGFloat const HUDStayDuration = 1.5;

@implementation StatusBarHUD

+ (void)showImage:(UIImage *)image text:(NSString *)text
{
    // 停止之前的定时器
    [timer invalidate];
    
    // 创建窗口
    window.hidden = YES;
    
    window = [[UIWindow alloc] init];
    window.backgroundColor = [UIColor blackColor];
    window.alpha = 0.8;
    window.windowLevel = UIWindowLevelAlert; // 设置 window 的优先级 LevelAlert为最高级
    window.frame = CGRectMake(0, 0, ScreenWidth, StatusBarHeight);
    window.hidden = NO;
    
    // 添加按钮
    UIButton *button = [[UIButton alloc] init];
    button.frame = window.bounds;
    
    // 文字
    [button setTitle:text forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    // 图片
    if (image) {
        [button setImage:image forState:(UIControlStateNormal)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    }
    [window addSubview:button];
    
    // 动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        CGRect frame = window.frame;
        frame.origin.y = 0;
        window.frame = frame;
    }];
    
    // 开启一个新的定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:HUDStayDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

+ (void)showImageName:(NSString *)imageName text:(NSString *)text
{
    [self showImage:Image(imageName) text:text];
}

+ (void)showSuccess:(NSString *)text
{
    [self showImageName:@"StatusBarHUD.bundle/success" text:text];
}

+ (void)showError:(NSString *)text
{
    [self showImageName:@"StatusBarHUD.bundle/error" text:text];
}

+ (void)showText:(NSString *)text
{
    [self showImageName:nil text:text];
}

+ (void)showLoading:(NSString *)text
{
    // 创建窗口
    window.hidden = YES;
    
    window = [[UIWindow alloc] init];
    window.backgroundColor = [UIColor blackColor];
    window.windowLevel = UIWindowLevelAlert; // 设置 window 的优先级 LevelAlert为最高级
    window.frame = CGRectMake(0, 0, ScreenWidth, StatusBarHeight);
    window.hidden = NO;
    
    // 添加按钮
    UIButton *button = [[UIButton alloc] init];
    button.frame = window.bounds;
    
    // 文字
    [button setTitle:text forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    [window addSubview:button];
    
    // 菊花
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    [loadingView setCenter:CGPointMake(button.titleLabel.frame.origin.x - 60, StatusBarHeight * 0.5)];
    [window addSubview:loadingView];
    
    // 动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        CGRect frame = window.frame;
        frame.origin.y = 0;
        window.frame = frame;
    }];
    
}

+ (void)hide
{
    // 挂掉定时器
    [timer invalidate];
    timer = nil;
    
    // 退出动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        CGRect frame = window.frame;
        frame.origin.y = -StatusBarHeight;
        window.frame = frame;
    } completion:^(BOOL finished) {
        window = nil;
    }];
}

@end
