//
//  YMSuccessView.m
//  scale
//
//  Created by zxq on 16/3/23.
//  Copyright © 2016年 zxq. All rights reserved.
//

#import "YMSuccessView.h"
//#import "UIFont+Extend.h"
#import "NSString+Extend.h"

@interface YMSuccessView ()

@property (nonatomic, strong)UIImageView* yesImageView;
@property (nonatomic, strong)UILabel* explainLabel;

@end


@implementation YMSuccessView

-(void) showWithText:(NSString *)str
{
    UIImage* img = Image(@"success");
    self.width      = img.size.width;
    self.height     = img.size.height;
    self.left       = (ScreenWidth-self.width)/2;
    self.top        = (ScreenHeight-self.height)/2;
    self.alpha      = 0;
    [[self getMainWindow] addSubview:self];
    
    [self layoutViews];
    _explainLabel.text = str;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1.f animations:^{
        weakSelf.alpha = 1.f;
    } completion:^(BOOL finished) {
        [weakSelf animat];
    }];
}

- (void)layoutViews
{
    [self addSubview:self.yesImageView];
    [self addSubview:self.explainLabel];
}
- (UIImageView *)yesImageView
{
    if (!_yesImageView)
    {
        _yesImageView = [[UIImageView alloc] init];
        
        UIImage* img = Image(@"success");
        _yesImageView.width         = img.size.width;
        _yesImageView.height        = img.size.height;
        _yesImageView.top           = 0;
        _yesImageView.left          = 0;
        _yesImageView.image         = img;
    }
    return _yesImageView;
}
- (UILabel *)explainLabel
{
    if (!_explainLabel)
    {
        _explainLabel = [[UILabel alloc] init];
        
//        _explainLabel.text          = @"保存成功";
        _explainLabel.textColor     = [UIColor whiteColor];
        _explainLabel.font          = [UIFont systemFontOfSize:14];
        _explainLabel.textAlignment = NSTextAlignmentCenter;
//        CGSize size = [_explainLabel.text YMSizeWithFont:_explainLabel.font];
        _explainLabel.width         = _yesImageView.width;
        _explainLabel.height        = 14+2;
        _explainLabel.left = (self.width - _explainLabel.width) / 2;
        _explainLabel.top = _yesImageView.height - 17.f - _explainLabel.height;
    }
    return _explainLabel;
}


- (void)animat
{
    [self performSelector:@selector(animation) withObject:nil afterDelay:0.0f];
}
- (void)animation
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1.f animations:^{
        weakSelf.yesImageView.alpha = 0;
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
}

#pragma mark - getMainWindow
- (UIWindow *)getMainWindow
{
    NSArray *windowArr = [[UIApplication sharedApplication]windows];
    
    if (windowArr && [windowArr count]>0)
    {
        UIWindow *window = [windowArr objectAtIndex:0];
        
        if ([window isKindOfClass:[UIWindow class]])
        {
            return window;
        }
    }
    return nil;
}

@end
