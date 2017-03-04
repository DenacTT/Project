//
//  YMUITipsView.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/3.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YMUITipsView : NSObject

+ (void)showAlertTitle:(NSString *)title;

+ (void)showServerErrorMsg;

+ (void)showTips:(NSString *)tips;

@end
