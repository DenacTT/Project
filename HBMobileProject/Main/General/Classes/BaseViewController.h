//
//  BaseViewController.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/* 顶部标题 */
@property (nonatomic, strong) UILabel *titleLabel;

/* 导航栏 */
@property (nonatomic, strong) UIView *navView;

/* 底部切割线 */
@property (nonatomic, strong) UIView *bottomLine;

/* 是否使用返回按钮 */
@property (nonatomic, assign) BOOL isUseBackBtn;

/* 是否使用右边按钮 */
@property (nonatomic, assign) BOOL isUseRightBtn;

/* 返回按钮 */
@property (nonatomic, strong) UIButton *backBtn;

/* 右边按钮 */
@property (nonatomic, strong) UIButton *rightBtn;

/* 返回按钮点击事件 */
- (void)clickBackBtn;

/* 右边按钮点击事件 */
- (void)clickRightBtn;

@end
