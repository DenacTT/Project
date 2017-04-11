//
//  SBHomeCalsView.m
//  HBMobileProject
//
//  Created by HarbingWang on 2017/4/7.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBHomeCalsView.h"

#define ItemW 188

@interface SBHomeCalsView ()

@property (nonatomic, strong) UILabel *topText;   //顶部文案
@property (nonatomic, strong) UILabel *btmText;   //底部文案

@end

@implementation SBHomeCalsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.topText];
        [self addSubview:self.btmText];
        [self addSubview:self.totalCals];
    }
    return self;
}

#pragma mark - Getter
- (UILabel *)topText {
    if (!_topText) {
        _topText = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, ItemW, 14)];
        [_topText setLabelText:@"Total Calories"
                          font:Font(14)
                     textColor:RGBA(255, 255, 255, 0.8)
                 textAlignment:NSTextAlignmentCenter];
    }
    return _topText;
}

- (UILabel *)totalCals {
    if (!_totalCals) {
        _totalCals = [[UILabel alloc] initWithFrame:CGRectMake(_topText.left, _topText.bottom, ItemW, 188-32*2-16-14)];
        [_totalCals setLabelText:@"6789"
                            font:[UIFont fontWithName:@"Spoon-Regular" size:60]
                       textColor:RGB(255, 255, 255)
                   textAlignment:NSTextAlignmentCenter];
        
        _totalCals.layer.shadowColor = RGBA(0, 0, 0, 0.1).CGColor;
        _totalCals.layer.shadowOffset = CGSizeMake(0, 3);
        _totalCals.layer.shadowOpacity = 0.3;
    }
    return _totalCals;
}

- (UILabel *)btmText {
    if (!_btmText) {
        _btmText = [[UILabel alloc] initWithFrame:CGRectMake(_topText.left, CGRectGetWidth(self.bounds)-32-16, ItemW, 16)];
        [_btmText setLabelText:@"Cals"
                          font:Font(16)
                     textColor:RGBA(255, 255, 255, 0.8)
                 textAlignment:NSTextAlignmentCenter];
    }
    return _btmText;
}

@end
