//
//  UILabel+Expand.h
//  scale
//
//  Created by HarbingWang on 16/10/17.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Expand)

- (void)setLineSpace:(NSInteger)lineSpace;

- (void)setLabelTextFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

- (void)setLabelText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

@end
