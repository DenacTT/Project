//
//  HomeStoreViewController.m
//  scale
//
//  Created by HarbingWang on 2016/12/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "HomeStoreViewController.h"
#import "UIColor+Extend.h"
#import "HomeStoreViewCell.h"
#import "HomeStoreHeadView.h"
#import "StoreDetailViewController.h"

static NSString * const HomeStoreViewCellID = @"HomeStoreViewCellID";
static NSString * const HomeStoreHeadViewID = @"HomeStoreHeadViewID";

@interface HomeStoreViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *storeFlowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation HomeStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.backgroundColor = RGBA(255, 255, 255, 0.1);
    self.titleLabel.text = STR(@"store.homeStore.title");
    self.titleLabel.textColor = [UIColor whiteColor];
    self.isUseBackBtn    = YES;
    
    [self.view addSubview:self.collectionView];
}

- (void)clickBackBtn {
    
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HomeStoreHeadView *headReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HomeStoreHeadViewID forIndexPath:indexPath];
    [headReusableView initData];
    return headReusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeStoreViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:HomeStoreViewCellID forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    StoreDetailViewController *detailViewController = [[StoreDetailViewController alloc] init];
    detailViewController.title = @"产品详情";
    detailViewController.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        self.storeFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        _storeFlowLayout.sectionInset = UIEdgeInsetsMake(9, 0, 0, 0);
        _storeFlowLayout.minimumLineSpacing = 9;
        _storeFlowLayout.minimumInteritemSpacing = 9;
        
        _storeFlowLayout.itemSize = CGSizeMake((ScreenWidth-9)/2, 250);
        _storeFlowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, 256-64);
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) collectionViewLayout:_storeFlowLayout];
        _collectionView.backgroundColor = [UIColor commonViewCellBg];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate    = self;
        _collectionView.dataSource  = self;
        
        [_collectionView registerClass:[HomeStoreViewCell class] forCellWithReuseIdentifier:HomeStoreViewCellID];
        [_collectionView registerClass:[HomeStoreHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HomeStoreHeadViewID];
    }
    return _collectionView;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
