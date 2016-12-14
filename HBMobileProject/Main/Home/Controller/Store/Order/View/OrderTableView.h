//
//  OrderTableView.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderTableView : UIView

@property (nonatomic, strong) OrderModel *orderModel;

- (void)initDataWithOrderModel:(OrderModel *)orderModel;

@end
