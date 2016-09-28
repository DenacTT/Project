//
//  DelayView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/27.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "DelayView.h"
#import "UIColor+Extend.h"

@implementation DelayView
{
    UIImageView *_delayImageView;
    UILabel     *_delayLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _delayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
        _delayImageView.image = Image(@"DelayBtnHighGray");
        [self addSubview:_delayImageView];
        
        _delayLabel = [[UILabel alloc] initWithFrame:CGRectMake(_delayImageView.right + 5, 11, 44, 22)];
        _delayLabel.font = [UIFont systemFontOfSize: 13];
        _delayLabel.textColor = [UIColor colorWithHexString: @"ffcc00"];
        [self addSubview: _delayLabel];
    }
    return self;
}

- (void)setDelaySeconds:(NSInteger)delaySeconds
{
    _delaySeconds = delaySeconds;
    switch (delaySeconds) {
        case 0:
        {
            _delayImageView.image = Image(@"DelayBtnHighGray");
            _delayLabel.hidden = YES;
        }
            break;
        case 3:
        {
            _delayImageView.image = Image(@"DelayBtnHighLight");
            _delayLabel.hidden = NO;
            _delayLabel.text = [NSString stringWithFormat: @"3 %@",STR(@"Second")];
        }
            break;
        case 10:
        {
            _delayImageView.image = Image(@"DelayBtnHighLight");
            _delayLabel.hidden = NO;
            _delayLabel.text = [NSString stringWithFormat: @"10 %@",STR(@"Second")];
        }
            break;
        default:
            break;
    }
    
}

@end
