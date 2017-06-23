//
//  SBHomeView.m
//  scale
//
//  Created by HarbingWang on 17/3/28.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBHomeView.h"
#import "SBHeadStatusView.h"
#import "SBHomeHeadView.h"
#import "SBHomeViewCell.h"
#import "SBHomeModel.h"
#import "HomePopViewController.h"

static NSString * const SBHomeViewCellID = @"SBHomeViewCellID";
static NSString * const SBHomeHeadViewID = @"SBHomeHeadViewID";

#define minpoint 0
#define midpoint 75
#define maxpoint 200

@interface SBHomeView () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UICollectionViewDelegate, SBHeadStatusViewDelegate, SBHomeHeadViewDelegate>

@property (nonatomic, strong) UICollectionView *sbCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) UIView *navView;//顶部导航栏
@property (nonatomic, strong) UIView *topLine;//导航栏底部
@property (nonatomic, strong) UIView *horLine;//水平分割线
@property (nonatomic, strong) UIView *verLine;//垂直分割线
@property (nonatomic, strong) UIView *bgView; //背景占位图
@property (nonatomic, strong) SBHeadStatusView *statusView;//顶部状态栏
@property (nonatomic, strong) SBHomeHeadView *homeHeadView;//表头视图
@property (nonatomic, assign) LocationStatus locationStatus;

@property (nonatomic, assign) BOOL isPull;  //是否已经开始下拉
@property (nonatomic, assign) BOOL isStart; //是否已经开启同步

@end

@implementation SBHomeView
{
    CGFloat _offsetY;   //y方向偏移量
    CGFloat _lastOffset;//记录最后一次下拉的偏移量
    CGFloat _offset;    //相对上次的偏移量
}

- (void)viewDidLoad {
    [self.view addSubview:self.bgView];
    
    [self.bgView  addSubview:self.navView];
    [self.bgView  addSubview:self.topLine];
    [self.navView addSubview:self.statusView];
    [self.bgView  addSubview:self.sbCollectionView];
    
    [self.sbCollectionView addSubview:self.horLine];
    [self.sbCollectionView addSubview:self.verLine];
}

#pragma mark - Previate Method


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SBHomeHeadViewID forIndexPath:indexPath];
    
    SBHomeModel *model = [[SBHomeModel alloc] init];
    model.calsNum = 6789;
    model.stepNum = 12078;
    model.mileNum = 10.99;
    model.timeNum = 629;
    [self.homeHeadView setValue:model];
    
    [headView addSubview:self.homeHeadView];
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 处理导航栏渐变控制
    // 偏移量 当前是上拉还是下拉 (正值:上拉, 负值:下拉)
    _offsetY = scrollView.contentOffset.y;
    // 相对于上次的偏移值 (正差值:向上移动, 负差值:向下移动)
    _offset  = _offsetY - _lastOffset;
    // 记录最近一次的偏移量
    _lastOffset = _offsetY;
    
    if (_offsetY <=0) {
        self.topLine.hidden = YES;
        if (_offsetY <= -200) {
            scrollView.contentOffset = CGPointMake(0, -200); //往下,限制偏移量
        }
    }else if (_offsetY >0){
        self.topLine.hidden = NO;
        if (_offsetY >= 300){
            scrollView.contentOffset = CGPointMake(0, 300); //往上,限制偏移量
        }
    }
    
    
    // 手环数据同步行为控制
    if (_offset < 0) {              // 向下移动
        // 1.上半段下移
        if (_offsetY >= -midpoint) {
            self.locationStatus = LocationStatus_TopDown;
            NSLog(@"上半段下移 -> _offsetY:%.2f , offset:%.2f", _offsetY, _offset);
        }
        // 2.下半段下移
        if (_offsetY < -midpoint && _offsetY > -maxpoint) {
            self.locationStatus = LocationStatus_BtmDown;
            NSLog(@"下半段下移 -> _offsetY:%.2f , offset:%.2f", _offsetY, _offset);
        }
        
    }
    
    if(_offset > 0) {               // 向上移动
        // 3.释放回弹,下半段上移
        if (_offsetY < -midpoint && _offsetY > -maxpoint) {
            self.locationStatus = LocationStatus_BtmUp;
            NSLog(@"下半段上移 -> _offsetY:%.2f , offset:%.2f", _offsetY, _offset);
        }
        // 4.上半段上移
        if (_offsetY >= -midpoint) {
            self.locationStatus = LocationStatus_TopUp;
            NSLog(@"上半段上移 -> _offsetY:%.2f , offset:%.2f", _offsetY, _offset);
        }
    }
    
    // 5.回到顶部
    if (_offsetY == 0) {
        
    }
}

// called on start of dragging (may require some time and or distance to move)
// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    NSLog(@"%s 开始拖动 scrollview 的时候", __func__);
}

// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
// 在 didEndDragging 前被调用，当 willEndDragging 方法中 velocity 为 CGPointZero
//（结束拖动时两个方向都没有速度）时，didEndDragging 中的 decelerate 为 NO，即没有减速过程，
// willBeginDecelerating 和 didEndDecelerating 也就不会被调用。反之，
// 当 velocity 不为 CGPointZero 时，scroll view 会以 velocity 为初速度，
// 减速直到 targetContentOffset
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

//    NSLog(@"_offsetY:%.2f , offset:%.2f", _offsetY, _offset);
//    NSLog(@"%s 在 didEndDragging 前被调用", __func__);
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
// 在用户结束拖动后被调用，decelerate 为 YES 时，
// 结束拖动后会有减速过程。注，在 didEndDragging 之后，如果有减速过程，
// scroll view 的 dragging 并不会立即置为 NO，而是要等到减速结束之后，
// 所以这个 dragging 属性的实际语义更接近 scrolling。

// 结束拖拽(手指松开)
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate && self.locationStatus == LocationStatus_BtmDown) {
        NSLog(@"_offsetY:%.2f , offset:%.2f", _offsetY, _offset);
        NSLog(@"====== 结束拖动后调用%s  ========", __func__);
        [self.statusView setSynStatus:SynStatusSyning];
    }
}

// called on finger up as we are moving
// 减速动画开始前被调用
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {

    //NSLog(@"%s 减速动画开始前被调用", __func__);
}

// called when scroll view grinds to a halt
// 减速动画结束时被调用，这里有一种特殊情况：当一次减速动画尚未结束的时候再次 drag scroll view，
// didEndDecelerating 不会被调用，并且这时 scroll view 的 dragging 和 decelerating 属性都是 YES。
// 新的 dragging 如果有加速度，那么 willBeginDecelerating 会再一次被调用，然后才是 didEndDecelerating；
// 如果没有加速度，虽然 willBeginDecelerating 不会被调用，但前一次留下的 didEndDecelerating 会被调用

// 结束减速，手指操作，停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //NSLog(@"%s 减速动画结束时被调用", __func__);
}

// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
// 结束滚动动画，非手指操作，停止滚动
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    NSLog(@"%s", __func__);
}

// return a view that will be scaled. if delegate returns nil, nothing happens
// 告诉代理要缩放那个控件
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    return nil;
}

// any zoom scale changes
// view缩放改变的时候调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
};

// called before the scroll view begins zooming its content
// 缩放开始的时候调用
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {

    NSLog(@"%s 缩放开始的时候调用", __func__);
}

// scale between minimum and maximum. called after any 'bounce' animations
// 缩放完毕的时候调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {

    NSLog(@"%s 缩放完毕的时候调用", __func__);
}

// return a yes if you want to scroll to the top. if not defined, assumes YES
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    return YES;
}

// called when scrolling animation finished. may be called immediately if already at top
// 滚动动画完成时调用
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {

    NSLog(@"%s 滚动动画完成时调用", __func__);
}

#pragma mark - SBHeadStatusViewDelegate
// 头像点击
- (void)userBtnClicked {
    HomePopViewController *popVC = [[HomePopViewController alloc] init];
    UIImage *image = [[[self.view superview] superview] toUIImage];
    popVC.bgImage  = image;
    [self.navigationController presentViewController:popVC animated:NO completion:nil];
}

// 跑步模式
- (void)runBtnClicked {
    
}

#pragma mark - SBHomeHeadViewDelegate
- (void)headViewClicked:(SBHeadType)type {
  
}

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // 恢复动画
    [self.homeHeadView resumeCircleLayer];
    [self.statusView resumeSynLayer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 暂停动画
    [self.homeHeadView pauseCircleAnimation];
    [self.statusView pauseSynAnimation];
}

- (void)dealloc {
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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

- (SBHeadStatusView *)statusView {
    if (!_statusView) {
        _statusView = [[SBHeadStatusView alloc] initWithFrame:self.navView.bounds];
        _statusView.delegate = self;
    }
    return _statusView;
}

- (SBHomeHeadView *)homeHeadView {
    if (!_homeHeadView) {
        _homeHeadView = [[SBHomeHeadView alloc] initWithFrame: CGRectMake(0, 0, ScreenWidth, 305)];
        _homeHeadView.delegate = self;
    }
    return _homeHeadView;
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
