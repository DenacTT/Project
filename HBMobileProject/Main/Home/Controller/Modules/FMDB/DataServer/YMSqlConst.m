//
//  YMSqlConst.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/22.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "YMSqlConst.h"

@implementation YMSqlConst

NSString * const Create_CommentsTable = @"CREATE TABLE IF NOT EXISTS YMCommentDB (Id integer NOT NULL primary key autoincrement,myUserId integer DEFAULT 0,userId integer DEFAULT 0,realName text DEFAULT 0,avatarUrl text DEFAULT 0,content text DEFAULT 0,createTime integer DEFAULT 0,smallImgUrl text DEFAULT 0,messageType integer DEFAULT 0,readType integer DEFAULT 0,t1 text default 0,t2 text default 0,t3 text default 0,t4 text default 0)";

NSString * const Insert_CommentsTable = @"INSERT OR REPLACE INTO YMCommentDB (myUserId,userId,realName,avatarUrl,content,createTime,smallImgUrl,messageType,readType) values (?,?,?,?,?,?,?,?,?)";

NSString * const Select_AllData_CommentsTable = @"SELECT * from YMCommentDB";

NSString * const Select_Comment_ByUserId = @"SELECT * from YMCommentDB where myUserId = ? ORDER by createTime desc";

NSString * const Select_CommentList_WithRange = @"SELECT * FROM UserInfoDB LIMIT %lu, %lu";

NSString * const Select_Comment_WithId = @"SELECT * FROM UserInfoDB WHERE Id = ?";

NSString * const Update_CommentsTable = @"UPDATE YMCommentDB SET readType = ? WHERE Id = ?";

NSString * const Delete_CommentsTable = @"DELETE from YMCommentDB";

@end
