
FMDB温故笔记

##### FMDB 简介
SQLite是一个轻量级的关系型数据库,在使用的时候只需要加入`libsqlite3.tbd`的依赖并引入`sqlite3.h`头文件即可. 但是,原生的`SQLite API`在使用上相当的不友好. 因此, [FMDB](https://github.com/ccgus/fmdb) 用 OC 的方式对其C语言的API进行了封装,使用起来比原生的 API 优雅了很多,同时,相较于 Apple 自带的 CoreDada 框架,也更加灵活. 此外, FMDB 还提供了多线程安全的操作数据库的方法,能够有效地防止数据读取的混乱.
FMDB 的缺陷: 由于其使用的是 OC 的语法封装,因此只能在 iOS 项目中使用,在跨平台操作的时候存在一定的局限性.

##### FMDB 使用说明
翻译自 fmdb 的 github 项目说明文档: [https://github.com/ccgus/fmdb](https://github.com/ccgus/fmdb)

FMDB同时兼容ARC和非ARC工程，会自动根据工程配置来调整相关的内存管理代码。
FMDB 三个主要的常用类:
`FMDatabase`: 代表一个 SQLite 数据库,用于执行 SQLite 语句;
`FMResultSet`: 代表 FMDatabase 的一个 SQL 查询的结果集;
`FMDatabaseQueue`: 如果你想在多个线程上执行数据库查询和更新的操作, 这个类会很有用.下面的”线程安全”部分,会重点介绍它.

##### FMDB 使用步骤
- 首先需要将 FMDB 从 [Github](https://github.com/ccgus/fmdb) 上下载下来,然后将文件拖入工程中(支持 CocoaPods);
- 在工程中添加`libsqlite3.tbd`依赖;
- #import "FMDB.h" 引入头文件;

###### 1.创建数据库
可以通过指定 SQLite 数据库文件的路径来创建一个 FMDatabase ,路径可以是以下几种方式中的任何一种:
- []一个完整的文件路径,如果文件不存在,会自动创建` A file system path. The file does not have to exist on disk. If it does not exist, it is created for you. `
- []一个空字符串(@""),会自动在缓存区创建一个空的数据库, FMDatabase 连接关闭时,数据库会被自动删除`An empty string (@""). An empty database is created at a temporary location. This database is deleted with the FMDatabase connection is closed.`
- []路径为 NULL ,会在内存中创建一个数据库,同样地, FMDatabase 连接关闭时,数据库会被自动删除`NULL. An in-memory database is created. This database will be destroyed with the FMDatabase connection is closed.`

```
NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"UserInfo.db"];
FMDatabase *db = [FMDatabase databaseWithPath:filePath];
```
**注意: 这里创建了数据库,并不会打开数据库,打开数据库需要接下来的操作.**

###### 2.打开数据库
使用`open`语句打开数据库,打开成功返回 YES, 打开失败返回 NO, 示例如下:
```
if (![db open]) {
  // error
  db = nil;
  return;
}
```
**说明**:只有"打开"的数据库才能执行各种操作,资源不足或者权限问题都将会导致数据库打开/创建失败.
`Before you can interact with the database, it must be opened. Opening fails if there are insufficient resources or permissions to open and/or create the database.`

###### 3.执行更新操作
使用`-executeUpdate...`方法执行更新操作，该方法返回BOOL型, 成功返回 YES, 失败返回 NO.
```
- (BOOL)executeUpdate:(NSString*)sql, ...
- (BOOL)executeUpdateWithFormat:(NSString*)format, ...
- (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments
```
**说明**: 除了`SELECT`外的SQL操作,都被视为更新操作.包括`CREATE`, `UPDATE`, `INSERT`, `ALTER`, `COMMIT`, `BEGIN`, `DETACH`, `DELETE`, `DROP`, `END`, `EXPLAIN`, `VACUUM`, and `REPLACE`等.

- 示例1,创建表:
```
[db executeUpdate:@"CREATE TABLE IF NOT EXISTS 'UserInfoTable' (Id integer NOT NULL primary key autoincrement,name text DEFAULT 0,age integer DEFAULT 0)"];
```

- 示例2,修改表:
`-executeUpdate:`使用标准的 SQL 语句,参数用?来占位,参数必须是对象类型,不能是 int,double,bool 等基本数据类型;
```
[db executeUpdate:@"UPDATE UserInfoTable SET name = ? WHERE Id = ?", userInfo.name, @(userInfo.id).description];
```

- 示例3,插入数据:
`-executeUpdateWithFormat:`使用字符串的格式化构建 SQL 语句,参数用%@、%d等来占位.
```
[db executeUpdateWithFormat:@"INSERT INTO UserInfoTable (name, age) values (%@,%d);", userInfo.name, userInfo.age];
```

- 示例4,插入数据:
`-executeUpdate:withArgumentsInArray:`也可以把对应的参数装到数组里面传进去,SQL语句中的参数用 ? 代替.
```
NSArray *sqlArr = @[userInfo.name, @(userInfo.age)];
[db executeUpdate:@"INSERT INTO UserInfoTable (name,age) values (?,?)" withArgumentsInArray:sqlArr];
```

###### 4.执行查询操作
使用 `-executeQuery...` 方法来执行数据库的查询操作,查询结果返回`FMResultSet`对象;
```
- (FMResultSet *)executeQuery:(NSString*)sql, ...
- (FMResultSet *)executeQueryWithFormat:(NSString*)format, ...
- (FMResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
```
示例
```
FMResultSet *set = [db executeQuery:@"SELECT * FROM UserInfoDTable"];
```
**注意:** 
- 1.为了遍历查询结果,需要使用 while() 语句遍历;
```
while ([set next]) {
  // 从每条记录中获取值
}
```

- 2.即使操作结果只有一行,也需要先调用 FMResultSet 的 next 方法.
```
FMResultSet *res = [db executeQuery:@"SELECT name(*) FROM UserInfoDTable"];
  while ([set next]) {
  NSString *name = [set stringForColumn:@"name"];
}
```

- 3.通常情况下,不需要关闭 FMResultSet, 因为相关的数据库关闭时,FMResultSet 也会被自动关闭。 `Typically, there's no need to -close an FMResultSet yourself, since that happens when either the result set is deallocated, or the parent database is closed.`

- 4.FMResultSet 提供了很多获取不同类型数据的方法:
```
// 获取下一个记录
- (BOOL)next;
// 获取记录有多少列
- (int)columnCount;
// 通过列名得到列序号，通过列序号得到列名
- (int)columnIndexForName:(NSString *)columnName;
- (NSString *)columnNameForIndex:(int)columnIdx;
// 获取存储的整形值
- (int)intForColumn:(NSString *)columnName;
- (int)intForColumnIndex:(int)columnIdx;
// 获取存储的长整形值
- (long)longForColumn:(NSString *)columnName;
- (long)longForColumnIndex:(int)columnIdx;
// 获取存储的布尔值
- (BOOL)boolForColumn:(NSString *)columnName;
- (BOOL)boolForColumnIndex:(int)columnIdx;
// 获取存储的浮点值
- (double)doubleForColumn:(NSString *)columnName;
- (double)doubleForColumnIndex:(int)columnIdx;
// 获取存储的字符串
- (NSString *)stringForColumn:(NSString *)columnName;
- (NSString *)stringForColumnIndex:(int)columnIdx;
// 获取存储的日期数据
- (NSDate *)dateForColumn:(NSString *)columnName;
- (NSDate *)dateForColumnIndex:(int)columnIdx;
// 获取存储的二进制数据
- (NSData *)dataForColumn:(NSString *)columnName;
- (NSData *)dataForColumnIndex:(int)columnIdx;
// 获取存储的UTF8格式的C语言字符串
- (const unsigned cahr *)UTF8StringForColumnName:(NSString *)columnName;
- (const unsigned cahr *)UTF8StringForColumnIndex:(int)columnIdx;
// 获取存储的对象，只能是NSNumber、NSString、NSData、NSNull
- (id)objectForColumnName:(NSString *)columnName;
- (id)objectForColumnIndex:(int)columnIdx
```
更多关于FMResultSet的使用方法可以参考:[FMResultSet Class Reference](http://ccgus.github.io/fmdb/html/Classes/FMResultSet.html#//api/name/kvcMagic:)

###### 5.关闭数据库
当完成了数据库的查询以及更新操作,**必须调用`close`语句关闭 FMDatabase 连接**,释放SQLite 使用的资源.
```
[db close];
```

// ##### FMDatabaseQueue的使用
// FMDatabase 这个类是线程不安全的,如果在多个线程间共用一个 FMDatabase 对象,将会引起数据混乱等现象.`So don't instantiate a single FMDatabase object and use it across multiple threads.`
// FMDB 提供了 `FMDatabaseQueue`类来保证线程安全. FMDatabaseQueue 使用起来非常便捷,首先使用一个数据库文件地址来初始化 FMDatabaseQueue ,然后就可以将一个闭包(block)传入`inDatabase`方法中.在闭包中操作数据库,而不是直接参与 FMDatabase 的管理;
```
// 创建
FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:aPath];

// 使用
[queue inDatabase:^(FMDatabase *db) {
[db executeUpdate:@"INSERT INTO myTable VALUES (?)", @1];
[db executeUpdate:@"INSERT INTO myTable VALUES (?)", @2];
[db executeUpdate:@"INSERT INTO myTable VALUES (?)", @3];

FMResultSet *rs = [db executeQuery:@"select * from foo"];
while ([rs next]) {
    …
  }
}];
```

#####事务
**事务**，是指作为单个逻辑工作单元执行的一系列操作，要么完整地执行，要么完全地不执行。
FMDB 开启事务:开启事务对于数据库的作用是对数据的一系列操作,要么全部成功,要么全部失败,防止出现中间状态,以保证数据处理过程中始终处于正确和谐的状态.
FMDatabase使用事务的方法:

```
-(void)insertUserInfoWithDataArr:(NSArray *)dataArr{
    if (dataArr.count<1) {
       return;
    }
    FMDatabase *fmdb = self.fmdb;
    [fmdb open];//开启数据库
    [fmdb beginTransaction];//开启事务
    BOOL isRollBack = NO;
    @try {
      for (int i = 0; i<dataArr.count; i++) {
        MsgCenterModel *model = dataArr[i];
        NSArray *sqlDataArr = @[@(model.userId),model.name,model.age];
        BOOL isSuccess = [fmdb executeUpdate:@"INSERT INTO UserInfoTable (userId,name,age) values (?,?,?)" withArgumentsInArray:sqlDataArr];
        if (!isSuccess) {
           NSLog(@"update Failure");
        }
      }
    }
    @catch (NSException *exception) {
      isRollBack = YES;
      [fmdb rollback];//事务回滚
    }
    @finally {
        if (!isRollBack) {
        [fmdb commit];//提交事务
      }
    }
    [fmdb close];//关闭数据库
}
```

FMDatabaseQueue使用事务的方法:
```
//多线程事务 
- (void)transactionByQueue { 
  //开启事务
  [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
  for (int i = 0; i<500; i++) { 
    NSNumber *num = @(i+1); 
    NSString *name = [[NSString alloc] initWithFormat:@"student_%d",i]; 
    NSString *sex = (i%2==0)?@"f":@"m";
    NSString *sql = @"insert into mytable(num,name,sex) values(?,?,?);"; 
    BOOL result = [db executeUpdate:sql,num,name,sex]; 
    if (!result) { 
      //当最后*rollback的值为YES的时候，事务回退，如果最后*rollback为NO，事务提交
      *rollback = YES;
      return; 
      } 
    }
  }]; 
}
```

**#####附相关参数说明:**
示例代码:
```
NSInteger identifier = 42;
NSString *name = @"Liam O'Flaherty (\"the famous Irish author\")";
NSDate *date = [NSDate date];
NSString *comment = nil;

BOOL success = [db executeUpdate:@"INSERT INTO authors (identifier, name, date, comment) VALUES (?, ?, ?, ?)", @(identifier), name, date, comment ?: [NSNull null]];
  if (!success) {
  NSLog(@"error = %@", [db lastErrorMessage]);//打印最近一条错误信息
}
```

- 通常来讲,可以使用标准的 SQL 语句,用 ? 表示执行语句的参数,例如: `INSERT INTO myTable VALUES (?, ?, ?, ?)`;
- 2.我们可以调用 `executeUpdate:` 方法来将 ? 所指代的具体参数传传进去,如示例语句;
- 3.尤其值得注意的是,参数必须是`NSobject`的子类,所以像 `int` ,`double`, `bool` 等基本类型的数据,需要封装成对应的包装类才行,如示例中的 `identifier` 字段,需要通过 `@(identifier)` 或者 `[NSNumber numberWithInt:identifier]` 转换成 `NSNumber` 对象
- 4.SQL 中的 NULL 值需要以 [NSNull null] 类型传进去.例如实例中的`comment`字段,为空时我们可以通过 `comment ?: [NSNull null]` 语法进行处理;`Likewise, SQL NULL values should be inserted as [NSNull null]. For example, in the case of comment which might be nil (and is in this example), you can use the comment ?: [NSNull null] syntax, which will insert the string if comment is not nil, but will insert [NSNull null] if it is nil.` 
- 5. `-execute*WithFormat:` 方法内部会将参数转换为合适的类型,以下修饰符都是可以使用的: %@, %c, %s, %d, %D, %i, %u, %U, %hi, %hu, %qi, %qu, %f, %g, %ld, %lu, %lld和 %llu. 使用不支持的占位符,将有可能引起崩溃或未定义的行为.如果需要在 SQL 语句中使用字符 `%` ,需要使用 `%%`.
##### 本文MarkDown文件及Demo地址:[FMDBDemo]()

#####参考文献:
- [FMDB官方文档](https://github.com/ccgus/fmdb)
- [FMDB Reference](http://ccgus.github.io/fmdb/html/)
- [在iOS开发中使用FMDB](http://blog.devtang.com/2012/04/22/use-fmdb/)
- [iOS学习笔记17-FMDB你好！](http://www.jianshu.com/p/82b2b06e3172#)
- [FMDB–更友好地操作SQLite数据库](http://www.ios122.com/2015/09/fmdb/)
