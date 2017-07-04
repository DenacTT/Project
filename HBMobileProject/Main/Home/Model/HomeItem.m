//
//  HomeItem.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/6/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "HomeItem.h"

@interface HomeItem ()

@property (nonatomic, strong) NSMutableAttributedString *nameString;

@end

@implementation HomeItem

+ (instancetype)itemWithClassName:(NSString *)className object:(id)object {
    
    HomeItem *item = [[[self class] alloc] init];
    item.className = className;
    item.object    = object;
    return item;
}

- (void)createAttributedString {
    
    NSString *fullString = [NSString stringWithFormat:@"%02ld. %@", (long)self.index, self.className];
    NSMutableAttributedString *richString = [[NSMutableAttributedString alloc] initWithString:fullString];
    
    self.nameString = richString;
}

@end
