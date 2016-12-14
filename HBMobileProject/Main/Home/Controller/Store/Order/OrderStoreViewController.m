//
//  OrderStoreViewController.m
//  scale
//
//  Created by HarbingWang on 2016/12/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "OrderStoreViewController.h"
#import "StoreTopBarTool.h"
#import "OrderTableView.h"
#import "UIColor+Extend.h"

@interface OrderStoreViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) StoreTopBarTool *topBarTool; //头部类型条

@property (nonatomic, strong) UIScrollView *comScrollView;

@property (nonatomic, strong) NSArray *itemTitle; // 标题

@property (nonatomic, strong) NSMutableArray *comViewArr;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation OrderStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = STR(@"store.order.title");
    self.isUseBackBtn    = NO;
    
    [self initSubViews];
    [self loadNetData];
    [self initDatas];
}

- (void)initSubViews {
    
    __weak typeof(self) weakSelf = self;
    self.topBarTool = [[StoreTopBarTool alloc] initWithFrame:CGRectMake(0, self.navView.bottom, ScreenWidth, 45) items:self.itemTitle selectIndex:0 select:^(NSInteger item) {
        [weakSelf scrollToIndex:item];
    }];
    
    self.comScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topBarTool.bottom, ScreenWidth, ScreenHeight-44-self.navView.height-self.topBarTool.height)];
    _comScrollView.backgroundColor = [UIColor commonViewCellBg];
    _comScrollView.delegate = self;
    _comScrollView.scrollsToTop = NO;
    _comScrollView.pagingEnabled = YES;
    _comScrollView.alwaysBounceHorizontal = YES;
    _comScrollView.showsHorizontalScrollIndicator = NO;
    _comScrollView.contentSize = CGSizeMake(ScreenWidth * self.itemTitle.count, self.comScrollView.height);
    
    [self.view addSubview:self.topBarTool];
    [self.view addSubview:self.comScrollView];
}

- (void)loadNetData {
    
    
}

#pragma mark - initDatas
- (void)initDatas {
    
    if (!_comViewArr) {
        _comViewArr = [NSMutableArray array];
    }else{
        [_comViewArr removeAllObjects];
        for (UIView *view in _comScrollView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < self.itemTitle.count; i++) {
        
        OrderTableView *tableView = [[OrderTableView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, self.comScrollView.height)];
        
        OrderModel *model = [[OrderModel alloc] init];
        model.status = i;
        [tableView initDataWithOrderModel:model];
        tableView.orderModel = model;
        
        [_comScrollView addSubview:tableView];
        [_comViewArr addObject:tableView];
    }
}

- (void)scrollToIndex:(NSInteger)index {
    
    if (index < self.itemTitle.count) {
        [_comScrollView setContentOffset:CGPointMake(index * ScreenWidth, _comScrollView.contentOffset.y)];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSInteger index = targetContentOffset->x / ScreenWidth;
    [_topBarTool scrollToIndex:index];
    [self scrollToIndex:index];
}

#pragma mark - getter
- (NSArray *)itemTitle {
    if (!_itemTitle) {
        _itemTitle = [NSArray arrayWithObjects:STR(@"store.order.all"),STR(@"store.order.waitPay"),STR(@"store.order.waitTakeOver"),STR(@"store.order.haveTakeOver"), nil];
    }
    return _itemTitle;
}

- (NSMutableArray *)comViewArr {
    if (!_comViewArr) {
        _comViewArr = [NSMutableArray array];
    }
    return _comViewArr;
}

#pragma mark - lifeCycle
- (void)viewWillAppear:(BOOL)animated {
//    [self initDatas];
}

@end
