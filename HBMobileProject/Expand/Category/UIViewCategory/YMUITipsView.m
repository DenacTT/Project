//
//  YMUITipsView.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/3.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "YMUITipsView.h"
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@implementation YMUITipsView

+ (void)showAlertTitle:(NSString *)title{
    [[[UIAlertView alloc] initWithTitle:@"温馨提示"  message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

+ (void)showServerErrorMsg
{
    [YMUITipsView showTips:@"哎呀！网络不太顺畅哦~"];
}

+ (void)showTips:(NSString *)tips {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.color = RGBA(0, 0, 0, 0.8);
    hud.label.textColor = [UIColor whiteColor];
    hud.label.text = tips;
    hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES afterDelay:1.5f];
}

@end
