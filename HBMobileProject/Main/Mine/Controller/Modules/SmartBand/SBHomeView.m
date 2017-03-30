//
//  SBHomeView.m
//  scale
//
//  Created by HarbingWang on 17/3/28.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBHomeView.h"

#import "SBHomeHeadView.h"
#import "SBHomeViewCell.h"
#import "SBHomeModel.h"

static NSString * const SBHomeViewCellID = @"SBHomeViewCellID";
static NSString * const SBHomeHeadViewID = @"SBHomeHeadViewID";

@interface SBHomeView () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *sbCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) UIView *navView;//顶部导航栏
@property (nonatomic, strong) UIView *topLine;//导航栏底部
@property (nonatomic, strong) UIView *horLine;//水平分割线
@property (nonatomic, strong) UIView *verLine;//垂直分割线
@property (nonatomic, strong) UIView *bgView; //背景占位图

@end

@implementation SBHomeView

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [self.view addSubview:self.bgView];
    
    [self.bgView addSubview:self.navView];
    [self.bgView addSubview:self.topLine];
    [self.bgView addSubview:self.sbCollectionView];
    
    [self.sbCollectionView addSubview:self.horLine];
    [self.sbCollectionView addSubview:self.verLine];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SBHomeHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SBHomeHeadViewID forIndexPath:indexPath];
    SBHomeModel *model = [[SBHomeModel alloc] init];
    model.calsNum = 6789;
    model.stepNum = 12078;
    model.mileNum = 10.99;
    model.timeNum = 629;
    [headView setValue:model];
    return headView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SBHomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SBHomeViewCellID forIndexPath:indexPath];
    SBHomeModel *model = [[SBHomeModel alloc] init];
    model.cellType = indexPath.row;
    [model initData];
    [cell setValue:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // RootNavigationPushController(vc)
}

#pragma mark - ScrollViewDidScroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <=0) {
        self.topLine.hidden = YES;
        self.sbCollectionView.backgroundColor = RGBA(50, 147, 230, 1.f);
        if (offsetY <= -100) {
            scrollView.contentOffset = CGPointMake(0, -100); //往下,限制偏移量 100
        }
    }else if (offsetY >0){
        self.topLine.hidden = NO;
        self.sbCollectionView.backgroundColor = RGB(244, 244, 244);
        if (offsetY >= 260){
            scrollView.contentOffset = CGPointMake(0, 260); //往上,限制偏移量 280
        }
    }
}

#pragma mark - Getter
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 0.f;
        _layout.minimumLineSpacing = 0.f;
        
        _layout.headerReferenceSize = CGSizeMake(ScreenWidth, 312);
        _layout.itemSize = CGSizeMake(ScreenWidth/2, ScreenWidth/2);
    }
    return _layout;
}

- (UICollectionView *)sbCollectionView {
    if (!_sbCollectionView) {
        _sbCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-44) collectionViewLayout:self.layout];
        _sbCollectionView.backgroundColor = [UIColor clearColor];
        
        _sbCollectionView.delegate   = self;
        _sbCollectionView.dataSource = self;
        
        _sbCollectionView.scrollEnabled = YES;
        _sbCollectionView.alwaysBounceVertical = YES;
        _sbCollectionView.alwaysBounceHorizontal = NO;
        _sbCollectionView.showsVerticalScrollIndicator = NO;
        
        [_sbCollectionView registerClass:[SBHomeViewCell class] forCellWithReuseIdentifier:SBHomeViewCellID];
        [_sbCollectionView registerClass:[SBHomeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SBHomeHeadViewID];
    }
    return _sbCollectionView;
}

- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
        _navView.backgroundColor = [UIColor clearColor];
    }
    return _navView;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, ScreenWidth, .5f)];
        _topLine.backgroundColor = [UIColor whiteColor];
        _topLine.alpha = 0.2;
        _topLine.hidden = YES;
    }
    return _topLine;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"YMHomeBackground"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        _bgView.layer.contents = (id)image.CGImage;
    }
    return _bgView;
}

- (UIView *)horLine {
    if (!_horLine) {
        _horLine = [[UIView alloc] initWithFrame:CGRectMake(0, _layout.headerReferenceSize.height + ScreenWidth/2, ScreenWidth, 1.0f)];
        _horLine.backgroundColor = RGB(227, 227, 227);
    }
    return _horLine;
}

- (UIView *)verLine {
    if (!_verLine) {
        _verLine = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2, _layout.headerReferenceSize.height, 1.0f, ScreenWidth)];
        _verLine.backgroundColor = RGB(227, 227, 227);
    }
    return _verLine;
}


@end
