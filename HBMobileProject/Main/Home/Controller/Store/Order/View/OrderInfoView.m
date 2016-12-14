//
//  OrderInfoView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "OrderInfoView.h"
#define kLabelWidth ScreenWidth-15*2-18-15-64

@interface OrderInfoView ()

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) UIImageView *goodsImg;

@property (nonatomic, strong) UILabel *goodsName;

@property (nonatomic, strong) UILabel *goodsMoney;

@property (nonatomic, strong) UILabel *goodsNum;

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation OrderInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.topLine];
        [self addSubview:self.goodsImg];
        [self addSubview:self.goodsName];
        [self addSubview:self.goodsMoney];
        [self addSubview:self.goodsNum];
        [self addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark - setter
- (void)setOrderModel:(OrderModel *)orderModel {
    _orderModel = orderModel;
    
    [_goodsImg sd_setImageWithURL:[NSURL URLWithString:orderModel.listOfGoodsInfo.imgUrl] placeholderImage:Image(@"place_goods_normal") options:(SDWebImageRetryFailed)];
    //_goodsName.text = orderModel.listOfGoodsInfo.name;
    _goodsName.text = @"好轻 2 智能体脂称 深空灰";
    _goodsMoney.text = [NSString stringWithFormat:@"单价 %zi 元", orderModel.listOfGoodsInfo.price];
    _goodsNum.text = [NSString stringWithFormat:@"数量 %zi", orderModel.listOfGoodsInfo.num];
    
    if (orderModel.status == OrderStatusHaveCanceled) {
        _goodsMoney.textColor = RGB(170, 170, 170);
        _goodsName.textColor = RGB(170, 170, 170);
        _goodsNum.textColor = RGB(170, 170, 170);
    }
}

#pragma mark - getter
- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-15*2, 0.5)];
        _topLine.backgroundColor = RGB(170, 170, 170);
    }
    return _topLine;
}

- (UIImageView *)goodsImg {
    if (!_goodsImg) {
        _goodsImg = [[UIImageView alloc] initWithFrame:CGRectMake(18, (100-64)/2, 64, 64)];
        _goodsImg.image = Image(@"place_goods_normal");
    }
    return _goodsImg;
}

- (UILabel *)goodsName {
    if (!_goodsName) {
        _goodsName = [[UILabel alloc] initWithFrame:CGRectMake(_goodsImg.right+17, 50-6-5-14, kLabelWidth, 14)];
        _goodsName.text = @"好轻 2 智能体脂称 深空灰";
        _goodsName.font = Font(14);
        _goodsName.textColor = RGB(50, 50, 50);
        _goodsName.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsName;
}

- (UILabel *)goodsMoney {
    if (!_goodsMoney) {
        _goodsMoney = [[UILabel alloc] initWithFrame:CGRectMake(_goodsName.left, _goodsName.bottom+5, _goodsName.width, 12)];
        _goodsMoney.text = @"单价 128 元";
        _goodsMoney.font = Font(12);
        _goodsMoney.textColor = RGB(136, 136, 136);
        _goodsMoney.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsMoney;
}

- (UILabel *)goodsNum {
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc] initWithFrame:CGRectMake(_goodsName.left, _goodsMoney.bottom+5, _goodsName.width, 12)];
        _goodsNum.text = @"数量 3";
        _goodsNum.font = Font(12);
        _goodsNum.textColor = RGB(136, 136, 136);
        _goodsNum.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsNum;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-0.5, ScreenWidth-15*2, 0.5)];
        _bottomLine.backgroundColor = RGB(170, 170, 170);
    }
    return _bottomLine;
}

@end
