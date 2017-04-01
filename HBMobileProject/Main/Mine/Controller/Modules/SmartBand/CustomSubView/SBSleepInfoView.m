//
//  SBSleepInfoView.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/31.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBSleepInfoView.h"

@interface SBSleepInfoView ()

@property (nonatomic, strong) UILabel *leftTime;    //入睡时间
@property (nonatomic, strong) UILabel *righTime;    //起床时间
@property (nonatomic, strong) UILabel *barChart;    //睡眠柱状图

@end

@implementation SBSleepInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:self.leftTime];
        [self addSubview:self.righTime];
        [self addSubview:self.barChart];
    }
    return self;
}

- (UILabel *)leftTime {
    if (!_leftTime) {
        _leftTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110/2, 10)];
        _leftTime.backgroundColor = [UIColor whiteColor];
        _leftTime.text = @"00:10";
        _leftTime.font = Font(10);
        _leftTime.textColor = RGB(136, 136, 136);
        _leftTime.textAlignment = NSTextAlignmentLeft;
    }
    return _leftTime;
}

- (UILabel *)righTime {
    if (!_righTime) {
        _righTime = [[UILabel alloc] initWithFrame:CGRectMake(self.leftTime.right, 0, 110/2, 10)];
        _righTime.backgroundColor = [UIColor cyanColor];
        _righTime.text = @"07:35";
        _righTime.font = Font(10);
        _righTime.textColor = RGB(136, 136, 136);
        _righTime.textAlignment = NSTextAlignmentRight;
    }
    return _righTime;
}

- (UILabel *)barChart {
    if (_barChart) {
        _barChart = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 110, 8)];
        _barChart.backgroundColor = [UIColor whiteColor];
        _barChart.text = @"草泥马";
        _barChart.font = Font(10);
        _barChart.textColor = RGB(136, 136, 136);
        _barChart.textAlignment = NSTextAlignmentRight;
    }
    return _barChart;
}

@end
