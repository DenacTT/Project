//
//  YMCommentDB.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/22.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComModel.h"
#import "FMDB.h"

@interface YMCommentDB : NSObject

// 初始化当前类
+ (YMCommentDB *)shareInstance;

// 创建表格
- (void)creatCommentTable;

// 插入单条数据
- (void)insertCommentWithModel:(id)dataModel;

// 批量插入数据
- (void)batchInsertCommentsWithDataArr:(NSArray *)dataArr;

// 查询所有数据
- (NSArray *)quaryAllCommentsData;

// 根据 UserId 查询数据
- (NSArray *)getCommentsWithUserId:(NSInteger)userId;

// 修改状态
- (void)updateCommentsReadType:(ComModel *)model;

// 删除数据
- (void)deleteCommentsData;

// 多线程操作
- (void)multithread:(NSInteger)count;

@end
