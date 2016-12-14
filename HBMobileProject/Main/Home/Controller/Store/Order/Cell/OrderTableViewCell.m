//
//  OrderTableViewCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "UIButton+OrderButton.h"
#import "UIColor+Extend.h"

#define kLeftMargin 15

@interface OrderTableViewCell ()

@property (nonatomic, strong) UIView  *topView;

@property (nonatomic, strong) UILabel *orderNumber; //订单编号

@property (nonatomic, strong) UILabel *orderStatus; //订单状态

@property (nonatomic, strong) UILabel *totalAmount; //订单金额

@property (nonatomic, strong) UIButton *orderButton;//订单操作

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation OrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.topView];
        [self.contentView addSubview:self.orderNumber];
        [self.contentView addSubview:self.orderStatus];
        [self.contentView addSubview:self.orderDetail];
        [self.contentView addSubview:self.totalAmount];
        [self.contentView addSubview:self.orderButton];
        [self.contentView addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark - setter
- (void)setOrderModel:(OrderModel *)orderModel {
    _orderModel = orderModel;
    
    _orderNumber.text = [NSString stringWithFormat:@"订单编号 %zi", orderModel.orderNo];
    _totalAmount.text = [NSString stringWithFormat:@"总金额 %zi 元(含运费 %zi 元)", orderModel.totalPrice, orderModel.dispatchCost];
    
    [_orderButton changeBtnStyleWihtOrderStatus:orderModel.status];
    [self changeLabelStyleWithOrderStatus:orderModel.status];
    
    if (orderModel.status == OrderStatusHaveCanceled) {
        _orderNumber.textColor = RGB(170, 170, 170);
        _totalAmount.textColor = RGB(170, 170, 170);
    }
}

#pragma mark - button
- (void)buttonClicked:(UIButton *)button {
    
    switch (_orderModel.status) {
        case OrderStatusWaitPay:
            if ([self.delegate respondsToSelector:@selector(payMoneyWithModel:)]) {
                [self.delegate payMoneyWithModel:_orderModel];
            }
            break;
        case OrderStatusWaitReceive:
            if ([self.delegate respondsToSelector:@selector(lookAtLogisticsWithModel:)]) {
                [self.delegate lookAtLogisticsWithModel:_orderModel];
            }
            break;
        case OrderStatusHaveReceived:
        case OrderStatusHaveCanceled:
            if ([self.delegate respondsToSelector:@selector(deleteOrderWithModel:)]) {
                [self.delegate deleteOrderWithModel:_orderModel];
            }
            break;
        default:
            break;
    }
}

- (void)changeLabelStyleWithOrderStatus:(OrderStatus)orderStatus {
    switch (orderStatus) {
        case OrderStatusWaitPay:
            _orderStatus.text = @"待支付";
            _orderStatus.textColor = RGB(248, 68, 68);
            break;
        case OrderStatusWaitReceive:
            _orderStatus.text = @"待收货";
            _orderStatus.textColor = RGB(74, 144, 226);
            break;
        case OrderStatusHaveReceived:
            _orderStatus.text = @"已收货";
            _orderStatus.textColor = RGB(102, 102, 102);
            break;
        case OrderStatusHaveCanceled:
            _orderStatus.text = @"已取消";
            _orderStatus.textColor = RGB(102, 102, 102);
            break;
        default:
            break;
    }
}

#pragma mark - getter
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        _topView.backgroundColor = [UIColor commonViewCellBg];
    }
    return _topView;
}

- (UILabel *)orderNumber {
    if (!_orderNumber) {
        _orderNumber = [[UILabel alloc] initWithFrame:CGRectMake(kLeftMargin, (40-14)/2+10, ScreenWidth-15*2-50, 14)];
        _orderNumber.font = Font(14);
        _orderNumber.textColor = RGB(102, 102, 102);
        _orderNumber.textAlignment = NSTextAlignmentLeft;
        _orderNumber.text = @"";
    }
    return _orderNumber;
}

- (UILabel *)orderStatus {
    if (!_orderStatus) {
        _orderStatus = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-15-45, (40-14)/2+10, 45, 14)];
        _orderStatus.text = @"";
        _orderStatus.font = Font(14);
        _orderStatus.textColor = RGB(248, 68, 68);
        _orderStatus.textAlignment = NSTextAlignmentRight;
    }
    return _orderStatus;
}

- (OrderInfoView *)orderDetail {
    if (!_orderDetail) {
        _orderDetail = [[OrderInfoView alloc] initWithFrame:CGRectMake(kLeftMargin, 40+10, ScreenWidth-15*2, 101)];
    }
    return _orderDetail;
}

- (UILabel *)totalAmount {
    if (!_totalAmount) {
        _totalAmount = [[UILabel alloc] initWithFrame:CGRectMake(kLeftMargin, _orderDetail.bottom+(45-14)/2, ScreenWidth-15*2-80, 14)];
        _totalAmount.text = @"";
        _totalAmount.font = Font(14);
        _totalAmount.textColor = RGB(50, 50, 50);
        _totalAmount.textAlignment = NSTextAlignmentLeft;
    }
    return _totalAmount;
}

- (UIButton *)orderButton {
    
    if (!_orderButton) {
        _orderButton = [UIButton orderButtonFrame:CGRectMake(ScreenWidth-15-74, _totalAmount.center.y-15, 74, 30)];
        [_orderButton addTarget:self action:@selector(buttonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _orderButton;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _totalAmount.center.y+45/2+0.5, ScreenWidth, 0.5)];
        _bottomLine.backgroundColor = RGB(170, 170, 170);
    }
    return _bottomLine;
}

@end
