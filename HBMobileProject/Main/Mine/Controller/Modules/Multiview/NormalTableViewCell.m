//
//  NormalTableViewCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/10/31.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "NormalTableViewCell.h"

@interface NormalTableViewCell ()

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *isNewLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIImageView *descImg;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation NormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.topLine];
        [self addSubview:self.headImage];
        [self addSubview:self.nickNameLabel];
        [self addSubview:self.isNewLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.descLabel];
        [self addSubview:self.moreBtn];
        [self addSubview:self.descImg];
        [self addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark - setter
- (UIView *)topLine
{
    if (!_topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 8)];
        _topLine.backgroundColor = RGB(243, 243, 247);
    }
    return _topLine;
}

- (UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, _topLine.bottom+15, 35, 35)];
        
        _headImage.layer.borderWidth = 0.5;
        _headImage.layer.borderColor = RGBA(0, 0, 0, 0.1).CGColor;
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius  = _headImage.width/2;
        
        _headImage.image = Image(@"defaultImage");
        
    }
    return _headImage;
}

@end
