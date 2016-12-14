//
//  OrderTableViewCell.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "OrderInfoView.h"

@protocol OrderTableViewCellDelegate <NSObject>

// 立即支付
- (void)payMoneyWithModel:(OrderModel *)model;

// 查看物流
- (void)lookAtLogisticsWithModel:(OrderModel *)model;

// 删除订单
- (void)deleteOrderWithModel:(OrderModel *)model;

@end

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic, strong) OrderInfoView *orderDetail; //订单详情

@property (nonatomic, strong) OrderModel *orderModel;

@property (nonatomic, weak) id<OrderTableViewCellDelegate>delegate;

@end
