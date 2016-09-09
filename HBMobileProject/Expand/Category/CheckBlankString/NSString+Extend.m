//
//  NSString+Extend.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)

- (CGSize)sizeWithFont: (UIFont*)font
{
    CGSize retSize;
    retSize = [self sizeWithAttributes:@{NSFontAttributeName : font}];
    return retSize;
}

/**********************
 // NSParagraphStyle
 typedef NS_ENUM(NSInteger, NSLineBreakMode) {
     NSLineBreakByWordWrapping = 0,     	// 以 单词 为显示单位显示, 后面部分省略不显示. default 值
     NSLineBreakByCharWrapping,             // 以 字符 为显示单位显示, 后面部分省略不显示.
     NSLineBreakByClipping,                        //  简单剪切方式, 剪切与文本宽度相同的内容长度, 后半部分会被删除.
     NSLineBreakByTruncatingHead,          // "...wxyz" 前面部分文字以 ... 方式省略, 显示尾部文字内容.
     NSLineBreakByTruncatingTail,             // "abcd..." 结尾部分的内容以 ... 方式省略, 显示头的文字内容.
     NSLineBreakByTruncatingMiddle         // "ab...yz" 中间的内容以 ... 方式省略, 显示头尾的文字内容.
 }
 **********************/

/**********************
 boundingRectWithSize:options:attributes:计算文本尺寸,返回文本绘制所占据的矩形空间
 第一个参数跟以前方法一样，是传入一个CGSize结构体, 宽高限制，用于计算文本绘制时占据的矩形块
 
 第二个参数 options 是个配置选项
 * NSStringDrawingTruncatesLastVisibleLine：如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果没有指定NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略。
 * NSStringDrawingUsesLineFragmentOrigin：绘制文本时使用 line fragement origin 而不是 baseline origin。
 * NSStringDrawingUsesFontLeading：计算行高时使用行距。（译者注：字体大小+行间距=行距）
 * NSStringDrawingUsesDeviceMetrics：计算布局时使用图元字形（而不是印刷字体）。
 
 第三个参数 attributes 是NSAttributeString的属性，是个字典类型的对象，传入字体,段落样式等. 例如: NSDictionary *attrs = @{NSFontAttributeName : font};
 
 最后一个参数 context 上下文 包括一些信息，例如如何调整字间距以及缩放。最终，该对象包含的信息将用于文本绘制。该参数可为 nil
 **********************/

- (CGSize)sizeWithFont: (UIFont *)font constrainedToSize: (CGSize)size
{
    CGSize retSize;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    
    retSize = [self boundingRectWithSize: size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraph.copy} context:nil].size;
    return retSize;
}

- (CGSize)sizeWithFont: (UIFont *)font andParagraphStyle: (NSParagraphStyle*)style constrainedToSize: (CGSize)size
{
    CGSize retSize;
    retSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : style} context:nil].size;
    return retSize;
}

- (CGFloat)countTextHeightWithFont:(UIFont *)font width:(CGFloat)width
{
    CGRect retToFit = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil];
    return retToFit.size.height;
}

- (CGFloat)countTextWidthWithFont:(UIFont *)font height:(CGFloat)height
{
    CGRect rectToFit = [self boundingRectWithSize:CGSizeMake(ScreenWidth, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil];
    return rectToFit.size.width;
}

@end
