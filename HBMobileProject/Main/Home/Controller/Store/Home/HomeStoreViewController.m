//
//  HomeStoreViewController.m
//  scale
//
//  Created by HarbingWang on 2016/12/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "HomeStoreViewController.h"

static NSString * const HomeStoreViewCellID = @"HomeStoreViewCellID";

@interface HomeStoreViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *storeFlowLayout;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation HomeStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"商城";
    
    [self loadCollectionView];
}

#pragma mark - 布局方法
- (void)loadCollectionView {
    
    self.storeFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _storeFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _storeFlowLayout.itemSize = CGSizeMake(100, 100);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, ScreenWidth, ScreenHeight-self.navView.height-49) collectionViewLayout:_storeFlowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:HomeStoreViewCellID];
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:HomeStoreViewCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zi", indexPath.item);
}

#pragma mark - setter
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
