//
//  SBHomeHeadView.m
//  scale
//
//  Created by HarbingWang on 17/3/28.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBHomeHeadView.h"
#import "CircleProgressView.h"
#import "CircleView.h"

#define ItemW 188
#define SBSpoonBoldFont [UIFont fontWithName:@"Spoon-Bold" size:21]
#define SBSpoonRegularFont [UIFont fontWithName:@"Spoon-Regular" size:60]
@interface SBHomeHeadView ()

@property (nonatomic, strong) CircleProgressView *calsProgress;  //卡路里消耗进度
@property (nonatomic, strong) UILabel *topText;   //顶部文案
@property (nonatomic, strong) UILabel *btmText;   //底部文案
@property (nonatomic, strong) UILabel *totalCals; //卡路里总消耗值

// 步数 step
@property (nonatomic, strong) CircleProgressView *stepProgress;
@property (nonatomic, strong) UIView *stepView;
@property (nonatomic, strong) UILabel *stepNum;

// 里程 mileage
@property (nonatomic, strong) CircleProgressView *mileProgress;
@property (nonatomic, strong) UIView *mileView;
@property (nonatomic, strong) UILabel *mileNum;

// 时长 duration
@property (nonatomic, strong) CircleProgressView *duraProgress;
@property (nonatomic, strong) UIView *duraView;
@property (nonatomic, strong) UILabel *duraNum;

// testBtn
@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation SBHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"YMHomeCenterView"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.layer.contents = (id)image.CGImage;
        
        [self setupSubView];
    }
    return self;
}

#pragma mark - 布局子控件
- (void)setupSubView {
    
    [self addSubview:self.calsProgress];
    [self.calsProgress addSubview:self.topText];
    [self.calsProgress addSubview:self.btmText];
    [self.calsProgress addSubview:self.totalCals];
    
    [self addSubview:self.stepView];
    [self.stepView addSubview:self.stepProgress];
    [self.stepView addSubview:self.stepNum];
    
    [self addSubview:self.mileView];
    [self.mileView addSubview:self.mileProgress];
    [self.mileView addSubview:self.mileNum];
    
    [self addSubview:self.duraView];
    [self.duraView addSubview:self.duraProgress];
    [self.duraView addSubview:self.duraNum];
    
    [self addSubview:self.startBtn];
}

- (void)setValue:(SBHomeModel *)model {
    [self.stepNum setText:[NSString stringWithFormat:@"%zi", model.stepNum]];
    
    NSString *hour = [NSString stringWithFormat:@"%zi", model.timeNum / 60];
    NSString *mint = [NSString stringWithFormat:@"%zi", model.timeNum % 60];
    [self.duraNum setText:[NSString stringWithFormat:@"%@:%@", hour, mint]];
    
    NSString *timeStr = [NSString stringWithFormat:@"%.2f", model.mileNum];
    NSString *string  = [timeStr stringByAppendingString:@"km"];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:NSFontAttributeName value:SBSpoonBoldFont range:NSMakeRange(0, timeStr.length)];
    [attStr addAttribute:NSFontAttributeName value:SBSpoonBoldFont range:NSMakeRange(timeStr.length, 2)];
    [self.mileNum setAttributedText:attStr];
}

- (void)startAnimation {
    //test
    CGFloat endValue = (float)(1+arc4random()%99)/100;
    NSLog(@"%.2f",endValue);
    [self.calsProgress setStrokeEnd:endValue   animated:YES];
    [self.stepProgress setStrokeEnd:endValue/2 animated:YES];
    [self.mileProgress setStrokeEnd:endValue/3 animated:YES];
    [self.duraProgress setStrokeEnd:endValue/4 animated:NO];
    
    [self.calsProgress setFinishedBlock:^{
        [YMUITipsView showTips:@"动画完成回调"];
    }];
}

#pragma mark - Getter(卡路里消耗等子控件)
- (CircleProgressView *)calsProgress {
    if (!_calsProgress) {

        CGRect frame = CGRectMake(CGRectGetMidX(self.bounds)-188/2, CGRectGetMinY(self.bounds)+10, 188, 188);
        _calsProgress = [CircleProgressView circleProgressViewWithFrame:frame
                                                          lineWidth:4.f
                                                          lineColor:[UIColor whiteColor]
                                                          clockWise:YES
                                                         startAngle:1.5*M_PI];
        
//        _calsProgress.startAngle = M_PI;
//        _calsProgress.endAngle = 2*M_PI;
//        _calsProgress.lineWidth = 8.f;
//        _calsProgress.bgLineWidth = 7.f;
        _calsProgress.isNeedBackground = YES;
        [_calsProgress makeConfigEffective];
    }
    return _calsProgress;
}

- (UILabel *)topText {
    if (!_topText) {
        _topText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_calsProgress.bounds), 32, ItemW, 14)];
        [_topText setLabelText:@"Total Calories"
                          font:Font(14)
                     textColor:RGBA(255, 255, 255, 0.8)
                 textAlignment:NSTextAlignmentCenter];
    }
    return _topText;
}

- (UILabel *)btmText {
    if (!_btmText) {
        _btmText = [[UILabel alloc] initWithFrame:CGRectMake(_topText.left, CGRectGetMaxY(_calsProgress.bounds)-32-16, ItemW, 16)];
        [_btmText setLabelText:@"Cals"
                          font:Font(16)
                     textColor:RGBA(255, 255, 255, 0.8)
                 textAlignment:NSTextAlignmentCenter];
    }
    return _btmText;
}

- (UILabel *)totalCals {
    if (!_totalCals) {
        _totalCals = [[UILabel alloc] initWithFrame:CGRectMake(_topText.left, _topText.bottom, ItemW, 188-32*2-16-14)];
        [_totalCals setLabelText:@"6789"
                            font:SBSpoonRegularFont
                       textColor:RGB(255, 255, 255)
                   textAlignment:NSTextAlignmentCenter];
        
        _totalCals.layer.shadowColor = RGBA(0, 0, 0, 0.1).CGColor;
        _totalCals.layer.shadowOffset = CGSizeMake(0, 3);
        _totalCals.layer.shadowOpacity = 0.3;
    }
    return _totalCals;
}

#pragma mark - Getter(步数,里程,时长等子控件)
// 步数
- (UIView *)stepView {
    if (!_stepView) {
        _stepView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)-35-60-50, self.calsProgress.bottom+21, 60, 77)];
//        _stepView.backgroundColor = [UIColor orangeColor];
    }
    return _stepView;
}

- (CircleProgressView *)stepProgress {
    if (!_stepProgress) {
        CGRect frame = CGRectMake(CGRectGetMidX(self.stepView.bounds)-25, CGRectGetMinY(self.stepView.bounds), 50, 50);
        _stepProgress = [CircleProgressView circleProgressViewWithFrame:frame
                                                              lineWidth:3.f
                                                              lineColor:RGB(180, 219, 246)
                                                              clockWise:YES
                                                             startAngle:1.5*M_PI];
        _stepProgress.isNeedBackground = YES;
        _stepProgress.isNeedBgImg      = YES;
        _stepProgress.bgLineWidth      = 2.f;
        _stepProgress.bgImgName        = @"sb_home_step";
        [_stepProgress makeConfigEffective];
    }
    return _stepProgress;
}

- (UILabel *)stepNum {
    if (!_stepNum) {
        _stepNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.stepView.bounds), self.stepProgress.bottom+6, self.stepView.width, 21)];
        [self setNumLabel:_stepNum];
//        _stepNum.backgroundColor = [UIColor whiteColor];
    }
    return _stepNum;
}

// 里程
- (UIView *)mileView {
    if (!_mileView) {
        _mileView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)-30, self.stepView.top, 60, 77)];
//        _mileView.backgroundColor = [UIColor orangeColor];
    }
    return _mileView;
}

- (CircleProgressView *)mileProgress {
    if (!_mileProgress) {
        CGRect frame = CGRectMake(CGRectGetMidX(self.mileView.bounds)-25, CGRectGetMinY(self.mileView.bounds), 50, 50);
        _mileProgress = [CircleProgressView circleProgressViewWithFrame:frame
                                                              lineWidth:3.f
                                                              lineColor:RGB(180, 219, 246)
                                                              clockWise:YES
                                                             startAngle:1.5*M_PI];
        _mileProgress.isNeedBackground = YES;
        _mileProgress.isNeedBgImg      = YES;
        _mileProgress.bgLineWidth      = 2.f;
        _mileProgress.bgImgName        = @"sb_home_distence";
        [_mileProgress makeConfigEffective];
    }
    return _mileProgress;
}

- (UILabel *)mileNum {
    if (!_mileNum) {
        _mileNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.mileView.bounds)-15, self.mileProgress.bottom+6, self.mileView.width+30, 21)];
        [self setNumLabel:_mileNum];
//        _mileNum.backgroundColor = [UIColor whiteColor];
    }
    return _mileNum;
}

// 时长
- (UIView *)duraView {
    if (!_duraView) {
        _duraView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)+25+60, self.stepView.top, 60, 77)];
//        _duraView.backgroundColor = [UIColor orangeColor];
    }
    return _duraView;
}

- (CircleProgressView *)duraProgress {
    if (!_duraProgress) {
        CGRect frame  = CGRectMake(CGRectGetMidX(self.duraView.bounds)-25, CGRectGetMinY(self.duraView.bounds), 50, 50);
        _duraProgress = [CircleProgressView circleProgressViewWithFrame:frame
                                                              lineWidth:3.f
                                                              lineColor:RGB(180, 219, 246)
                                                              clockWise:YES
                                                             startAngle:1.5*M_PI];
        _duraProgress.isNeedBackground = YES;
        _duraProgress.isNeedBgImg      = YES;
        _duraProgress.bgLineWidth      = 2.f;
        _duraProgress.bgImgName        = @"sb_home_time";
        [_duraProgress makeConfigEffective];
    }
    return _duraProgress;
}

- (UILabel *)duraNum {
    if (!_duraNum) {
        _duraNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.duraView.bounds), self.duraProgress.bottom+6, self.duraView.width, 21)];
        [self setNumLabel:_duraNum];
//        _duraNum.backgroundColor = [UIColor whiteColor];
    }
    return _duraNum;
}

- (void)setNumLabel:(UILabel *)label{
    [label setLabelText:@""
                   font:SBSpoonBoldFont
              textColor:RGB(255, 255, 255)
          textAlignment:NSTextAlignmentCenter];
    
    label.layer.shadowColor = RGBA(0, 0, 0, 0.2).CGColor;
    label.layer.shadowOffset = CGSizeMake(0, 2);
    label.layer.shadowOpacity = 0.3;
}

- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.frame = CGRectMake(ScreenWidth-50, 0, 40, 40);
        _startBtn.backgroundColor = RGBA(255, 255, 255, 0.5);
        _startBtn.layer.masksToBounds = YES;
        _startBtn.layer.cornerRadius = 20;
        
        [_startBtn addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}

@end
