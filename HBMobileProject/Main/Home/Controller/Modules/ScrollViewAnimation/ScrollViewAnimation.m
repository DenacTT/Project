//
//  ScrollViewAnimation.m
//  HBMobileProject
//
//  Created by HarbingWang on 2017/4/13.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "ScrollViewAnimation.h"
#import "ScrollComputingValue.h"

#import "HomePopViewController.h"

@interface ScrollViewAnimation ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) UIImageView *firstImageView;
//@property (nonatomic, strong) UIImageView *secondImageView;

@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, strong) NSMutableArray *valuesArray;
@end

@implementation ScrollViewAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isUseRightBtn = YES;
    self.isUseBackBtn = YES;
    [self.rightBtn setTitle:@"切换" forState:UIControlStateNormal];

    [self.view addSubview:self.scrollView];
    
//    [self.scrollView addSubview:self.firstImageView];
//    [self.scrollView addSubview:self.secondImageView];
    
//    self.firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.scrollView.height)];
//    _firstImageView.image = Image(@"page01");
//    [self.scrollView addSubview:_firstImageView];
//    
//    self.secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.firstImageView.right, 0, ScreenWidth, self.scrollView.height)];
//    _secondImageView.image = Image(@"page02");
//    [self.scrollView addSubview:_secondImageView];
    
    // setup ScrollView
    NSInteger imageCount = 3;
    self.valuesArray = [NSMutableArray array];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth*imageCount, self.scrollView.height);
    for (int i = 0; i < imageCount; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"page0%zi", i+1]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        imageView.tag = 100 + i;
        imageView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:imageView];
        
        if (i == 0) {
            imageView.alpha = 1.f;
        } else {
            imageView.alpha = 0.f;
        }
        
//        UIView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
//        view.tag = 100 + i;
//        if (i==0) {
//            view.backgroundColor = [UIColor orangeColor];
//        } else if(i==1){
//            view.backgroundColor = [UIColor lightGrayColor];
//        }else{
//            view.backgroundColor = [UIColor redColor];
//        }
//        [self.view addSubview:view];
        
        
//        if (i == 0) {
//            view.alpha = 1.f;
//        } else {
//            view.alpha = 0.f;
//        }
        
        // Setup ScrollComputingValues.
        ScrollComputingValue *value = [[ScrollComputingValue alloc] init];
        value.startValue = -ScreenWidth + i * ScreenWidth;
        value.midValue = 0 + i * ScreenWidth;
        value.endValue = +ScreenWidth + i * ScreenWidth;
        [value makeTheSetupEffective];
        [self.valuesArray addObject:value];
    }
}

- (void)clickRightBtn {

    // test
    HomePopViewController *popVC = [[HomePopViewController alloc] init];
    UIImage *image = [[[self.view superview] superview] toUIImage];
    popVC.bgImage = image;
    
    __block typeof(self) weakSelf = self;
    popVC.dismissBlock = ^(NSIndexPath *indexPath) {
        CGRect rect = CGRectMake(ScreenWidth*indexPath.row, 64, ScreenWidth, self.scrollView.height);
        [weakSelf.scrollView scrollRectToVisible:rect animated:NO];
    };
    [self presentViewController:popVC
                       animated:NO
                     completion:^{
                         
                     }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetX = scrollView.contentOffset.x;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [self.view viewWithTag:100 + i];
//        UIView *view = [self.view viewWithTag:100 + i];
        
        ScrollComputingValue *value = _valuesArray[i];
        value.inputValue = offsetX;
        imageView.alpha = value.outputValue;
//        view.alpha = value.outputValue;
    }
}

#pragma mark - Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//限制额外滚动区域
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.directionalLockEnabled = YES;//锁定方向
        _scrollView.pagingEnabled = YES;//分页效果
//        _scrollView.scrollEnabled = NO;//是否允许滚动
        _scrollView.bounces = NO;//是否允许反弹
        _scrollView.delegate = self;
        self.scrollView.pagingEnabled                  = YES;
        self.scrollView.bounces                        = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate                       = self;
    }
    return _scrollView;
}

@end
