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

//tips小窗口提示
+ (void)showSuccessTitle:(NSString *)title Top:(CGFloat)top
{
    UIView * tipsView = [UIView new];
    [myWindow() addSubview: tipsView];
    UIFont * font = [UIFont systemFontOfSize: 16.f];
    CGSize size = [title sizeWithFont: font constrainedToSize: CGSizeMake( ScreenWidth, font.xHeight)];
    tipsView.width = size.width + 32.f;
    //    tipsView.height = size.height + 20;
    tipsView.height = 40.f;
    tipsView.left = (ScreenWidth - tipsView.width)/2;
    tipsView.top = (top - tipsView.height)/2;
//    [tipsView addCornerRadius: 5.f];
    tipsView.backgroundColor = RGBA(0, 0, 0, 0.8f);
    
    UIBezierPath * _aPath = [UIBezierPath bezierPathWithRoundedRect: tipsView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight |UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake( 5.f , 5.f)];
    CAShapeLayer * _shapeLayer = [[CAShapeLayer alloc]init];
    _shapeLayer.frame = tipsView.bounds;
    _shapeLayer.path = _aPath.CGPath;
    tipsView.layer.mask = _shapeLayer;
    
    UILabel * labelTips = [[UILabel alloc]initWithFrame: tipsView.bounds];
    [tipsView addSubview: labelTips];
    labelTips.textAlignment = NSTextAlignmentCenter;
    labelTips.numberOfLines = 0;
    labelTips.font = font;
    labelTips.text = title;
    labelTips.textColor = [UIColor whiteColor];
    __weak UIView* weakView = tipsView;
    [NSThread runInMain:^{
        [UIView animateWithDuration: 0.8f
                              delay: 1.0f
                            options: UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             weakView.alpha = 1.f;
                         } completion: ^(BOOL finished){
                             {
                                 [UIView animateWithDuration: 0.5f delay: 1.f options: UIViewAnimationOptionCurveEaseOut animations:^{
                                     weakView.alpha = 0.f;
                                 } completion: ^(BOOL finished)
                                  {
                                      [weakView removeFromSuperview];
                                  }];
                             }
                         }];
    }];
}

+ (void)showSuccessTitle:(NSString *)title Top:(CGFloat)top Success:(void (^)(BOOL))goCancel
{
    UIView *tipsView = [UIView new];
    [myWindow() addSubview: tipsView];
    
    UIFont *font = [UIFont systemFontOfSize: 16.f];
    CGSize size = [title sizeWithFont: font constrainedToSize: CGSizeMake(ScreenWidth-30*2, 32)];
    CGFloat height = [title countTextHeightWithFont:font width:ScreenWidth-30*2];
    if (height > 20) {
        tipsView.width = ScreenWidth-30*2;
        tipsView.height = height + 30.f;
        tipsView.left = 30.f;
        tipsView.top = (top - tipsView.height)/2;
    } else {
        tipsView.width = size.width+32.f;
        tipsView.height = 40.f;
        tipsView.left = (ScreenWidth - tipsView.width)/2;
        tipsView.top = (top - tipsView.height)/2;
    }
    
    UIBezierPath * _aPath = [UIBezierPath bezierPathWithRoundedRect: tipsView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight |UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake( 5.f , 5.f)];
    CAShapeLayer * _shapeLayer = [[CAShapeLayer alloc]init];
    _shapeLayer.frame = tipsView.bounds;
    _shapeLayer.path = _aPath.CGPath;
    tipsView.layer.mask = _shapeLayer;
    
    tipsView.backgroundColor = RGBA(0, 0, 0, 0.8f);
    UILabel * labelTips = [[UILabel alloc]initWithFrame: tipsView.bounds];
    [tipsView addSubview: labelTips];
    labelTips.textAlignment = NSTextAlignmentCenter;
    labelTips.numberOfLines = 0;
    labelTips.font = font;
    labelTips.text = title;
    labelTips.textColor = [UIColor whiteColor];
    __weak UIView* weakView = tipsView;
    [NSThread runInMain:^{
        [UIView animateWithDuration: 0.8f
                              delay: 1.0f
                            options: UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             weakView.alpha = 1.f;
                         } completion: ^(BOOL finished){
                             {
                                 [UIView animateWithDuration: 0.5f delay: 1.f options: UIViewAnimationOptionCurveEaseOut animations:^{
                                     weakView.alpha = 0.f;
                                 } completion: ^(BOOL finished)
                                  {
                                      [weakView removeFromSuperview];
                                      goCancel(YES);
                                  }];
                             }
                         }];
    }];
}

+ (void)showImageTitle:(NSString *)title
{
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    UIImage* imageDone = [UIImage imageNamed: @"success_tips"];
    UILabel* labelDoneTxt = [[UILabel alloc] init];
    UIImageView* imgSCDone = [[UIImageView alloc] initWithImage: imageDone];
    UIView * success = [[UIView alloc] init];
    success.backgroundColor = [UIColor clearColor];
    success.alpha = 0.f;
    [success setFrame: CGRectMake(0, 0, imgSCDone.frame.size.width, imgSCDone.frame.size.height)];
    [labelDoneTxt setFont: [UIFont systemFontOfSize:14.f]];
    CGSize sizeText =
    [title sizeWithFont: labelDoneTxt.font
        constrainedToSize: CGSizeMake(MAXFLOAT, labelDoneTxt.font.xHeight)];
    [labelDoneTxt setText: title];
    [labelDoneTxt setTextColor: [UIColor whiteColor]];
    labelDoneTxt.width = sizeText.width;
    labelDoneTxt.height = sizeText.height;
    labelDoneTxt.left = (success.width - labelDoneTxt.width) / 2;
    labelDoneTxt.top = imgSCDone.height - 17.f - labelDoneTxt.height;
    success.left = (window.width - success.width) / 2;
    success.top = (window.height - success.height) / 2;
    [success addSubview: imgSCDone];
    [success addSubview: labelDoneTxt];
    [window addSubview: success];
    
    __weak UIView* weakView = success;
    [NSThread runInMain:^{
        [UIView animateWithDuration: 0.8f
                              delay: 0.f
                            options: UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             weakView.alpha = 1.f;
                         } completion: ^(BOOL finished){
                             {
                                 [UIView animateWithDuration: 0.5f delay: 1.f options: UIViewAnimationOptionCurveEaseOut animations:^{
                                     weakView.alpha = 0.f;
                                 } completion: ^(BOOL finished)
                                  {
                                      [weakView removeFromSuperview];
                                  }];
                             }
                         }];
    }];
}

UIWindow * myWindow()
{
    return [[UIApplication sharedApplication].delegate window];
}

@end
