//
//  PlaceholderImageView.h
//  HBMobileProject
//
//  Created by HarbingW on 2017/6/27.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderImageView : UIView

/// 图片URL
@property (nonatomic, strong) NSString *urlString;
/// 占位图
@property (nonatomic, strong) UIImage *placeholderImage;

/// 类方法
+ (instancetype)placeholderImageViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)image;

@end
