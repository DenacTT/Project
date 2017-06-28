//
//  PlaceholderImageView.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/6/27.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "PlaceholderImageView.h"
#import "UIImageView+WebCache.h"

@interface PlaceholderImageView()

@property (nonatomic, strong) UIImageView *placeholderImageView;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) NSString *placeholderUrlString;

@end

@implementation PlaceholderImageView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.placeholderImageView.frame = self.bounds;
    self.contentImageView.frame     = self.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.layer.masksToBounds = YES;
        self.placeholderImageView   = [[UIImageView alloc] initWithFrame:self.bounds];
        self.contentImageView       = [[UIImageView alloc] initWithFrame:self.bounds];
        
        self.placeholderImageView.contentMode   = UIViewContentModeScaleAspectFill;
        self.contentImageView.contentMode       = UIViewContentModeScaleAspectFill;
        
        [self addSubview:self.placeholderImageView];
        [self addSubview:self.contentImageView];
    }
    return self;
}

+ (instancetype)placeholderImageViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)image {
    
    PlaceholderImageView *placeholderImageView = [[PlaceholderImageView alloc] initWithFrame:frame];
    placeholderImageView.placeholderImage = image;
    return placeholderImageView;
}

#pragma mark - Setter
- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImageView.image = placeholderImage;
}

- (void)setUrlString:(NSString *)urlString {
    
    _placeholderUrlString = urlString;
    _contentImageView.alpha = 0.f;
    
    NSURL *url = [NSURL URLWithString:urlString];
    [_contentImageView sd_setImageWithURL:url placeholderImage:self.placeholderImage options:SDWebImageRetryFailed | SDWebImageContinueInBackground completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            // Image load from disk or download from network.
            if (cacheType == SDImageCacheTypeNone || cacheType == SDImageCacheTypeDisk) {
                [UIView animateWithDuration:0.8f animations:^{
                    _contentImageView.alpha = 1.f;
                }];
            } else {
                _contentImageView.alpha = 1.f;
            }
        }
    }];
}

#pragma mark - Getter
- (UIImage *)placeholderImage {
    return _placeholderImageView.image;
}

- (NSString *)urlString {
    return _placeholderUrlString;
}

@end
