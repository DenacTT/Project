//
//  CuttingLine.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/14.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CuttingLine : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat pointPerCount;
@property (nonatomic, assign) CGFloat pointAglinCount;
@property (nonatomic, strong) UIColor *strokeColor;

@end
