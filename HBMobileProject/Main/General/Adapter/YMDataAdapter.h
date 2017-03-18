//
//  YMDataAdapter.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDataAdapter : NSObject

// 获取本地 plist 文件数据
- (id)getLocalMsgListData;

// 获取测试数据
- (NSArray *)getTestData;

@end
