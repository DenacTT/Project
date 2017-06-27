//
//  NSString+Extend.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

@interface NSString (Extend)

/**
 *  @author HarbingWang, 16-09-09 20:09:43
 *
 *  根据字体大小计算 Size
 *
 *  @param font 字体大小
 *
 *  @return 返回 size
 */
- (CGSize)sizeWithFont: (UIFont*)font;

/**
 *  @author HarbingWang, 16-09-09 20:09:33
 *
 *  计算 Size
 *
 *  @param font 字体大小
 *  @param size 容器Size
 *
 *  @return 计算后的 Size
 */
- (CGSize)sizeWithFont: (UIFont *)font constrainedToSize: (CGSize)size;

/**
 *  @author HarbingWang, 16-09-09 20:09:06
 *
 *  计算Size
 *
 *  @param font   字体大小
 *  @param style 段落样式
 *  @param size  容器大小
 *
 *  @return 返回 Size
 */
- (CGSize)sizeWithFont: (UIFont *)font andParagraphStyle: (NSParagraphStyle*)style constrainedToSize: (CGSize)size;

/**
 *  @author HarbingWang, 16-09-09 20:09:47
 *
 *  计算文字高度
 *
 *  @param font  字体大小
 *  @param width 固定宽度
 *
 *  @return 返回字体高度
 */
- (CGFloat)countTextHeightWithFont:(UIFont *)font width:(CGFloat)width;

/**
 *  @author HarbingWang, 16-09-09 20:09:42
 *
 *  计算文字宽度
 *
 *  @param font   字体大小
 *  @param height 固定高度
 *
 *  @return 返回宽度
 */
- (CGFloat)countTextWidthWithFont:(UIFont *)font height:(CGFloat)height;

@end
