//
//  HomePopViewController.m
//  HBMobileProject
//
//  Created by whb on 2017/4/5.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "HomePopViewController.h"
#import "UIImage+ImageEffects.h"
#import "HomePopHeaderView.h"
#import "HomePopCellView.h"
#import "POP.h"
#import "Member.h"

#define CancelBtnCenter CGPointMake(8+32/2, 44/2+20);

static NSString * const HomePopCellID = @"HomePopCellID";

typedef enum : NSUInteger {
    DeviceType_Band,
    DeviceType_Scale,
} DeviceType;

@interface HomePopViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

//模糊背景
@property (nonatomic, strong) UIImageView *blurImgView; //背景图片
@property (nonatomic, strong) UIImageView *blurView;    //高斯模糊
@property (nonatomic, strong) UIView      *bgView;      //背景图层

//视图布局
@property (nonatomic, strong) UIButton    *cancelBtn;   //取消按钮
@property (nonatomic, strong) UIView      *popView;     //弹出视图
@property (nonatomic, strong) UITableView *tableView;   //设备,用户列表

@property (nonatomic, strong) NSMutableArray *bandUsers;//手环用户
@property (nonatomic, strong) NSMutableArray *scalUsers;//体脂称用户

@end

@implementation HomePopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.blurImgView];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.bgView];
    
    [self.bgView  addSubview:self.cancelBtn];
    [self.bgView  addSubview:self.popView];
    [self.popView addSubview:self.tableView];
    
    self.blurImgView.image = [self.bgImage blurImageWithRadius:5.f];
    [self initData];
}

- (void)initData {
    
    Member *m1 = [[Member alloc] init];
    m1.name = @"HarbingW";
    m1.userType = MainUser;
    
    Member *m2 = [[Member alloc] init];
    m2.name = @"66666";
    m2.userType = SubUser;
    
    Member *m3 = [[Member alloc] init];
    m3.name = @"00000";
    m3.userType = SubUser;
    
    Member *m4 = [[Member alloc] init];
    m4.name = @"22222";
    m4.userType = SubUser;
    
    [self.bandUsers addObject:m1];
    [self.scalUsers addObjectsFromArray:@[m1, m2, m3, m4]];
}

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.popView.top = self.cancelBtn.bottom;
    self.popView.alpha = 0;
    
    __block typeof(self) weakSelf = self;
    self.cancelBtn.alpha= 0;
    self.blurView.alpha = 0;
    self.bgView.alpha   = 0;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.cancelBtn.alpha= 1;
        weakSelf.blurView.alpha = 1;
        weakSelf.bgView.alpha   = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [self popViewAppearAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {}

- (void)viewDidDisappear:(BOOL)animated {}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 设置状态栏style白字
    return UIStatusBarStyleLightContent;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == DeviceType_Band) {
        return 1;
    }else if(section == DeviceType_Scale){
        return 4;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomePopHeaderView *headerView = [[HomePopHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 40)];
    if (section == DeviceType_Band) {
        headerView.productIcon.image = Image(@"sb_home_band");
        headerView.productName.text  = @"Band Model";
    } else {
        headerView.productIcon.image = Image(@"sb_home_scale");
        headerView.productName.text  = @"Scale Model";
    }
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomePopCellView *cell = [tableView dequeueReusableCellWithIdentifier:HomePopCellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.model = self.bandUsers[indexPath.row];
    } else {
        cell.model = self.scalUsers[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Member *model = [[Member alloc] init];
    if (indexPath.section==0) {
        model = self.bandUsers[indexPath.row];
    } else {
        model = self.scalUsers[indexPath.row];
        [self changeView:indexPath.row];
    }
    if (self.dismissBlock) {
        self.dismissBlock(indexPath);
    }
    [self dismissPopView];
}

- (void)changeView:(NSInteger)row {
    
}

#pragma mark - Private Methods
- (void)dismissPopView {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)popViewAppearAnimation {
    
    POPBasicAnimation *base = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    base.duration  = 0.1f;
    base.fromValue = @(0.0);
    base.toValue   = @(1.0);
    [self.popView pop_addAnimation:base forKey:@"baseAnimation"];
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    spring.springSpeed      = 3.0f;//动画速度
    spring.fromValue = [NSValue valueWithCGRect:CGRectMake(10, self.cancelBtn.bottom, 0, 0)];
    spring.toValue   = [NSValue valueWithCGRect:CGRectMake(10, self.cancelBtn.bottom+8, 210, 55*5+40*2)];
    [self.popView pop_addAnimation:spring forKey:@"frameAnimation"];
}

#pragma mark - 手势代理，解决和tableview点击冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //判断如果点击的是tableView的cell，就把手势给取消了
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        //取消手势
        return NO;
    }
    //否则手势存在
    return YES;
}

#pragma mark - Getter
- (UIImageView *)blurImgView {
    if (!_blurImgView) {
        _blurImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _blurImgView;
}

- (UIImageView *)blurView {
    if (!_blurView) {
        _blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _blurView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bgView.backgroundColor = RGBA(0, 0, 0, 0.6);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.delegate = self;
        [tap addTarget:self action:@selector(dismissPopView)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame  = CGRectMake(0, 0, 32, 32);
        _cancelBtn.center = CancelBtnCenter;
        
        [_cancelBtn setImage:Image(@"sb_home_close_tab") forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(dismissPopView) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cancelBtn;
}

- (UIView *)popView {
    if (!_popView) {
        _popView = [[UIView alloc] initWithFrame:CGRectMake(8, self.cancelBtn.center.y+self.cancelBtn.height/2+8, 210, 40*2+55*5)];
        _popView.backgroundColor = [UIColor clearColor];
        
        //绘制三角形
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(9, 6)];
        [path addLineToPoint:CGPointMake(9+6, 0)];
        [path addLineToPoint:CGPointMake(9+12, 6)];
        [path closePath];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = RGBA(70, 70, 70, 0.9).CGColor;
        layer.path = path.CGPath;
        [self.popView.layer addSublayer:layer];
    }
    return _popView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 6, self.popView.width, self.popView.height) style:UITableViewStylePlain];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGBA(34, 34, 34, 0.9);
        _tableView.layer.cornerRadius  = 3;
        _tableView.layer.masksToBounds = YES;
        
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView registerClass:[HomePopCellView class] forCellReuseIdentifier:HomePopCellID];
    }
    return _tableView;
}

- (NSMutableArray *)bandUsers {
    if (!_bandUsers) {
        _bandUsers = [NSMutableArray array];
    }
    return _bandUsers;
}

- (NSMutableArray *)scalUsers {
    if (!_scalUsers) {
        _scalUsers = [NSMutableArray array];
    }
    return _scalUsers;
}

@end
