//
//  UIButton+OrderButton.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "UIButton+OrderButton.h"

@implementation UIButton (OrderButton)

+ (UIButton *)orderButtonFrame:(CGRect)frame {
    
    UIButton *orderButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    orderButton.frame = frame;
    orderButton.backgroundColor = [UIColor whiteColor];
    
    orderButton.titleLabel.font = Font(14);
    [orderButton setTitleColor:RGB(248, 68, 68) forState:(UIControlStateNormal)];
    [orderButton setTitle:@"立即支付" forState:(UIControlStateNormal)];
    
    orderButton.layer.masksToBounds = YES;
    orderButton.layer.cornerRadius = 3.f;
    
    orderButton.layer.borderWidth = 1.f;
    orderButton.layer.borderColor = RGB(248, 68, 68).CGColor;
    return orderButton;
}

- (void)changeBtnStyleWihtOrderStatus:(OrderStatus)orderStatus {
    switch (orderStatus) {
        case OrderStatusWaitPay:
            [self setTitleColor:RGB(248, 68, 68) forState:(UIControlStateNormal)];
            [self setTitle:@"立即支付" forState:(UIControlStateNormal)];
            self.layer.borderColor = RGB(248, 68, 68).CGColor;
            break;
        case OrderStatusWaitReceive:
            [self setTitleColor:RGB(74, 144, 226) forState:(UIControlStateNormal)];
            [self setTitle:@"查看物流" forState:(UIControlStateNormal)];
            self.layer.borderColor = RGB(74, 144, 226).CGColor;
            break;
        case OrderStatusHaveReceived:
        case OrderStatusHaveCanceled:    
            [self setTitleColor:RGB(50, 50, 50) forState:(UIControlStateNormal)];
            [self setTitle:@"删除订单" forState:(UIControlStateNormal)];
            self.layer.borderColor = RGB(170, 170, 170).CGColor;
            break;
            
        default:
            break;
    }
}

@end
