//
//  CustomTipsView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "CustomTipsView.h"

@interface CustomTipsView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation CustomTipsView

- (void)showWithText:(NSString *)text
{
    CGSize size = [text sizeWithFont:Font(16)];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8]; /*  正常情况下，设置父视图的alpha值，其子视图会随着父视图的alpha改变。如果要设置子视图不随父视图的alpha的改变而改变，就不能单纯的设置父视图的alpha值。这时候可以设置父视图的背景颜色。[[UIColor blackColor] colorWithAlphaComponent:0.5]。xib里也可以通过设置背景色的方式达到该效果。*/
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    self.width = size.width + 56.f;
    if (self.width >= ScreenWidth-56) {
        self.width = ScreenWidth-56;
    }
    
    self.height = 49.f;
    self.left = (ScreenWidth - self.width) / 2;
    self.top = (ScreenHeight - self.height) / 2 - 20.f;
    
    self.alpha = 0.f;
    
    // 将提示视图添加到 Window 上
    [[MPTools getMainWindow] addSubview:self];
    
    [self layoutViews];
    
    _textLabel.text = text;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.8f animations:^{
        weakSelf.alpha = 1.f;
    } completion:^(BOOL finished) {
        [weakSelf animat];
    }];
}

#pragma mark - layoutViews
- (void)layoutViews
{
    [self addSubview:self.textLabel];
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        self.textLabel = [[UILabel alloc] init];
        
        _textLabel.font = Font(16);
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.height = 17+2;
        _textLabel.top = (self.height - _textLabel.height) / 2;
        _textLabel.left = 0;
        _textLabel.width = self.width;
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
//        _textLabel.layer.borderWidth = 1.0f;
//        _textLabel.layer.borderColor = [UIColor redColor].CGColor;
//        [self addSubview:self.textLabel];
    }
    return _textLabel;
}

#pragma mark - showWithAnimation
- (void)animat
{
    [self performSelector:@selector(animation) withObject:nil afterDelay:0.5f];
}

- (void)animation
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.8f animations:^{
        weakSelf.textLabel.alpha = 0;
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
