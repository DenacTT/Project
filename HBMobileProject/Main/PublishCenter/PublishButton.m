//
//  PublishButton.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "PublishButton.h"
#import "CYLTabBarController.h"

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
    UIImage *buttonImage = [UIImage imageNamed:@"tabbar_compose_button"];
    UIImage *heightImage = [UIImage imageNamed:@"tabbar_compose_button_highlighted"];
    UIImage *iconImage = [UIImage imageNamed:@"tabbar_compose_icon_add"];
    UIImage *heightIconImage = [UIImage imageNamed:@"tabbar_compose_icon_add"];
    
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
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alterController addAction:[UIAlertAction actionWithTitle:@"拍视频" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拍视频");
        
        
    }]];
    
    [alterController addAction:[UIAlertAction actionWithTitle:@"选照片" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"照片");
    }]];
    [alterController addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [viewController presentViewController:alterController animated:YES completion:nil];
}




@end