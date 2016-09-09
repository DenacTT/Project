//
//  YMChangeAccountSuccessView.h
//  scale
//
//  Created by zxq on 16/3/23.
//  Copyright © 2016年 zxq. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kShowNewUserSucessed NSLocalizedString(@"YMCASV_createSuccess", @"创建成功，再称一次吧～")
#define kShowChangeUserSucessed NSLocalizedString(@"YMCASV_cutSuccess", @"账号已切换，再称一次吧~")

@interface YMChangeAccountSuccessView : UIView

- (void)layoutViews;
- (void)animat;// 停留2s,渐消

- (void)showWithTxt:(NSString *)str;


@end
