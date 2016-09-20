//
//  PublishButton.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "PublishButton.h"
#import "CYLTabBarController.h"
#import "PublishMovieViewController.h"

#import "LoopProgressView.h"

@interface PublishButton ()<UIActionSheetDelegate>
{
    CGFloat _buttonImageHeight;
}
@end


@implementation PublishButton

#pragma mark - load
+ (void)load
{
    [super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

/*
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 控件的大小及位置
    CGFloat const imageViewEdgeWidth = self.bounds.size.width * 0.7;
    CGFloat const imageViewEdgeHeight = imageViewEdgeWidth * 0.9;
    
    CGFloat const centerOfView = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdgeWidth;
    CGFloat const verticalMargin = verticalMarginT / 2;
    
    // iamgeView 和 titleLabel 中心 Y 值
    CGFloat const centerOfImageView = verticalMargin + imageViewEdgeWidth * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeWidth + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    // imageView position
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    // titleLabel position
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight
{
    return 0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight
{
    return -10;
}
 */

#pragma mark - createPublishButton
+ (id)plusButton
{
    UIImage *buttonImage = Image(@"tabbar_compose_button");
    UIImage *heightImage = Image(@"tabbar_compose_button_highlighted");
    UIImage *iconImage = Image(@"tabbar_compose_icon_add");
    UIImage *heightIconImage = Image(@"tabbar_compose_icon_add");
    
    PublishButton *button = [PublishButton buttonWithType:(UIButtonTypeCustom)];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
     
    [button setImage:iconImage forState:UIControlStateNormal];
    [button setImage:heightIconImage forState:(UIControlStateSelected)];
    
    [button setBackgroundImage:buttonImage forState:(UIControlStateNormal)];
    [button setBackgroundImage:heightImage forState:(UIControlStateSelected)];
    
    
//    [button setTitle:@"发布" forState:(UIControlStateNormal)];
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    
//    [button setTitle:@"选中" forState:(UIControlStateSelected)];
//    [button setTitleColor:[UIColor blueColor] forState:(UIControlStateSelected)];
//    
//    button.titleLabel.font = [UIFont systemFontOfSize:9.5f];
//    [button sizeToFit];
    
    [button addTarget:button action:@selector(clickPublishButton) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}

- (void)clickPublishButton
{
    /*
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alterController addAction:[UIAlertAction actionWithTitle:STR(@"MakeMovie") style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        PublishMovieViewController *vc = [[PublishMovieViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [viewController presentViewController:nav animated:YES completion:nil];
        
    }]];
    
    [alterController addAction:[UIAlertAction actionWithTitle:STR(@"TakePhoto") style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        // 1.
//        [[[CustomTipsView alloc] init] showWithText:@"成功"];
        
        // 2.
//        LoopProgressView *view = [[LoopProgressView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//        view.center = [MPTools getMainWindow].center;
//        view.progress = 0.9;
//        [[MPTools getMainWindow] addSubview:view];
        
        // 3.
//        [StatusBarHUD showSuccess:@"数据加载成功..."];
//        [StatusBarHUD showError:@"数据加载失败..."];
        
//        [StatusBarHUD showLoading:@"正在登陆中..."];
//        [StatusBarHUD hide];
        
//        [StatusBarHUD showText:@"这是一个自定义的状态栏提示框"];
//        [StatusBarHUD hide];
//        
//        [StatusBarHUD showImageName:@"" text:@"文案呢?"];
        
    }]];
    [alterController addAction:[UIAlertAction actionWithTitle:STR(@"BtnTitle_Cancle") style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [viewController presentViewController:alterController animated:YES completion:nil];
    */
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:STR(@"BtnTitle_Cancle") destructiveButtonTitle:nil otherButtonTitles:STR(@"MakeMovie"), STR(@"TakePhoto"), nil];
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    [sheet showInView:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    
    if (0 == buttonIndex) {
        PublishMovieViewController *vc = [[PublishMovieViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [viewController presentViewController:nav animated:YES completion:nil];
    }else if (1 == buttonIndex) {
        
        [[[CustomTipsView alloc] init] showWithText:@"照片打卡"];
    }
    
}

@end
