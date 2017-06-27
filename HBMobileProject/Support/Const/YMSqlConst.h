//
//  YMSqlConst.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/22.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMSqlConst : NSObject

// extern修饰的全局变量默认是有外部链接的，作用域是整个工程
// static修饰的全局静态变量，作用域是声明此变量所在的文件

extern NSString * const Create_CommentsTable;// 创建数据库

extern NSString * const Insert_CommentsTable;// 插入数据库

extern NSString * const Select_AllData_CommentsTable;// 查询全部数据

extern NSString * const Select_Comment_ByUserId;// 通过 UserId 查询数据库

extern NSString * const Select_CommentList_WithRange;// 分页查询

extern NSString * const Select_Comment_WithId;// 查询数据是否已经存在

extern NSString * const Update_CommentsTable;// 修改数据库

extern NSString * const Delete_CommentsTable;// 删除数据库

@end
