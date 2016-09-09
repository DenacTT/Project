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

- (CGSize)sizeWithFont: (UIFont *)font constrainedToSize: (CGSize)size
{
    CGSize retSize;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    retSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return retSize;
}

- (CGSize)sizeWithFont: (UIFont *)font andParagraphStyle: (NSParagraphStyle*)style constrainedToSize: (CGSize)size
{

}

- (CGFloat)countTextHeightWithFont:(UIFont *)font width:(CGFloat)width
{

}

- (CGFloat)countTextWidthWithFont:(UIFont *)font height:(CGFloat)height
{
    
}

@end
