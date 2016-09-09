//
//  YMChangeAccountSuccessView.m
//  scale
//
//  Created by zxq on 16/3/23.
//  Copyright © 2016年 zxq. All rights reserved.
//

#import "YMChangeAccountSuccessView.h"
//#import "UIColor+Extend.h"
#import "NSString+Extend.h"

@interface YMChangeAccountSuccessView ()

@property (nonatomic, strong)UILabel* explainLabel;

@end

@implementation YMChangeAccountSuccessView

- (void)showWithTxt:(NSString *)str
{
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16]];
    self.backgroundColor      = [[UIColor blackColor] colorWithAlphaComponent:0.8]; /*  正常情况下，设置父视图的alpha值，其子视图会随着父视图的alpha改变。如果要设置子视图不随父视图的alpha的改变而改变，就不能单纯的设置父视图的alpha值。这时候可以设置父视图的背景颜色。[[UIColor blackColor] colorWithAlphaComponent:0.5]。xib里也可以通过设置背景色的方式达到该效果。*/
    self.layer.cornerRadius   = 5;
    self.clipsToBounds        = YES;
    self.width        = size.width + 56.f;
    
    if (self.width >= (ScreenWidth - 56))
    {
        self.width = (ScreenHeight - 56);
    }
    
    
    self.height       = 49.f;
    self.left         = (ScreenWidth-self.width)/2;
    self.top          = (ScreenHeight-self.height)/2 - 20.f;
    self.alpha        = 0;
    [[self getMainWindow]addSubview:self];
    
    [self layoutViews];
    
    _explainLabel.text          = str;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.8f animations:^{
        weakSelf.alpha = 1.f;
    } completion:^(BOOL finished) {
        [weakSelf animat];
    }];
}

- (void)layoutViews
{
    [self addSubview:self.explainLabel];
}
- (UILabel *)explainLabel
{
    if (!_explainLabel)
    {
        _explainLabel = [[UILabel alloc] init];
        
        _explainLabel.font          = [UIFont systemFontOfSize:16];
        _explainLabel.textColor     = [UIColor whiteColor];
        _explainLabel.height        = 17+2;
        _explainLabel.top           = (self.height-_explainLabel.height)/2;
        _explainLabel.left          = 0;
        _explainLabel.width         = self.width;
        
        _explainLabel.textAlignment = NSTextAlignmentCenter;
        
//        _explainLabel.layer.borderWidth = 1.0f;
//        _explainLabel.layer.borderColor = [UIColor redColor].CGColor;
    }
    return _explainLabel;
}
- (void)animat
{
    [self performSelector:@selector(animation) withObject:nil afterDelay:0.f];
}
- (void)animation
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.8f animations:^{
        weakSelf.explainLabel.alpha = 0;
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
