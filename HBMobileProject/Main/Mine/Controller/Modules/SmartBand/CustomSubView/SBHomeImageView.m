//
//  SBHomeImageView.m
//  HBMobileProject
//
//  Created by HarbingWang on 2017/4/8.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBHomeImageView.h"
@implementation SBHomeImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.colorsImage];
        [self addSubview:self.hexagonImage];
        [self addSubview:self.starImage];
    }
    return self;
}

- (UIImageView *)starImage {
    if (!_starImage) {
        _starImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _starImage.image = Image(@"sb_home_finish_star");
    }
    return _starImage;
}

- (UIImageView *)colorsImage {
    if (!_colorsImage) {
        _colorsImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _colorsImage.image = Image(@"sb_home_finish_colors");
    }
    return _colorsImage;
}

- (UIImageView *)hexagonImage {
    if (!_hexagonImage) {
        _hexagonImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _hexagonImage.image = Image(@"sb_home_finish_hexagon");
    }
    return _hexagonImage;
}

@end
