//
//  UIColor+Extensions.h
//  Health Management
//
//  Created by Tour on 16/8/9.
//  Copyright © 2016年 Kingdee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

+ (UIColor *)colorWithHex:(long)hexColor;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha;

@end