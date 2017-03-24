//
//  YMCommentDB.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/22.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "YMCommentDB.h"
#import "YMSqlConst.h"

#define YMCommentDBName @"UserCommentsDB.sqlite"

@interface YMCommentDB ()

@property (nonatomic, strong) NSString        *filePath;

@property (nonatomic, strong) FMDatabase      *db;
@property (nonatomic, strong) FMResultSet     *result;
@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation YMCommentDB

#pragma mark - 初始化当前类
+ (YMCommentDB *)shareInstance {
    static YMCommentDB *sigleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sigleton = [[self alloc] init];
        [sigleton creatCommentTable];
    });
    return sigleton;
}

- (id)init {
    self = [super init];
    if (self) {
        _db = [[FMDatabase alloc] initWithPath:self.filePath];
        _queue = [FMDatabaseQueue databaseQueueWithPath:self.filePath];//串行队列
    }
    return self;
}

#pragma mark - 创建
- (void)creatCommentTable {
    
    // 打开数据库
    [self.db open];
    
    // 创建数据库
    BOOL isSuccess = [self.db executeUpdate:Create_CommentsTable];
    if (isSuccess) {
        NSLog(@"create table success, filePath: %@", self.filePath);
    }else{
        NSLog(@"failed create table, error: %@", [self.db lastErrorMessage]);
    }
    
    // 关闭数据库
    [self.db close];
}

#pragma mark - 更新
// 插入单条数据
- (void)insertCommentWithModel:(id)dataModel {
    
    [self.db open];
    
    ComModel *model = dataModel;
    BOOL isSuccess = [self.db executeUpdate:Insert_CommentsTable withArgumentsInArray:[model toParamArray]];
    if (isSuccess) {
        NSLog(@"insert one comment success");
    }else{
        NSLog(@"insert one comment fail, error: %@", [self.db lastErrorMessage]);
    }
    
    [self.db close];
}

// 批量插入数据
- (void)batchInsertCommentsWithDataArr:(NSArray *)dataArr {
    
    if (dataArr.count < 1) {
        return;
    }
    
    FMDatabase *db = self.db;
    [db open];
    //开启事务
    [db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (int i = 0; i < dataArr.count; i++) {
            ComModel *model = dataArr[i];
            NSArray *sqlDataArr = @[
                                    @(model.myUserId),
                                    @(model.userId),
                                    model.realName,
                                    model.avatarUrl,
                                    model.content,
                                    @(model.createTime),
                                    model.smallImgUrl,
                                    @(model.messageType),
                                    @(model.readType),
                                    ];
            BOOL isSuccess = [db executeUpdate:Insert_CommentsTable withArgumentsInArray:sqlDataArr];
            if (!isSuccess) {
                NSLog(@"update comments fail, error : %@", [self.db lastErrorMessage]);
            }
        }
    }
    @catch (NSException *exception) {
        //rollback为YES时,事务回退
        isRollBack = YES;
        [db rollback];
    }
    @finally {
        if (!isRollBack) {
            //提交事务.只有事务提交了,开启事务期间的操作才会生效.
            [db commit];
        }
    }
}

// 更新已读/未读状态
- (void)updateCommentsReadType:(ComModel *)model {
    
    [self.db open];
    BOOL isSuccess = [self.db executeUpdate:Update_CommentsTable, @(model.readType).description, @(model.Id).description];
    if (isSuccess) {
        NSLog(@"update readtype success");
    }else{
        NSLog(@"readtype update fail, error: %@", [self.db lastErrorMessage]);
    }
    [self.db close];
}

#pragma mark - 查询
// 查询全部数据
- (NSArray *)quaryAllCommentsData {
    NSMutableArray *dataArr = [NSMutableArray array];
    
    [self.db open];
    FMResultSet *res = [self.db executeQuery:Select_AllData_CommentsTable];
    while ([res next]) {
        NSDictionary *dic = [res resultDictionary];
        ComModel *model = [ComModel mj_objectWithKeyValues:dic];
        [dataArr addObject:model];
    }
    [res close];
    [self.db close];
    
    return dataArr;
}

// 根据 UserId 查询数据
- (NSArray *)getCommentsWithUserId:(NSInteger)userId {
    NSMutableArray *dataArr = [NSMutableArray array];
    
    [self.db open];
    FMResultSet *res = [self.db executeQuery:Select_Comment_ByUserId, @(userId)];
    while ([res next]) {
        NSDictionary *dic = [res resultDictionary];
        ComModel *model = [ComModel mj_objectWithKeyValues:dic];
        [dataArr addObject:model];
    }
    [res close];
    [self.db close];
    
    return dataArr;
}

// 分页查询
- (NSArray *)getCommentsListWithRange:(NSRange)range {
    
    NSMutableArray *dataArr = [NSMutableArray array];
    [self.db open];
    FMResultSet *res = [self.db executeQuery:Select_CommentList_WithRange, range.location, range.length];
    while ([res next]) {
        NSDictionary *dic = [res resultDictionary];
        ComModel *model = [ComModel mj_objectWithKeyValues:dic];
        [dataArr addObject:model];
    }
    return dataArr;
}

// 查询数据是否存在
- (BOOL)isExistWithId:(NSString *)idStr {
    BOOL isExist = NO;
    
    FMResultSet *res = [self.db executeQuery:Select_Comment_WithId];
    while ([res next]) {
        if ([res stringForColumn:@"Id"]) {
            isExist = YES;
        } else {
            isExist = NO;
        }
    }
    return isExist;
}

#pragma mark - 删除
- (void)deleteCommentsData {
    
    [self.db open];
    BOOL isSuccess = [self.db executeUpdate:Delete_CommentsTable];
    if (isSuccess) {
        NSLog(@"delete table success");
    }else{
        NSLog(@"delete table fail, error: %@", [self.db lastErrorMessage]);
    }
    [self.db close];
}

#pragma mark - 多线程
- (void)multithread:(NSInteger)count {
    
    if (count <= 0) {
        return;
    }
    
    dispatch_queue_t queueA = dispatch_queue_create("queueA", NULL);
    dispatch_queue_t queueB = dispatch_queue_create("queueB", NULL);
    
    __block typeof(self) weakSelf = self;
    dispatch_async(queueA, ^{
        for (int i = 0; i < count; i++) {
            [weakSelf.queue inDatabase:^(FMDatabase *db) {
                
                NSString *realName = [NSString stringWithFormat:@"HarbingWang-%d", i];
                NSString *content  = [NSString stringWithFormat:@"多线程测试数据,随机数:%d", RandomNumber];
                NSString *sql = @"INSERT OR REPLACE INTO YMCommentDB (realName,content) values (?,?)";
                
                BOOL res = [db executeUpdate:sql, realName, content];
                if (res) {
                    NSLog(@"add data success: %@", realName);
                } else {
                    NSLog(@"add data fail, error: %@", [db lastErrorMessage]);
                }
            }];
        }
    });
    
    dispatch_async(queueB, ^{
        for (int i = 0; i < count; i++) {
            [weakSelf.queue inDatabase:^(FMDatabase *db) {
                
                NSString *realName = [NSString stringWithFormat:@"XiaoMouse-%d", i];
                NSString *content  = [NSString stringWithFormat:@"多线程测试数据,随机数:%d", RandomNumber];
                NSString *sql = @"INSERT OR REPLACE INTO YMCommentDB (realName,content) values (?,?)";
                
                BOOL res = [db executeUpdate:sql, realName, content];
                if (res) {
                    NSLog(@"add data success: %@", realName);
                } else {
                    NSLog(@"add data fail, error: %@", [db lastErrorMessage]);
                }
            }];
        }
    });
}

//#pragma mark - 检查对象成员变量是否存在nil值，存在则给成员变量赋值空字符串对象.返回对象
//- (ComModel *)checkCommentInfo:(ComModel *)model {
//
//}

#pragma mark - getter
- (NSString *)filePath {
    if (!_filePath) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _filePath = [doc stringByAppendingPathComponent:YMCommentDBName];
    }
    return _filePath;
}

@end
