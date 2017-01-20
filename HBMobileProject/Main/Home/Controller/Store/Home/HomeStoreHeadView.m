//
//  HomeStoreHeadView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "HomeStoreHeadView.h"
#import "YMTimeCountView.h"

#define kLeftMargin 32
#define kBackGroundColor RGB(245, 108, 153)

@interface HomeStoreHeadView ()

@property (nonatomic, strong) UILabel *runshLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) YMTimeCountView *timeCountView;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UILabel *nextLabel;

@property (nonatomic, strong) UIImageView *runshGoodsImg;
@property (nonatomic, strong) UIImageView *placeIconImg;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *priceUnitLabel;

@end

@implementation HomeStoreHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = kBackGroundColor;
        
        [self addSubview:self.runshLabel];
//        [self addSubview:self.timeLabel];
        [self addSubview:self.timeCountView];
        [self addSubview:self.startBtn];
        [self addSubview:self.nextLabel];
        
        [self addSubview:self.runshGoodsImg];
        [self addSubview:self.placeIconImg];
        [self addSubview:self.priceLabel];
        [self addSubview:self.priceUnitLabel];
    }
    return self;
}

#pragma mark - setter
- (void)setModel:(GoodsModel *)model {
    _model = model;
}

- (void)initData {
    [self.timeCountView runTimerWithRushStartTime:1484969930];
}

#pragma mark - getter
- (UILabel *)runshLabel {
    if (!_runshLabel) {
        _runshLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftMargin, 44, 90, 14)];
        _runshLabel.text = @"限时秒杀";
        _runshLabel.font = Font(14);
        _runshLabel.textColor = RGB(255, 255, 255);
        _runshLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _runshLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftMargin, _runshLabel.bottom+6, (ScreenWidth-32*2)/2, 32)];
        _timeLabel.text = @"00:00:00";
        _timeLabel.font = [UIFont fontWithName:@"miso-bold" size:32];
        _timeLabel.textColor = RGB(255, 255, 255);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (YMTimeCountView *)timeCountView {
    if (!_timeCountView) {
        _timeCountView = [[YMTimeCountView alloc] initWithFrame:CGRectMake(kLeftMargin,  _runshLabel.bottom+6, 108, 32)];
    }
    return _timeCountView;
}

- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _startBtn.frame = CGRectMake(kLeftMargin, _timeCountView.bottom+6, 90, 30);
        _startBtn.backgroundColor = RGBA(255, 255, 255, 0.6);
        
        _startBtn.layer.masksToBounds = YES;
        _startBtn.layer.cornerRadius = 4.f;
        
        [_startBtn setTitle:@"即将开始" forState:(UIControlStateNormal)];
        [_startBtn.titleLabel setTintColor:kBackGroundColor];
    }
    return _startBtn;
}

- (UILabel *)nextLabel {
    if (!_nextLabel) {
        _nextLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftMargin, _startBtn.bottom+6, 90, 12)];
        _nextLabel.text = @"下一场 21:00";
        _nextLabel.font = Font(12);
        _nextLabel.textColor = RGB(255, 255, 255);
        _nextLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nextLabel;
}

- (UIImageView *)runshGoodsImg {
    if (!_runshGoodsImg) {
        _runshGoodsImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-36-154, 18, 154, 154)];
        _runshGoodsImg.image = Image(@"defaultImage");
        
        _runshGoodsImg.contentMode = UIViewContentModeScaleAspectFill;
        _runshGoodsImg.layer.masksToBounds = YES;
    }
    return _runshGoodsImg;
}

- (UIImageView *)placeIconImg {
    if (!_placeIconImg) {
        _placeIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(_runshGoodsImg.right-40, _runshGoodsImg.bottom-64, 64, 64)];
        _placeIconImg.image = Image(@"place_icon_price");
    }
    return _placeIconImg;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_placeIconImg.left, _placeIconImg.top+15, _placeIconImg.width, 32)];
        _priceLabel.text = @"109";
        _priceLabel.font = [UIFont fontWithName:@"miso-bold" size:32];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}

- (UILabel *)priceUnitLabel {
    if (!_priceUnitLabel) {
        _priceUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(_priceLabel.left, _priceLabel.bottom, _priceLabel.width, 10)];
        _priceUnitLabel.text = @"元";
        _priceUnitLabel.font = Font(10);
        _priceUnitLabel.textColor = [UIColor whiteColor];
        _priceUnitLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceUnitLabel;
}

@end
