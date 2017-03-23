### FMDB学习笔记
> ####TopicList

- 一.FMDB 简介
- 二.FMDB 使用说明
- 三.FMDB 创建及使用方法
- 四.FMDatabaseQueue的使用
- 五.FMDB事务相关
- 六.附: 相关参数说明
- 七.附: iOS数据库操作中常见的 SQL 语句
- 八.参考及引用文献
- 九.本文MarkDown文件及Demo地址

> ##### 一.FMDB 简介

SQLite是一个轻量级的关系型数据库,在使用的时候只需要加入`libsqlite3.tbd`的依赖并引入`sqlite3.h`头文件即可. 但是,原生的`SQLite API`在使用上相当的不友好. 因此, [FMDB](https://github.com/ccgus/fmdb) 用 OC 的方式对其C语言的API进行了封装,使用起来比原生的 API 优雅了很多,同时,相较于 Apple 自带的 CoreDada 框架,也更加灵活. 此外, FMDB 还提供了多线程安全的操作数据库的方法,能够有效地防止数据读取的混乱.
FMDB 的缺点: 由于其使用的是 OC 的语法封装,因此只能在 iOS 项目中使用,在跨平台操作的时候存在一定的局限性.

> ##### 二.FMDB 使用说明

FMDB同时兼容ARC和非ARC工程，会自动根据工程配置来调整相关的内存管理代码。

FMDB 三个主要的常用类:

`FMDatabase`: 代表一个 SQLite 数据库,用于执行 SQLite 语句;

`FMResultSet`: 代表 FMDatabase 的一个 SQL 查询的结果集;

`FMDatabaseQueue`: 如果你想在多个线程上执行数据库查询和更新的操作, 这个类会很有用.下面的”线程安全”部分,会重点介绍它;

> ##### 三.FMDB 创建及使用方法

- 首先需要将 FMDB 从 [Github](https://github.com/ccgus/fmdb) 上下载下来,然后将文件拖入工程中(支持 CocoaPods);
- 在工程中添加`libsqlite3.tbd`依赖;
- #import "FMDB.h" 引入头文件;

###### 1.创建数据库
通过指定 SQLite 数据库文件的路径来创建一个 FMDatabase ,路径可以是以下几种方式中的任何一种:
- 一个完整的文件路径,如果文件不存在,会自动创建` A file system path. The file does not have to exist on disk. If it does not exist, it is created for you. `
- 一个空字符串(@""),会自动在缓存区创建一个空的数据库, FMDatabase 连接关闭时,数据库会被自动删除`An empty string (@""). An empty database is created at a temporary location. This database is deleted with the FMDatabase connection is closed.`
- 路径为 NULL ,会在内存中创建一个数据库,同样地, FMDatabase 连接关闭时,数据库会被自动删除`NULL. An in-memory database is created. This database will be destroyed with the FMDatabase connection is closed.`
```
// 使用示例
NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"UserInfo.db"];
FMDatabase *db = [FMDatabase databaseWithPath:filePath];
```
> **注意: 这里创建了数据库,并不会打开数据库,打开数据库需要接下来的操作.**

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

示例1
`[db executeUpdate:@"CREATE TABLE IF NOT EXISTS 'UserInfoTable' (Id integer NOT NULL primary key autoincrement,name text DEFAULT 0,age integer DEFAULT 0)"];`

示例2
`-executeUpdate:`使用标准的 SQL 语句,参数用?来占位,参数必须是对象类型,不能是 int,double,bool 等基本数据类型;
`[db executeUpdate:@"UPDATE UserInfoTable SET name = ? WHERE Id = ?", userInfo.name, @(userInfo.id).description];`

示例3
`-executeUpdateWithFormat:`使用字符串的格式化构建 SQL 语句,参数用`%@`、`%d`等来占位.
`[db executeUpdateWithFormat:@"INSERT INTO UserInfoTable (name, age) values (%@,%d);", userInfo.name, userInfo.age];`

示例4
`-executeUpdate:withArgumentsInArray:`也可以把对应的参数装到数组里面传进去,SQL语句中的参数用` ? `代替.
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
使用示例
```
FMResultSet *set = [db executeQuery:@"SELECT * FROM UserInfoDTable"];
```

**注意以下几点:** 

①为了遍历查询结果,需要使用 while() 语句遍历;
```
while ([set next]) {
  // 从每条记录中获取值
}
```
②即使操作结果只有一行,也需要先调用 FMResultSet 的 next 方法.
```
FMResultSet *res = [db executeQuery:@"SELECT name(*) FROM UserInfoDTable"];
  while ([set next]) {
  NSString *name = [set stringForColumn:@"name"];
}
```
③通常情况下,不需要关闭 FMResultSet, 因为相关的数据库关闭时,FMResultSet 也会被自动关闭。 `Typically, there's no need to -close an FMResultSet yourself, since that happens when either the result set is deallocated, or the parent database is closed.`
④FMResultSet 提供了很多获取不同类型数据的方法:
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
⑤更多关于FMResultSet的使用方法参考 [FMResultSet Class Reference](http://ccgus.github.io/fmdb/html/Classes/FMResultSet.html#//api/name/kvcMagic:)

###### 5.关闭数据库
当完成了数据库的查询以及更新操作,**必须调用`close`语句关闭 FMDatabase 连接**,释放SQLite 使用的资源.
```
[db close];
```

> ##### 四.FMDatabaseQueue的使用

FMDatabase 这个类是线程不安全的,如果在多个线程间共用一个 FMDatabase 对象,将会引起数据混乱等现象.`So don't instantiate a single FMDatabase object and use it across multiple threads.`

FMDB 提供了 `FMDatabaseQueue`类来保证线程安全. FMDatabaseQueue 使用起来非常便捷,首先使用一个数据库文件地址来初始化 FMDatabaseQueue ,然后就可以将一个闭包(block)传入`inDatabase`方法中.在闭包中操作数据库,而不是直接参与 FMDatabase 的管理;
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

> ##### 五.事务

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


> #### 六.附相关参数说明:

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

1.通常来讲,可以使用标准的 SQL 语句,用 ? 表示执行语句的参数,例如: `INSERT INTO myTable VALUES (?, ?, ?, ?)`;

2.我们可以调用 `executeUpdate:` 方法来将 ? 所指代的具体参数传进去,如示例语句;

3.尤其值得注意的是,参数必须是`NSobject`的子类,所以像 `int` ,`double`, `bool` 等基本类型的数据,需要封装成对应的包装类才行,如示例中的 `identifier` 字段,需要通过 `@(identifier)` 或者 `[NSNumber numberWithInt:identifier]` 转换成 `NSNumber` 对象;

4.SQL 中的 NULL 值需要以 [NSNull null] 类型传进去.例如实例中的`comment`字段,为空时我们可以通过 `comment ?: [NSNull null]` 语法进行处理;`Likewise, SQL NULL values should be inserted as [NSNull null]. For example, in the case of comment which might be nil (and is in this example), you can use the comment ?: [NSNull null] syntax, which will insert the string if comment is not nil, but will insert [NSNull null] if it is nil.`;

5.`-execute*WithFormat:` 方法内部会将参数转换为合适的类型,以下修饰符都是可以使用的: %@, %c, %s, %d, %D, %i, %u, %U, %hi, %hu, %qi, %qu, %f, %g, %ld, %lu, %lld和 %llu. 使用不支持的占位符,将有可能引起崩溃或未定义的行为.如果需要在 SQL 语句中使用字符 `%` ,需要使用 `%%`;

> ##### 七. 附 iOS数据库操作中常见的 SQL 语句

**`SQL(structured query language)`**语言简洁，语法简单，好学好用,它是一种结构化查询语言,**值得注意的是**,**SQLite不区分大小写**,但也有一些命令是大小写敏感的,比如 `GLOB` 和 `glob` 在 SQLite 的语句中有不同的含义.但这两个语句在 iOS 开发中一般用不到;

要想在数据库中进行增删改查等相关操作,必须使用 SQL 语句,首先需要了解下 SQLite 存储数据的类型.

**SQLite 存储数据的类型:**

| 数据类型 | 描述 |
|:---|:---|
|NULL (null) | 值是一个 NULL 值|
|INTEGER (integer)| 值是一个带符号的整数,根据值的大小存储在1、2、3、4、6 或 8 字节中 |
|REAL (real)| 值是一个浮点值,存储为 8 字节的 IEEE 浮点数字 |
|TEXT (text)| 值是一个文本字符串,使用数据库编码UTF-8、UTF-16BE 或 UTF-16LE）存储 |
|BLOB (blob)| 值是一个 blob 数据，完全根据它的输入存储 |
|Boolean| SQLite 没有单独的 Boolean 存储类。相反，布尔值被存储为整数 0(false)和 1(true)|


可以把 SQL 分为两个部分：数据操作语言 (DML) 和 数据定义语言 (DDL).
查询和更新指令构成了 SQL 的 DML 部分：
- **SELECT**: 从数据库表中获取数据
- **UPDATE**: 更新数据库表中的数据
- **DELETE**: 从数据库表中删除数据
- **INSERT INTO**: 向数据库表中插入数据

SQL 的数据定义语言 (DDL) 部分使我们有能力创建或删除表格。我们也可以定义索引（键），规定表之间的链接，以及施加表间的约束.

- **CREATE DATABASE**: 创建新数据库
- **CREATE TABLE**: 创建新表
- **ALTER DATABASE**: 修改数据库
- **ALTER TABLE**: 变更（改变）数据库表
- **DROP TABLE**: 删除表
- **CREATE INDEX**: 创建索引（搜索键）
- **DROP INDEX**: 删除索引

**iOS中常用的 SQLite 语句:**

###### 1.创建表格 (CREATE TABLE 语句用于创建数据库中的表)
```
// 语法: CREATE TABLE 表名称 (列名称1 数据类型,列名称2 数据类型,列名称3 数据类型,....)
CREATE TABLE IF NOT EXISTS UserInfoDB (Id integer NOT NULL primary key autoincrement,myUserId integer DEFAULT 0,userId integer DEFAULT 0,realName text DEFAULT 0,age integer DEFAULT 0,avatarUrl text DEFAULT 0,content text DEFAULT 0,createTime integer DEFAULT 0,smallImgUrl text DEFAULT 0,messageType integer DEFAULT 0,readType integer DEFAULT 0,t1 text default 0,t2 text default 0,t3 text default 0,t4 text default 0)//t1,t2,t3,t4为预留字段;

```

###### 2.删除表格 (DROP TABLE 语句用于删除表)
```
// 表的结构、属性以及索引也会被删除

// 语法: DROP TABLE 表名称
DROP TABLE UserInfoDB;

```

###### 3.增 (INSERT INTO 语句用于向表格中插入新的行)
```
// 语法1:  INSERT INTO 表名称 VALUES (值1, 值2,....) 
INSERT INTO UserInfoDB VALUES (?,?,?,?,?,?,?,?,?,?)

// 语法2: INSERT INTO 表名称 (列1, 列2,...) VALUES (值1, 值2,....)
INSERT OR REPLACE INTO UserInfoDB (myUserId,userId,realName,age,avatarUrl,content,createTime,smallImgUrl,messageType,readType) VALUES (?,?,?,?,?,?,?,?,?,?)

/*
注意：
 1.字段和值一定要对应，否则也会添加错误的数据进表里
 2.INSERT INTO 可以写成 INSERT OR REPLACE INTO
 3.更加推荐第二种语法
 */
```

###### 4.删 (DELETE 语句用于删除表中的行)
```
// 语法: DELETE FROM 表名称 WHERE 行名称

// 删除某行
DELETE FROM UserInfoDB WHERE Id = 1;
// 删除所有行
DELETE FROM UserInfoDB  或者 DELETE * FROM UserInfoDB

```

###### 5.改 (UPDATE 语句用于修改表中的数据)

```
// 语法: UPDATE 表名称 SET 列名称 = 新值 WHERE 行名称 = 某值
// 注意：如果不指定条件会更新所有数据

// 更新某一行中的某一列数据
UPDATE UserInfoDB SET realName = 'HarbingWang' WHERE Id = 1
// 更新某一行中的若干列
UPDATE UserInfoDB SET realName = 'HarbingWang', age = 24, readType = 1 WHERE Id = 1

```

###### 6.查 (SELECT 语句用于从表中查询并选取数据)
**提示：星号（*）是选取所有列的快捷方式**
```
// 查询结果被存储在一个结果表中,即 FMDataBaseSet结果集.
// SQL 使用单引号来环绕文本值, 如果是数值,请不要使用引号.

// 语法: SELECT 列名称 FROM 表名称 
// 语法: SELECT * FROM 表名称
// 查询指定字段
SELECT name, age FROM UserInfoDB
 
// 查询所有字段
SELECT * FROM UserInfoDB

// 查询记录总数
SELECT COUNT(*) FROM UserInfoDB

// 查询最大的 age
SELECT MAX(age) FROM UserInfoDB
 
// 查询最小的 age
SELECT MIN(age) FROM UserInfoDB

// 如需有条件地从表中选取数据，可将 WHERE 子句添加到 SELECT 语句
// 查询 age < 22 的记录的 name, age 字段
SELECT name, age, FROM UserInfoDB WHERE age < 22
 
// 查询 age < 22 的所有字段
SELECT * FROM UserInfoDB WHERE age < 22
 
// 查询 age < 22 的记录总数
SELECT COUNT(*) FROM UserInfoDB WHERE realName = 'HarbingWang'


// 如需将表中选取的数据按一定的顺序排列，可将 ORDER BY 语句添加到 SELECT 语句
// 查询所有记录的所有字段，根据 age 升序排序 (ORDER BY 语句默认按照升序对记录进行排序)
SELECT * FROM UserInfoDB ORDER BY age
 
// 查询所有记录的所有字段， 根据 age 降序排序 (按照降序对记录进行排序，可以使用 DESC 关键字)
SELECT * FROM UserInfoDB ORDER BY age DESC
 
// 使用多个字段排序，先按 age 降序排序，当 age 相同 时再根据 userId 升序排序
SELECT * FROM UserInfoDB ORDER BY age DESC,userId ASC

// 如需返回指定范围的记录,可以使用 LIMIT, LIMIT 常用于分页
SELECT * FROM UserInfoDB LIMIT 5, 10 // 5 表示跳过的5条, 10 表示获取10条
 
// 取出年龄最大的3条记
SELECT * FROM UserInfoDB ORDER BY age DESC LIMIT 3

// 关键词 DISTINCT 用于返回唯一不同的值
// SELECT DISTINCT 列名称 FROM 表名称
// 在表中，可能会包含重复值。这并不成问题，不过，有时您也许希望仅仅列出不同（distinct）的值。
SELECT DISTINCT Company FROM Orders

```

**下面的运算符可在 WHERE 子句中使用**

| 操作符 | 描述 |
|:---:|:---:|
|= | 等于 |
|<>| 不等于 |
|> | 大于 |
|< | 小于 |
|>= | 大于等于 |
|<= | 小于等于 |
|BETWEEN | 在某个范围内 |
|LIKE | 搜索某种模式 |

> ##### 八.参考及引用文献

- [FMDB官方文档](https://github.com/ccgus/fmdb)
- [W3School.com](http://www.w3school.com.cn/sql/sql_intro.asp)
- [FMDB Reference](http://ccgus.github.io/fmdb/html/)
- [在iOS开发中使用FMDB](http://blog.devtang.com/2012/04/22/use-fmdb/)
- [iOS学习笔记17-FMDB你好！](http://www.jianshu.com/p/82b2b06e3172#)
- [iOS数据库操作中的常见SQL语句](https://blog.6ag.cn/1227.html)
- [FMDB–更友好地操作SQLite数据库](http://www.ios122.com/2015/09/fmdb/)

> ##### 九.本文MarkDown文件及Demo地址:[FMDBDemo](https://github.com/HarbingWang/Project/tree/master/HBMobileProject/Main/Home/Controller/Modules/FMDB)
