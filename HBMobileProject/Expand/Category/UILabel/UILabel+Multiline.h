//
//  UILabel+Multiline.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Multiline)

/**
 * 单行显示
 */
@property (nonatomic, assign, setter=setSingleLine:) BOOL isSingleLine;

@property (nonatomic, assign) CGSize labelTextSize; // 属性不能是 textSize;

/**
 *  设置文本多行可控间距显示
 *
 *  @param  text    文本
 *  @param  lines    行数 lines = 0 不限制行数,文本显示不足 lines 时正常显示,超过 lines 时结尾部分的内容以...方式省略.
 *  @param  lineSpacing    行间距
 *  @param  constrainerSize    文本显示的最大区域
 *
 *  @return 文本占用的 Size
 */
- (CGSize)setText:(NSString *)text lines:(NSInteger)lines andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)constrainerSize;

/**
 *  计算文本占用的size
 *
 *  @param text        文本
 *  @param lines       行数，lines = 0不限制行数
 *  @param font        字体类型
 *  @param lineSpacing 行间距
 *  @param cSize       文本显示的最大区域
 *
 *  @return 文本占用的size
 */
+ (CGSize)sizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont *)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)constrainerSize;

@end
