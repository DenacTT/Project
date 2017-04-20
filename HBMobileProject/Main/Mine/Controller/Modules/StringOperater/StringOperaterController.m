//
//  StringOperaterController.m
//  HBMobileProject
//
//  Created by HarbingWang on 2017/4/20.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "StringOperaterController.h"

@interface StringOperaterController ()

@end

@implementation StringOperaterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isUseBackBtn = YES;
    self.titleLabel.text = @"字符串处理";
    
    // Example 01
    NSString *str = @"abcdef<asljsf>fed<123>cba<hhhhhhh>";
//    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\\<\\>"];
//    str = [str stringByTrimmingCharactersInSet:set];
    NSString *result = [self handleStringWithString:str];
    NSLog(@"%@" , result);
}

// 去除字符串中用括号括住的位置
- (NSString *)handleStringWithString:(NSString *)str{
    
    NSMutableString * muStr = [NSMutableString stringWithString:str];
    while (1) {
        NSRange range = [muStr rangeOfString:@"<"];
        NSRange range1 = [muStr rangeOfString:@">"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            [muStr deleteCharactersInRange:NSMakeRange(loc, len + 1)];
        }else{
            break;
        }
    }
    return muStr;
}

@end
