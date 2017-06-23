//
//  CXCarouselView.m
//  pregnant-information
//
//  Created by 王长旭 on 16/2/25.
//  Copyright © 2016年 sw. All rights reserved.
//

#import "CXCarouselView.h"
#import "UIImageView+WebCache.h"
#import "NSTimer+Block.h"
@interface CXCarouselView()<UIScrollViewDelegate>

@property BOOL hasTimer;
@property (assign, nonatomic) NSUInteger interval;

@property (strong, nonatomic) UIImage *placeHolder;
@property (strong, nonatomic) NSArray * imageArray;
@property (strong, nonatomic) UIScrollView *wheelScrollView;
@property (strong, nonatomic) UIPageControl *wheelPageControl;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSUInteger currentImageIndex;
@property (strong, nonatomic) UIImageView *image1;
@property (strong, nonatomic) UIImageView *image2;
@property (strong, nonatomic) UIImageView *image3;
@property (assign, nonatomic) NSUInteger imageNum;
@property (strong, nonatomic) UIImageView *mask;
@property (assign, nonatomic) BOOL isLocal;
@end

@implementation CXCarouselView{
    struct{
        unsigned int response : 1;
    } _delegateFlags;
}

+(instancetype)initWithFrame:(CGRect)frame hasTimer:(BOOL)hastimer interval:(NSUInteger)inter placeHolder:(UIImage *)image{
    
    CXCarouselView * carousel = [[CXCarouselView alloc] initWithFrame:frame];
    carousel.placeHolder = image;
    carousel.hasTimer = hastimer;
    carousel.interval = inter;
    carousel.mask.image = image;
    return carousel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.mask = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.wheelScrollView];
        [self addSubview:self.wheelPageControl];
        [self addSubview:self.mask];
        self.wheelScrollView.scrollEnabled = NO;
    }
    return self;
}

-(void) setupWithArray:(NSArray *)array{
    if ([array count] <= 0) return;
    
    if ([[array firstObject] rangeOfString:@"http"].location == NSNotFound) {
        self.isLocal = YES;
    }
    
    self.wheelScrollView.scrollEnabled = YES;
    self.mask.hidden = YES;
    self.imageArray = array;
    self.imageNum = self.imageArray.count;
    self.currentImageIndex = 0;
    
    if (self.imageNum == 1) {
        self.wheelPageControl.hidden = YES;
        self.wheelScrollView.scrollEnabled = NO;
    }
    
    
    [self setup];
}

-(void) setup{
    self.wheelPageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.wheelPageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    CGPoint p = CGPointMake(self.frame.size.width * 0.5, 0.8 * self.frame.size.height);
    self.wheelPageControl.center = p;
    if (self.hasTimer) {
        [self setupTimer];
    }
    [self updateImage];
}

- (void) updateImage{
    self.imageNum = (int)self.imageArray.count;
    self.wheelPageControl.numberOfPages = self.imageNum;
    [self updateScrollImage];
}

- (void) updateWheel{
    CGPoint offset = self.wheelScrollView.contentOffset;
    offset.x += self.wheelScrollView.frame.size.width;
    [self.wheelScrollView setContentOffset:offset animated:YES];
}

-(void) updateScrollImage{
    int left;
    int right;
    int page = self.wheelScrollView.contentOffset.x / self.wheelScrollView.frame.size.width;
    if (page == 0) {
        self.currentImageIndex = (self.currentImageIndex + self.imageNum - 1) % self.imageNum;
    }else if(page == 2){
        self.currentImageIndex = (self.currentImageIndex + 1) % self.imageNum;
    }
    
    left = (int)(self.currentImageIndex + self.imageNum -1) % self.imageNum;
    right = (int)(self.currentImageIndex + 1) % self.imageNum;
    if (self.isLocal) {
        self.image1.image = [UIImage imageNamed:self.imageArray[left]];
        self.image2.image = [UIImage imageNamed:self.imageArray[self.self.currentImageIndex]];
        self.image3.image = [UIImage imageNamed:self.imageArray[right]];
    }else{
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:self.imageArray[left]] placeholderImage:self.placeHolder];
        [self.image2 sd_setImageWithURL:[NSURL URLWithString:self.imageArray[self.currentImageIndex]] placeholderImage:self.placeHolder];
        [self.image3 sd_setImageWithURL:[NSURL URLWithString:self.imageArray[right]] placeholderImage:self.placeHolder];
    }
    
    
    
    self.wheelPageControl.currentPage = self.currentImageIndex;
    [self.wheelScrollView setContentOffset:CGPointMake(self.wheelScrollView.frame.size.width, 0) animated:NO];
}

-(void) setupTimer{
    if (self.interval == 0) {
        self.interval = 3;
    }
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer cx_scheduledTimerWithTimeInterval:self.interval block:^{
        [weakSelf updateWheel];
    } repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void) touch{
    if (_delegateFlags.response) {
        [self.delegate carouselTouch:self atIndex:self.currentImageIndex];
    }
}

#pragma mark - UIScrollView
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updateScrollImage];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateScrollImage];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setupTimer];
}


#pragma mark - Getter
-(UIScrollView *)wheelScrollView{
    if (!_wheelScrollView) {
        _wheelScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _wheelScrollView.backgroundColor = [UIColor clearColor];
        _wheelScrollView.pagingEnabled = YES;
        _wheelScrollView.delegate = self;
        _wheelScrollView.showsHorizontalScrollIndicator = NO;
        _wheelScrollView.showsVerticalScrollIndicator = NO;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch)];
        [_wheelScrollView addGestureRecognizer:tap];
        
        _image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _image2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        _image3 = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        _image2.image = self.placeHolder;
        
        for (UIImageView * img in @[_image1,_image2,_image3]) {
            [_wheelScrollView addSubview:img];
        }
        
        
        [_wheelScrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        _wheelScrollView.scrollEnabled = YES;
        _wheelScrollView.contentSize = CGSizeMake(3*self.frame.size.width, self.frame.size.height);
    }
    return _wheelScrollView;
}

-(UIPageControl *)wheelPageControl{
    if (!_wheelPageControl) {
        _wheelPageControl = [[UIPageControl alloc] init];
        [_wheelPageControl setBackgroundColor:[UIColor clearColor]];
        _wheelPageControl.currentPage = 0;
        _wheelPageControl.numberOfPages = self.imageNum;
    }
    return _wheelPageControl;
}

#pragma mark - Setter
-(void)setDelegate:(id<CXCarouseViewDelegate>)delegate{
    _delegate = delegate;
    _delegateFlags.response = [self.delegate respondsToSelector:@selector(carouselTouch:atIndex:)];
}

-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

@end
