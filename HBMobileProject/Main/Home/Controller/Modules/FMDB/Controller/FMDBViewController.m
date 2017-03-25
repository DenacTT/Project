//
//  FMDBViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/21.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "FMDBViewController.h"
#import "ComModel.h"
#import "YMCommentDB.h"
#import "YMActionSheet.h"

static NSString * const CommentsViewCell = @"CommentsViewCell";

@interface FMDBViewController ()<UITableViewDelegate, UITableViewDataSource, YMActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUseBackBtn  = YES;
    self.isUseRightBtn = YES;
    self.currentPage = 0;
    
    // 添加子视图
    [self setupSubView];
    
    [_tableView.mj_header beginRefreshing];
}

// 模拟网络数据请求
- (void)loadNetData {
    
    [self.dataArr removeAllObjects];
    
    __block typeof(self) weakSelf = self;
    [YMDataAdapter requestCommentsDataSuccess:^(id object) {
        
        NSArray *arr = object;
        for (NSDictionary *dic in arr) {
            ComModel *model = [ComModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArr addObject:model];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
        
        // 请求成功. 缓存至数据库.
        // ...
        
    } fail:^(id object) {
        
        // 请求失败. 就从数据库中获取缓存数据
        [weakSelf.tableView.mj_header endRefreshing];
        [YMUITipsView showTips:@"数据请求失败~"];
    }];
}

- (void)loadMoreData {
    NSLog(@"上拉加载");
    /*
    _currentPage ++;
    NSRange range = NSMakeRange(_currentPage * 10, 10);
    if ([[[YMCommentDB shareInstance] getCommentsListWithRange:range] count]) {
        [_dataArr addObjectsFromArray:[[YMCommentDB shareInstance] getCommentsListWithRange:range]];
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
        NSLog(@"数据库加载%lu条更多数据",[[[YMCommentDB shareInstance] getCommentsListWithRange:range] count]);
    }else{
        //数据库没更多数据时再网络请求
        [self getTableViewDataWithPage:_currentPage];
    }
     */
}

- (void)setupSubView
{
    self.rightBtn.frame = CGRectMake(ScreenWidth-80, self.titleLabel.center.y-24/2, 80, 24);
    self.rightBtn.layer.cornerRadius = 2.f;
    self.rightBtn.layer.masksToBounds = YES;
    [self.rightBtn setTitle:@"数据操作" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, ScreenWidth, ScreenHeight-self.navView.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CommentsViewCell];
    [self.view addSubview:_tableView];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNetData)];
}

- (void)clickRightBtn {
    
    [[YMActionSheet actionSheetViewWithTitle:@"数据操作" cancelTitle:@"取消" destructiveTitle:nil otherTitles:@[@"创建数据库", @"插入单条数据", @"批量插入数据", @"查询所有数据", @"UserId查询数据", @"删除全部数据", @"多线程操作"] otherImages:nil delegate:self] show];
}

#pragma mark - YMActionSheetDelegate
- (void)actionSheet:(YMActionSheet *)sheet didSelectSheet:(NSInteger)index {
    switch (index) {
        case 0:
            [[YMCommentDB shareInstance] creatCommentTable];
            break;
        case 1:
            [self insertCommentData];
            break;
        case 2:
            [self bashInsertCommdentsData];
            break;
        case 3:
            [self quaryAllCommentsData];
            break;
        case 4:
            [self getCommentsByUserId];
            break;
        case 5:
            [self deleteCommentTable];
            break;
        case 6:
            [self multiThread];
            break;
        default:
            break;
    }
}

- (void)insertCommentData {
    
    static int index = 1;
    
    // 模拟数据
    NSDictionary *dic = @{@"avatarUrl" : @"http://images.sq.iyunmai.com/daka/20170225/1487989817829-5-60.0-20.8-0.0-3-1-1.jpg",
                          @"content" : [NSString stringWithFormat:@"[第%d条]测试数据,%d", index++, RandomNumber],
                          @"createTime" : @1490164100000,
                          @"messageType" : @22,
                          @"myUserId" : @999999999,
                          @"readType" : @1,
                          @"realName" : @"HarbingWang",
                          @"smallImgUrl" : @"http://images.sq.iyunmai.com/daka/20170225/1487989817829-5-60.0-20.8-0.0-3-1-1.jpg",
                          @"userId" : @111111111
                          };
    ComModel *model = [ComModel initWithDic:dic];
    [[YMCommentDB shareInstance] insertCommentWithModel:model];
    
    NSArray *arr = [[YMCommentDB shareInstance] quaryAllCommentsData];
    self.dataArr = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
}

- (void)bashInsertCommdentsData {
    
    [[YMCommentDB shareInstance] batchInsertCommentsWithDataArr:self.dataArr];
    
    [self.dataArr removeAllObjects];
    NSArray *arr = [[YMCommentDB shareInstance] quaryAllCommentsData];
    self.dataArr = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
}

- (void)quaryAllCommentsData {
    
    [self.dataArr removeAllObjects];
    NSArray *arr = [[YMCommentDB shareInstance] quaryAllCommentsData];
    self.dataArr = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
}

- (void)getCommentsByUserId {
    [self.dataArr removeAllObjects];
    NSArray *arr = [[YMCommentDB shareInstance] getCommentsWithUserId:[@102211872 integerValue]];
    self.dataArr = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
}

- (void)deleteCommentTable {
    [[YMCommentDB shareInstance] deleteCommentsData];
    NSArray *arr = [[YMCommentDB shareInstance] quaryAllCommentsData];
    self.dataArr = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
}

- (void)multiThread {
    
    [self.dataArr removeAllObjects];
    [[YMCommentDB shareInstance] multithread:[@100 integerValue]];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CommentsViewCell];
    ComModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", model.realName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", model.content];
    [cell.imageView sd_setImageWithURL:UrlStr(model.avatarUrl) placeholderImage:Image(@"edit_boy_normal")];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - getter
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
