//
//  ComModel.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/22.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "ComModel.h"

@implementation ComModel

+ (ComModel *)initWithDic:(NSDictionary *)dic {
    
    ComModel *model = [[ComModel alloc] init];
    model.myUserId  = [[dic objectForKey:@"myUserId"] integerValue];
    model.userId    = [[dic objectForKey:@"userId"] integerValue];
    model.realName  = [dic objectForKey:@"realName"];
    model.avatarUrl = [dic objectForKey:@"avatarUrl"];
    model.content   = [dic objectForKey:@"content"];
    model.createTime  = [[dic objectForKey:@"createTime"] doubleValue]/1000;
    model.smallImgUrl = [dic objectForKey:@"smallImgUrl"];
    model.messageType = [[dic objectForKey:@"messageType"] integerValue];
    model.readType    = [[dic objectForKey:@"readType"] integerValue];
    
    return model;
}

- (NSArray *)toParamArray {
    NSArray *paramArray = [NSArray arrayWithObjects:
                           @(self.myUserId),
                           @(self.userId),
                           self.realName,
                           self.avatarUrl,
                           self.content,
                           @(self.createTime),
                           self.smallImgUrl,
                           @(self.messageType),
                           @(self.readType),
                           nil];
    return paramArray;
}

@end
