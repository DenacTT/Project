//
//  YMActionSheetViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/1/20.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "YMActionSheetViewController.h"
#import "YMActionSheet.h"
#import "ShowHUD.h"
#import "YMUITipsView.h"

@implementation YMActionSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)normalActionSheet:(UIButton *)sender {
    
    YMActionSheet *actionSheet = [YMActionSheet actionSheetViewWithTitle:@"温馨提示"
                                                             cancelTitle:@"取消"
                                                        destructiveTitle:@"确定"
                                                             otherTitles:@[@"第一项", @"第二项"]
                                                             otherImages:@[[UIImage imageNamed:@"UMS_wechat_session_icon"], [UIImage imageNamed:@"UMS_wechat_timeline_icon"]]
                                                             selectBlock:^(YMActionSheet *actionSheet, NSInteger index) {
                                                                 NSLog(@"%zi", index);
                                                             }];
    actionSheet.otherActionItemAlignment = YMOtherActionItemAlignmentCenter;
    [actionSheet show];
}

// 显示文本和菊花,延时3秒后消失
- (IBAction)mbProgressHud:(UIButton *)sender {
    [ShowHUD showText:@"加载成功" configParameter:^(ShowHUD *config) {
        config.margin          = 35.f;      // 边缘留白
        config.opacity         = 1.f;       // 设定透明度
        config.cornerRadius    = 5.f;       // 设定圆角
        config.textFont        = [UIFont systemFontOfSize:14.f];
    } duration:1.5 inView:[UIApplication sharedApplication].keyWindow];
}

// 仅仅显示文本,延时3秒后消失
- (IBAction)showHud01:(id)sender {
    [ShowHUD showTextOnly:@"加载失败" configParameter:^(ShowHUD *config) {
        config.animationStyle  = Fade;      // 设置动画方式
        config.margin          = 20.f;      // 边缘留白
        config.opacity         = 1.f;       // 设定透明度
        config.cornerRadius    = 5.f;       // 设定圆角
        config.cornerRadius    = 5.f;       // 设定圆角
        config.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];// 设置背景色
        config.labelColor      = [[UIColor whiteColor] colorWithAlphaComponent:1.0];// 设置文本颜色
    } duration:1.5 inView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)customTipsAction:(UIButton *)sender {
    [YMUITipsView showSuccessTitle:@"客从何处来" Top:ScreenHeight];
}

- (IBAction)custom01:(id)sender {
    [YMUITipsView showSuccessTitle:@"    客从何处来 \n\n 风里藏着秘密，遇山 散了 \n 花里喃着耳语，迎雾 没了 \n 怀里拥着温度，沾露 凉了 \n 手里攥着船票，入水 化了 " Top:ScreenHeight Success:^(BOOL success) {
        NSLog(@"完成回调");
        [YMUITipsView showImageTitle:@"加载成功"];
    }];
}

- (IBAction)custom02:(id)sender {
    [YMUITipsView showImageTitle:@"加载成功"];
}


@end
