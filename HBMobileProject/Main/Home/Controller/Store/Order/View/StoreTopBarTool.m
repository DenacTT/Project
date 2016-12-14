//
//  StoreTopBarTool.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "StoreTopBarTool.h"
#import "UIView+LayoutMethods.h"

@interface StoreTopBarTool ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UIScrollView *barScrollView;

@property (nonatomic, strong) UIButton *lastBtn;    //持续选中的button

@property (nonatomic, strong) UILabel *scrollLine;

@property (nonatomic, strong) UILabel *bottomLine;

@property (nonatomic, strong) UILabel *waitPayPoint; //待支付提示红点

@property (nonatomic, strong) UILabel *waitReceivePoint;  //待收货提示红点

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, strong) NSMutableArray *btnList;

@end

@implementation StoreTopBarTool

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items selectIndex:(NSInteger)selectedIndex select:(SelectItem)selectBlock {
    
    if (self = [super initWithFrame:frame]) {
        
        if (items && [items isKindOfClass:[NSArray class]]) {
            _items = [NSArray arrayWithArray:items];
        }else{
            _items = [NSArray array];
        }
        
        [self initSubViews];
        
        if (selectBlock) {
            self.selectBlock = selectBlock;
        }
    }
    return self;
}

- (void)initDataWithModel:(OrderModel *)model {
    switch (model.status) {
        case OrderStatusWaitPay:
            self.waitPayPoint.text = [NSString stringWithFormat:@"%zi", model.status];
            break;
        case OrderStatusWaitReceive:
            self.waitReceivePoint.text = [NSString stringWithFormat:@"%zi", model.status];
            break;
        default:
            break;
    }
}

- (void)initSubViews {
    
    self.barScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _barScrollView.delegate = self;
    _barScrollView.scrollsToTop = NO;
    _barScrollView.alwaysBounceHorizontal = NO;//规定是否在水平方向在滚动到末尾时产生“反弹”
    _barScrollView.showsHorizontalScrollIndicator = NO;//不显示水平滚动条
    
    _itemWidth = ScreenWidth / 4;
    
    if (_items.count > 0) {
        _barScrollView.contentSize = CGSizeMake(_items.count * _itemWidth, _barScrollView.height);
        for (int i = 0; i < _items.count; i++) {
            
            UIButton *itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(_itemWidth * i, 0, _itemWidth, self.height)];
            itemBtn.tag = i;
            itemBtn.titleLabel.font = Font(14);
            [itemBtn setTitleColor:RGB(50, 50, 50) forState:(UIControlStateNormal)];
            [itemBtn setTitle:_items[i] forState:(UIControlStateNormal)];
            [itemBtn addTarget:self action:@selector(selectedItem:) forControlEvents:(UIControlEventTouchUpInside)];
            [_barScrollView addSubview:itemBtn];
            
            if (i == 1) {
                self.waitPayPoint = [self createCountViewWithReferenceView:itemBtn];
                [self addSubview:_waitPayPoint];
            }else if (i == 2) {
                self.waitReceivePoint = [self createCountViewWithReferenceView:itemBtn];
                [self addSubview:_waitReceivePoint];
            }
            
            if (i == 0) {
                [self selectedItem:itemBtn];
            }
            
            [self.btnList addObject:itemBtn];
        }
    }
    
    _scrollLine = [[UILabel alloc] initWithFrame:CGRectMake(0, _barScrollView.height-2.5, _itemWidth, 2)];
    _scrollLine.backgroundColor = RGB(66, 206, 205);
    [_barScrollView addSubview:_scrollLine];
    
    _bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, _barScrollView.height-0.5, ScreenWidth, 0.5)];
    _bottomLine.backgroundColor = RGBA(136, 136, 136, 0.5);
    
    [self addSubview:_barScrollView];
    [self addSubview:_bottomLine];
    
    [self scrollToIndex:_selectedIndex];
}

- (void)scrollToIndex:(NSInteger)index {
    
    _selectedIndex = index;
    if (index < self.btnList.count) {
        [self selectedItem:self.btnList[index]];

//        if (index < self.btnList.count - 3) {
//            [_barScrollView setContentOffset:CGPointMake(index * _itemWidth, _barScrollView.contentOffset.y) animated:YES];
//        } else {
//            [_barScrollView setContentOffset:CGPointMake((index - 3)* _itemWidth, _barScrollView.contentOffset.y) animated:YES];
//        }
    }
}

// 选中 item
- (void)selectedItem:(UIButton *)button {
    
    if (button == _lastBtn) {   //重复选中
        return;
    }
    
    if (button.tag < _items.count) {
        [button setTitleColor:RGB(66, 206, 205) forState:(UIControlStateNormal)];
        if (_lastBtn) {
            [_lastBtn setTitleColor:RGB(50, 50, 50) forState:(UIControlStateNormal)];
        }
        _lastBtn = button;
        
        [self scrollLineAnimationWithButton:button];
    }
    
    if (self.selectBlock) {
        self.selectBlock(button.tag);
    }
}

- (UILabel *)createCountViewWithReferenceView:(UIButton *)view {
    UILabel *redPoint = [[UILabel alloc] initWithFrame:CGRectMake(view.center.x+20, view.center.y-15, 13, 13)];
    redPoint.backgroundColor = RGB(248, 68, 68);
    redPoint.text = @"9";
    redPoint.font = Font(10);
    redPoint.textColor = RGB(255, 255, 255);
    redPoint.textAlignment = NSTextAlignmentCenter;
    redPoint.layer.cornerRadius = redPoint.width/2;
    redPoint.layer.masksToBounds = YES;
    return redPoint;
}

- (void)scrollLineAnimationWithButton:(UIButton *)button {
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        [_scrollLine centerXEqualToView:button];
    } completion:nil];
}

#pragma mark - getter
- (NSMutableArray *)btnList {
    if (!_btnList) {
        _btnList = [NSMutableArray array];
    }
    return _btnList;
}

@end
