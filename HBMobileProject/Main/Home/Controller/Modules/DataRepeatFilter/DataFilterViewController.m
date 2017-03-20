//
//  DataFilterViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/18.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//  https://github.com/HarbingWang/Project/tree/master/HBMobileProject/Main/Home/Model/DataRepeatFilter

#import "DataFilterViewController.h"
#import "ProductModel.h"
#import "NSObject+MJKeyValue.h"

static NSString * const DataFilterViewCell = @"DataFilterViewCell";

@interface DataFilterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *originArr;

@end

@implementation DataFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"数据排重";
    self.isUseBackBtn = YES;
    self.isUseRightBtn = YES;
    [self setupSubView];
    
    [self loadData];
    //[self loaDataModel];
    
//    // runtime 获取某个类的方法名
//    unsigned int count = 0;
//    Method *methods = class_copyMethodList([NSArray class], &count);
//    for (int i = 0; i < count; i++) {
//        Method method = methods[i];
//        SEL methodSel = method_getName(method);
//        NSLog(@"%@", NSStringFromSelector(methodSel));
//    }
}

// 单一结构的排重对象
- (void)loadData {

    // self.originArr = @[@1, @2, @3, @1, @2, @3, @4];
    self.originArr = @[@"iPhone5", @"iPhone5", @"iPhoneSE", @"iPhone6", @"iPhone6", @"iPhone6s", @"iPhone6s",  @"iPhone8", @"iPadMini", @"macBookPro", @"macBookPro", @"iMac"];
}

// 复杂结构的排重对象
- (void)loaDataModel {
    
    NSArray *array = @[@{@"name": @"iPhone5",
                         @"id": @(001)
                         },
                       @{@"name": @"iPhone5s",
                         @"id": @(001)
                         },
                       @{@"name": @"iPhoneSE",
                         @"id": @(002)
                         },
                       @{@"name": @"iPhone6",
                         @"id": @(003)
                         },
                       @{@"name": @"iPhone6",
                         @"id": @(003)
                         },
                       @{@"name": @"iPhone6s",
                         @"id": @(004)
                         },
                       @{@"name": @"iPhone7",
                         @"id": @(005)
                         },
                       @{@"name": @"iPadMini",
                         @"id": @(006)
                         },
                       @{@"name": @"iPhone8",
                         @"id": @(007)
                         },
                       ];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        ProductModel *model = [ProductModel mj_objectWithKeyValues:dic];
        [arr addObject:model];
    }
    self.originArr = [NSArray arrayWithArray:arr];
}

- (void)setupSubView
{
    self.rightBtn.frame = CGRectMake(ScreenWidth-55, self.titleLabel.center.y-24/2, 45, 24);
    self.rightBtn.layer.cornerRadius = 2.f;
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.backgroundColor = [UIColor orangeColor];
    [self.rightBtn setTitle:@"排重" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, ScreenWidth, ScreenHeight-self.navView.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DataFilterViewCell];
    [self.view addSubview:_tableView];
}

- (void)clickRightBtn {
    
    // 单一结构的排重对象
    // 1.利用 NSArray 的 containsObject 方法
    [self filterMethodOne];
    
    // 2.利用 NSDictionary 的 allValues 方法
    // [self filterMethodTwo];
    
    // 3.利用 NSSet 的 allObjects 方法
    // [self filterMethodThree];
    
    // 4.利用 valueForKeyPath 方法
    // [self filterMethodFour];
    
    // 5.正常排重,不打乱数组元素的顺序
    // [self filterMethodFive];
    
    // 复杂结构的排重对象可以通过特征值(id/createTime 等)排重
    // [self filterMethodSix];
}

#pragma mark - 排重方法
// 1.利用 NSArray 的 containsObject 方法
- (void)filterMethodOne {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSNumber *object in self.originArr) {
        if (![arr containsObject:object]) {
            [arr addObject:object];
        }
    }
    self.originArr = [NSArray arrayWithArray:arr];
    [self.tableView reloadDataWithAnimate:YES];
}

// 2.利用 NSDictionary 的 allValues 方法
- (void)filterMethodTwo {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSNumber *object in self.originArr) {
        [dic setObject:object forKey:object];
    }
    NSArray *arr = [dic allValues];
    self.originArr = [NSArray arrayWithArray:arr];
    [self.tableView reloadDataWithAnimate:YES];
}

// 3.利用 NSSet 的 allObjects 方法
- (void)filterMethodThree {
    
    NSSet *set = [NSSet setWithArray:self.originArr];
    NSArray *arr = [set allObjects];
    self.originArr = [NSArray arrayWithArray:arr];
    [self.tableView reloadDataWithAnimate:YES];
}

// 4.利用 KVC Collection Operators(集合操作) 的 valueForKeyPath 方法
- (void)filterMethodFour {
    
    NSArray *arr = [self.originArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    
    // 排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];//由于排序对象就是 NSNumber/NSString 类型,因此key值设置为nil 就行,排序规则,YES为升序,NO为降序
    NSMutableArray *array = [NSMutableArray arrayWithArray:arr];
    [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    self.originArr = [NSArray arrayWithArray:array];
    [self.tableView reloadDataWithAnimate:YES];
}

// 5.正常排重,不打乱数组元素的顺序
- (void)filterMethodFive {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.originArr.count; i++){
        if ([arr containsObject:[self.originArr objectAtIndex:i]] == NO){
            [arr addObject:[self.originArr objectAtIndex:i]];
        }
    }
    self.originArr = [NSArray arrayWithArray:arr];
    [self.tableView reloadDataWithAnimate:YES];
}


// 复杂结构时可以通过特征值(id/createTime等)排重
- (void)filterMethodSix {
    
    NSMutableDictionary *flagDic = [NSMutableDictionary dictionary];
    for (ProductModel *model in self.originArr) {
        [flagDic setObject:model forKey:[NSString stringWithFormat:@"%@", model.id]];// 排重
    }
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[flagDic allValues]];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES];
//    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [arr sortUsingDescriptors:[NSArray arrayWithObjects:sort1, nil]];
    
    self.originArr = [NSArray arrayWithArray:arr];
    [self.tableView reloadDataWithAnimate:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.originArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DataFilterViewCell];
    
    // 单一
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.originArr[indexPath.row]];
    
    // 复杂
    /*
    ProductModel *model = self.originArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", model.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", model.id];
    */
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - getter
- (NSArray *)originArr {
    if (!_originArr) {
        _originArr = [NSArray array];
    }
    return _originArr;
}

@end
