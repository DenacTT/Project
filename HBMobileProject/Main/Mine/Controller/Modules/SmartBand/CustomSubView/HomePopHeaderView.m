//
//  HomePopHeaderView.m
//  HBMobileProject
//
//  Created by HarbingWang on 2017/4/6.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "HomePopHeaderView.h"

@implementation HomePopHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        self.backgroundColor = RGBA(70, 70, 70, 0.9);
        [self addSubview:self.productIcon];
        [self addSubview:self.productName];
    }
    return self;
}

#pragma mark - Getter
- (UIImageView *)productIcon {
    if (!_productIcon) {
        _productIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(self.bounds)/2-32/2, 32, 32)];
    }
    return _productIcon;
}

- (UILabel *)productName {
    if (!_productName) {
        _productName = [[UILabel alloc] initWithFrame:CGRectMake(self.productIcon.right+10, 0, CGRectGetWidth(self.bounds)-10*2-32, CGRectGetHeight(self.bounds))];
        [_productName setLabelText:@"Scale Model"
                              font:Font(14.f)
                         textColor:RGB(136, 136, 136)
                     textAlignment:NSTextAlignmentLeft];
    }
    return _productName;
}

@end
