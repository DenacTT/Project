//
//  NSString+frame.m
//  scale
//
//  Created by GeorgeYe on 16/1/9.
//  Copyright © 2016年 GeorgeYe. All rights reserved.
//

#import "NSString+frame.h"

@implementation NSString (frame)


- (CGFloat)widthOfString:(NSString *)string withFont:(NSFont *)font
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

@end
