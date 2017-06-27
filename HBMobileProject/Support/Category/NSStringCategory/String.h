//
//  String.h
//  BlanKString
//
//  Created by HarbingWang on 16/8/29.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface String : NSObject

//检查字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;

+ (NSString *)checkString:(NSString *)string;

//检查字符串 string 里面是否包含有字符串 anotherString
+ (BOOL)string:(NSString *)string containsString:(NSString *)anotherString;

@end
