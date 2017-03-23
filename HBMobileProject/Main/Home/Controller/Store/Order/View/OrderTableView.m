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
#import "MJRefresh.h"

static NSString * const OrderTableViewCellID = @"OrderTableViewCellID";

@interface OrderTableView ()<UITableViewDelegate, UITableViewDataSource, OrderTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIActivityIndicatorView *indictorView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSInteger page;

@end

@implementation OrderTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.page = 0;
        [self.indictorView startAnimating];
        
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

- (void)loadNetData {
    
    if (self.page == 0) {
        [self.indictorView startAnimating];
    }
    self.page++;
    [self requestOrderListWithPage:self.page];
}

- (void)requestOrderListWithPage:(NSInteger)page {
    
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
    
    cell.orderModel = self.orderModel;
    cell.orderDetail.orderModel = self.orderModel;
    
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:OrderTableViewCellID];
        
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget: self refreshingAction: @selector(loadNetData)];
    }
    return _tableView;
}

@end
