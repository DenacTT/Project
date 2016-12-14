//
//  UIButton+OrderButton.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"

@interface UIButton (OrderButton)

+ (UIButton *)orderButtonFrame:(CGRect)frame;

- (void)changeBtnStyleWihtOrderStatus:(OrderStatus)orderStatus;

@end
