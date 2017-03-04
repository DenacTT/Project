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

typedef enum : NSUInteger {
    CASE_1, // 显示文本和菊花,延时3秒后消失
    CASE_2, // 仅仅显示文本,延时3秒后消失
    CASE_3, // 加载自定义view,3秒后消失
} E_CASE;

@interface YMActionSheetViewController ()

@property (nonatomic, assign) NSInteger  caseType;

@end

@implementation YMActionSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _caseType = 0;
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

- (IBAction)mbProgressHud:(UIButton *)sender {
    [self showHUD];
}

- (void)showHUD
{
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    
    switch (_caseType++ % 3) {
        case CASE_1: {
            [ShowHUD showText:@"加载成功" configParameter:^(ShowHUD *config) {
                config.margin          = 35.f;     // 边缘留白
                config.opacity         = 1.f;     // 设定透明度
                config.cornerRadius    = 5.f;     // 设定圆角
                config.textFont        = [UIFont systemFontOfSize:14.f];
              } duration:1.5 inView:window];
        } break;
            
        case CASE_2: {
            [ShowHUD showTextOnly:@"加载失败" configParameter:^(ShowHUD *config) {
                    config.animationStyle  = ZoomOut; // 设置动画方式
                    config.margin          = 20.f;     // 边缘留白
                    config.opacity         = 1.f;     // 设定透明度
                    config.cornerRadius    = 5.f;    // 设定圆角
                    config.cornerRadius    = 5.f;     // 设定圆角
                    config.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];// 设置背景色
                    config.labelColor      = [[UIColor whiteColor] colorWithAlphaComponent:1.0];// 设置文本颜色
                  } duration:1.5 inView:window];
        } break;
            
        case CASE_3: {
//            BackgroundView *backView = [[BackgroundView alloc] initInView:window];
//            backView.startDuration = 0.25;
//            backView.endDuration   = 0.25;
//            [backView addToView];
//
//            ShowHUD *hud = [ShowHUD showCustomView:^UIView *{
//                // 返回一个自定义view即可,hud会自动根据你返回的view调整空间
//                MulticolorView *showView = [[MulticolorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//                showView.lineWidth       = 1.f;
//                showView.sec             = 1.5f;
//                showView.colors          = @[(id)[UIColor cyanColor].CGColor,
//                                             (id)[UIColor yellowColor].CGColor,
//                                             (id)[UIColor cyanColor].CGColor];
//                [showView startAnimation];
//                return showView;
//            } configParameter:^(ShowHUD *config) {
//                config.animationStyle  = Zoom;   // 设定动画方式
//                config.margin          = 10.f;   // 边缘留白
//                config.cornerRadius    = 2.f;    // 边缘圆角
//                config.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
//            } inView:window];
//
//            // 延迟5秒后消失
//            [GCDQueue executeInMainQueue:^{
//                [hud hide];
//                [backView removeSelf];
//            } afterDelaySecs:5];
        } break;
            
        default:
            break;
    }
}



@end
