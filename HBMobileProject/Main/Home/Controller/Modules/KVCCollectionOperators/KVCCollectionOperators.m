//
//  KVCCollectionOperators.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/20.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "KVCCollectionOperators.h"
#import "ProductModel.h"

@implementation KVCCollectionOperators

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isUseRightBtn = YES;
    self.isUseBackBtn = YES;
    
    // KVC集合操作符的类型
    // 1.Simple Collection Operators 简单的集合操作符
    // 2.Object Operators 对象操作符
    // 3.Array and Set Operators 数组/集合操作符
    
    ProductModel *productA = [[ProductModel alloc] init];
    productA.price = 99.0;
    productA.name = @"iPod";
    
    ProductModel *productB = [[ProductModel alloc] init];
    productB.price = 199.0;
    productB.name = @"iMac";
    
    ProductModel *productC = [[ProductModel alloc] init];
    productC.price = 299.0;
    productC.name = @"iPhone";
    
    ProductModel *productD = [[ProductModel alloc] init];
    productD.price = 199.0;
    productD.name = @"iPhone";
    
    // 1.Simple Collection Operators
    // - `@count` 返回一个值为集合中对象总数的NSNumber对象;
    // - `@avg` 首先把集合中的每个对象都转换为double类型,然后计算其平均值,并返回这个平均值的NSNumber对象;
    // - `@max` 使用compare:方法来确定最大值,并返回最大值的NSNumber对象.所以为了保证其正常比较,集合中所有的对象都必须支持和另一个对象的比较,保证其可比性;
    // - `@min` 原理和@max一样,其返回的是集合中的最小值的NSNumber对象;
    // - `@sum` 首先把集合中的每个对象都转换为double类型,然后计算其总和,并返回总和的NSNumber对象;
    // **Notice:** 所有的集合操作,除了`@count`外,其他都需要有右边的keyPath(一般为属性名),`@count`右边的`keyPath`可写可不写.
    
    NSArray *product = @[productA, productB, productC, productD];
//    NSNumber *count = [product valueForKeyPath:@"@count.price"];
//    NSNumber *avg = [product valueForKeyPath:@"@avg.price"];
//    NSNumber *max = [product valueForKeyPath:@"@max.price"];
//    NSNumber *min = [product valueForKeyPath:@"@min.price"];
//    NSNumber *sum = [product valueForKeyPath:@"@sum.price"];
//    
//    NSLog(@"count:%@, avg:%@, max:%@, min:%@, sum:%@", count, avg, max, min, sum);
    
    // Noti:若操作对象(数组/集合)内的元素本身就是 NSNumber 对象,那么可以这样写.
//    NSArray *array = @[@(productA.price), @(productB.price), @(productC.price), @(productD.price)];
//    NSNumber *count = [array valueForKeyPath:@"@count"];
//    NSNumber *avg = [array valueForKeyPath:@"@avg.self"];
//    NSNumber *max = [array valueForKeyPath:@"@max.self"];
//    NSNumber *min = [array valueForKeyPath:@"@min.self"];
//    NSNumber *sum = [array valueForKeyPath:@"@sum.self"];
//    NSLog(@"count:%@, avg:%@, max:%@, min:%@, sum:%@", count, avg, max, min, sum);
    
    // 2.Object Operator (对象操作符)
    // - `@unionOfObjects:` `获取数组中每个对象的属性的值,放到一个数组中并返回,但不会去重;`The @unionOfObjects operator provides similar behavior, but without removing duplicate objects.`
    // - `@distinctUnionOfObjects:`获取数组中每个对象的属性的值,放到一个数组中并返回,会对数组去重.所以,通常这个对象操作符可以用来对数组元素的去重,快捷高效;`The @distinctUnionOfArrays operator is similar, but removes duplicate objects.`
    
    NSArray *unionOfObjects = [product valueForKeyPath:@"@unionOfObjects.name"];
    NSArray *distinctUnionOfObjects = [product valueForKeyPath:@"@distinctUnionOfObjects.name"];
    NSLog(@"unionOfObjects : %@", unionOfObjects);
    NSLog(@"distinctUnionOfObjects : %@", distinctUnionOfObjects);
    
    // 3.Array and Set Operators
    // - `@distinctUnionOfArrays` 返回操作对象(数组)中的所有元素,即返回这个数组本身.会去重.
    // - `@unionOfArrays` 首先获取操作对象(数组)中的所有元素,然后装到一个新的数组中并返回,不会对这个数组去重.
    
    NSArray *distinctUnionOfArrays = [@[product, product] valueForKeyPath:@"@distinctUnionOfArrays.price"];
    NSArray *unionOfArrays = [@[product, product] valueForKeyPath:@"@unionOfArrays.price"];
    NSLog(@"distinctUnionOfArrays : %@", distinctUnionOfArrays);
    NSLog(@"unionOfArrays : %@", unionOfArrays);
    
    // - `@distinctUnionOfSets`返回操作对象（且操作对象内对象必须是数组/集合）中数组/集合的所有对象，返回值为集合.因为集合不能包含重复的值，所以它只有distinct操作
    NSSet *setA = [NSSet setWithObjects:productA, productB, nil];
    NSSet *setB = [NSSet setWithObjects:productC, productD, nil];
    NSSet *set = [NSSet setWithObjects:setA, setB, nil];
    
    NSSet *allSet = [set valueForKeyPath:@"@distinctUnionOfSets.name"];
    NSLog(@"distinctUnionOfSets: %@", allSet);
    
    // ##### 补充: `-(void)valueForKeyPath:`的用法;
    // 1.可以指定数组中每个元素的执行方法,然后将新元素放到新数组中返回,for example:
    NSArray *arr = @[@"iPod", @"iPhone", @"iMac", @"iPhone8 Plus"];
    NSArray *uppercaseStrArr = [arr valueForKeyPath:@"uppercaseString"];
    NSLog(@"%@", uppercaseStrArr);// 输出: IPOD,IPHONE,IMAC,"IPHONE8 PLUS"
    
    // 从输出我们不难看出,`[arr valueForKeyPath:@"uppercaseString"]`相当于数组中每个元素都执行了`uppercaseString`方法,并将返回的对象放到了一个数组中返回.当然了,除了可以执行`uppercaseString`外,也可以执行集合中对象的其他实例方法:`length`,`md5String` and so on...
    NSArray *lengthArr = [arr valueForKeyPath:@"length"];
    NSLog(@"%@", lengthArr);// 输出: 4,6,4,12
    
    // 2.如上所述,对数组快速求和,求平均值,求最大值,最小值.
    NSArray *priceArr = @[@99, @199, @299, @99];
//    NSNumber *count = [priceArr valueForKeyPath:@"@count"];
//    NSNumber *avg = [priceArr valueForKeyPath:@"@avg.self"];
//    NSNumber *max = [priceArr valueForKeyPath:@"@max.self"];
//    NSNumber *min = [priceArr valueForKeyPath:@"@min.self"];
//    NSNumber *sum = [priceArr valueForKeyPath:@"@sum.self"];
//    NSLog(@"count:%@, avg:%@, max:%@, min:%@, sum:%@", count, avg, max, min, sum);
    
    // 当然,也能指定输出类型, for example:
    NSNumber *count = [priceArr valueForKeyPath:@"@count"];
    NSNumber *avg = [priceArr valueForKeyPath:@"@avg.floatValue"];
    NSNumber *max = [priceArr valueForKeyPath:@"@max.floatValue"];
    NSNumber *min = [priceArr valueForKeyPath:@"@min.floatValue"];
    NSNumber *sum = [priceArr valueForKeyPath:@"@sum.floatValue"];
    NSLog(@"count:%@, avg:%@, max:%@, min:%@, sum:%@", count, avg, max, min, sum);
    
    // 3.剔除数组中的重复元素
    NSLog(@"%@", [priceArr valueForKeyPath:@"@distinctUnionOfObjects.self"]);
    
    // 4.根据 keypath 路径快速找到 key 对应的值, for example:
     NSArray *array = @[@{@"name" : @"iPod", @"price" : @99},
                       @{@"name" : @"iPhone", @"price" : @199},
                       @{@"name" : @"iPhone", @"price" : @299},
                       @{@"name" : @"iPhone", @"price" : @299},
                       ];
     NSLog(@"%@", [array valueForKeyPath:@"name"]);// 注意:name 前面没有@符号,这不是集合运算符
    
     // 这样,我们就能很快得到字典key值`name`对应的value值所组成的数组,这种方式显然比 for 循环来的直接,高效.
     // 当然,也能使用 KVC Collection Operators 来剔除重复的数值:
     NSLog(@"%@", [array valueForKeyPath:@"@distinctUnionOfObjects.price"]);
    
    
    // runtime 获取类的方法
//    unsigned int methodsCount = 0;
//    Method *methods = class_copyMethodList([NSString class], &methodsCount);
//    for (int i = 0; i < methodsCount; i++) {
//        Method method = methods[i];
//        SEL methodSel = method_getName(method);
//        NSLog(@"%@", NSStringFromSelector(methodSel));
//    }
}



@end
