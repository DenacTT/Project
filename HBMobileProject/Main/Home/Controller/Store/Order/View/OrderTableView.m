//
//  OrderTableView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "OrderTableView.h"
#import "UIColor+Extend.h"
#import "OrderTableViewCell.h"

static NSString * const OrderTableViewCellID = @"OrderTableViewCellID";

@interface OrderTableView ()<UITableViewDelegate, UITableViewDataSource, OrderTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OrderTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)setOrderModel:(OrderModel *)orderModel {
    _orderModel = orderModel;
    
}

- (void)initDataWithOrderModel:(OrderModel *)orderModel {
    
    NSLog(@"%zi", orderModel.status);
}

#pragma mark - OrderTableViewCellDelegate
- (void)payMoneyWithModel:(OrderModel *)model {
    NSLog(@"立即支付");
}

- (void)lookAtLogisticsWithModel:(OrderModel *)model {
    NSLog(@"查看物流");
}

- (void)deleteOrderWithModel:(OrderModel *)model {
    NSLog(@"删除订单");
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderTableViewCellID forIndexPath:indexPath];
    cell.delegate = self;
    
    OrderModel *model = [[OrderModel alloc] init];
    model.status = 2;
    cell.orderModel = model;
    cell.orderDetail.orderModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 101+45+40+10;
}

#pragma mark - setter
- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, ScreenHeight-64-45-64) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:OrderTableViewCellID];
    }
    return _tableView;
}

@end
