//
//  String.m
//  BlanKString
//
//  Created by HarbingWang on 16/8/29.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "String.h"

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation String

+ (BOOL)isBlankString:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if (string == nil)
    {
        return YES;
    }
    
    if (string == NULL)
    {
        return YES;
    }
    
    if (string == Nil)
    {
        return YES;
    }
    
    if (![string isKindOfClass:[NSString class]])
    {
        return YES;
    }
    
    if ([string isEqualToString:@"NULL"] || [string isEqualToString:@"nil"] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])
    {
        return YES;
    }
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([string isEqualToString:@""] || [string isEqualToString:@" "])
    {
        return YES;
    }
    
    return NO;
}

+ (NSString *)checkString:(NSString *)string
{
    NSString *str = [NSString stringWithFormat:@"%@", string];
    if ([String isBlankString:str])
    {
        return @"";
    }
    return str;
}

+ (BOOL)string:(NSString *)string containsString:(NSString *)anotherString
{
    if ([String isBlankString:string] || [String isBlankString:anotherString])
    {
        return NO;
    }
    
    if (IOS_VERSION >= 8.f)
    {
        if ([string containsString:anotherString])
        {
            return YES;
        }
    }else
    {
        if ([string rangeOfString:anotherString].location != NSNotFound)
        {
            return YES;
        }
    }
    return NO;
}

@end
