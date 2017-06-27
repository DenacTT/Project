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

#pragma mark - 创建
// 创建表格
- (void)creatCommentTable;

#pragma mark - 更新
// 插入单条数据
- (void)insertCommentWithModel:(id)dataModel;

// 批量插入数据
- (void)batchInsertCommentsWithDataArr:(NSArray *)dataArr;

#pragma mark - 查询
// 查询全部数据
- (NSArray *)quaryAllCommentsData;

// 根据 UserId 查询数据
- (NSArray *)getCommentsWithUserId:(NSInteger)userId;

// 分页查询
- (NSArray *)getCommentsListWithRange:(NSRange)range;

// 修改状态
- (void)updateCommentsReadType:(ComModel *)model;

// 查询数据是否已经存在
- (BOOL)isExistWithId:(NSString *)idStr;

#pragma mark - 删除
// 删除数据
- (void)deleteCommentsData;

#pragma mark - 多线程
// 多线程操作
- (void)multithread:(NSInteger)count;

@end
