//
//  YMDataAdapter.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "YMDataAdapter.h"
#import "TextBarGroupModel.h"

@implementation YMDataAdapter

- (id)getLocalMsgListData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MsgList" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    //NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        TextBarGroupModel *model = [TextBarGroupModel mj_objectWithKeyValues:dic];
        [dataArr addObject:model];
    }
    
    return dataArr;
}

@end
