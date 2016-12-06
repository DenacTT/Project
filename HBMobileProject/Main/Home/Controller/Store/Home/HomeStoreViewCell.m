//
//  HomeStoreViewCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "HomeStoreViewCell.h"
#import "UILabel+Multiline.h"

#define CellWidth (ScreenWidth-9)/2

@interface HomeStoreViewCell ()

@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *hotLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation HomeStoreViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = RGB(255, 255, 255);
        
        [self.contentView addSubview:self.hotLabel];
        [self.contentView addSubview:self.goodsImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}


#pragma mark - getter
- (UILabel *)hotLabel {
    if (!_hotLabel) {
        _hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellWidth-5-28, 5, 28, 14)];
        _hotLabel.text = @"热卖";
        _hotLabel.font = Font(10);
        _hotLabel.textColor = RGB(233, 48, 83);
        _hotLabel.textAlignment = NSTextAlignmentCenter;
        
        _hotLabel.layer.borderColor = RGB(233, 48, 83).CGColor;
        _hotLabel.layer.borderWidth = 0.5f;
    }
    return _hotLabel;
}

- (UIImageView *)goodsImage {
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc] initWithFrame:CGRectMake((CellWidth-116)/2, 22, 116, 116)];
        _goodsImage.image = Image(@"place_goods_normal");
        _goodsImage.contentMode = UIViewContentModeScaleAspectFill;
        _goodsImage.layer.masksToBounds = YES;
    }
    return _goodsImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, _goodsImage.bottom+12, CellWidth-28*2, 14)];
        _nameLabel.text = @"好轻 2";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = Font(14);
        _nameLabel.textColor = RGB(50, 50, 50);
    }
    return _nameLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, _nameLabel.bottom+6, _nameLabel.width, 30)];
        _descLabel.font = Font(12);
        _descLabel.numberOfLines = 2;
        _descLabel.textColor = RGB(136, 136, 136);
        
        _descLabel.text = @"一款划时代的产品,精湛的工艺带来全新的测脂技术....";
        NSString *text = [NSString stringWithFormat:@"%@", _descLabel.text];
        [self.descLabel setText:text lines:2 andLineSpacing:6.f constrainedToSize:CGSizeMake(_descLabel.width, _descLabel.height)];
    }
    return _descLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_descLabel.left, _descLabel.bottom+12, _descLabel.width, 14)];
        _priceLabel.text = @"499元";
        _priceLabel.font = Font(14);
        _priceLabel.textColor = RGB(233, 48, 83);
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}

@end
