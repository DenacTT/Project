//
//  SBHomeHeadView.m
//  scale
//
//  Created by HarbingWang on 17/3/28.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBHomeHeadView.h"
#import "CircleProgressView.h"
#import "SBHomeCalsView.h"
#import "SBHomeImageView.h"
#import "POP.h"

#define SBSpoonBoldFont [UIFont fontWithName:@"Spoon-Bold" size:21]

@interface SBHomeHeadView ()<CAAnimationDelegate>

//卡路里消耗进度 cals
@property (nonatomic, strong) CircleProgressView *calsProgress;
@property (nonatomic, strong) UIImageView *circleOne;//外围的小圈1
@property (nonatomic, strong) UIImageView *circleTwo;//外围的小圈2
@property (nonatomic, strong) SBHomeImageView *finishView; //目标达成
@property (nonatomic, strong) SBHomeCalsView *homeCalsView;//三个文案

// 步数 step
@property (nonatomic, strong) CircleProgressView *stepProgress;
@property (nonatomic, strong) SBHomeImageView *stepFinish;
@property (nonatomic, strong) UIView *stepView;
@property (nonatomic, strong) UILabel *stepNum;

// 里程 mileage
@property (nonatomic, strong) CircleProgressView *mileProgress;
@property (nonatomic, strong) SBHomeImageView *mileFinish;
@property (nonatomic, strong) UIView *mileView;
@property (nonatomic, strong) UILabel *mileNum;

// 时长 time
@property (nonatomic, strong) CircleProgressView *timeProgress;
@property (nonatomic, strong) SBHomeImageView *timeFinish;
@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) UILabel *timeNum;

// testBtn
@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation SBHomeHeadView
{
    CABasicAnimation *circleAnimationOne;
    CABasicAnimation *circleAnimationTwo;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"YMHomeCenterView"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.layer.contents = (id)image.CGImage;
        [self setupSubView];
        [self startCircleAnimation];
    }
    return self;
}

#pragma mark - 布局子控件
- (void)setupSubView {
    
    [self addSubview:self.calsProgress];
    [self addSubview:self.circleOne];
    [self addSubview:self.circleTwo];
    [self addSubview:self.homeCalsView];
    [self addSubview:self.finishView];
    
    [self addSubview:self.stepView];
    [self.stepView addSubview:self.stepProgress];
    [self.stepView addSubview:self.stepNum];
    [self.stepView addSubview:self.stepFinish];
    
    [self addSubview:self.mileView];
    [self.mileView addSubview:self.mileProgress];
    [self.mileView addSubview:self.mileNum];
    [self.mileView addSubview:self.mileFinish];
    
    [self addSubview:self.timeView];
    [self.timeView addSubview:self.timeProgress];
    [self.timeView addSubview:self.timeNum];
    [self.timeView addSubview:self.timeFinish];
    
    [self addSubview:self.startBtn];
    
    __block typeof(self) weakSelf = self;
    [self.homeCalsView.totalCals addTapGesture:^{
        [weakSelf headViewClickAction:SBHeadTypeCals];
    }];
    [self.stepView addTapGesture:^{
        [weakSelf headViewClickAction:SBHeadTypeStep];
    }];
    [self.mileView addTapGesture:^{
        [weakSelf headViewClickAction:SBHeadTypeMile];
    }];
    [self.timeView addTapGesture:^{
        [weakSelf headViewClickAction:SBHeadTypeTime];
    }];
}

- (void)headViewClickAction:(SBHeadType)type {
    
    if ([self.delegate respondsToSelector:@selector(headViewClicked:)]) {
        [self.delegate headViewClicked:type];
    }
}

- (void)setValue:(SBHomeModel *)model {
    
    self.homeCalsView.totalCals.text = @"1234";
    
    [self.stepNum setText:[NSString stringWithFormat:@"%zi", model.stepNum]];
    
    NSString *hour = [NSString stringWithFormat:@"%zi", model.timeNum / 60];
    NSString *mint = [NSString stringWithFormat:@"%zi", model.timeNum % 60];
    [self.timeNum setText:[NSString stringWithFormat:@"%@:%@", hour, mint]];
    
    NSString *timeStr = [NSString stringWithFormat:@"%.2f", model.mileNum];
    NSString *string  = [timeStr stringByAppendingString:@"km"];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:NSFontAttributeName value:SBSpoonBoldFont range:NSMakeRange(0, timeStr.length)];
    [attStr addAttribute:NSFontAttributeName value:SBSpoonBoldFont range:NSMakeRange(timeStr.length, 2)];
    [self.mileNum setAttributedText:attStr];
    
//    CGFloat endValue = (float)(1+arc4random()%99)/100;
//    NSLog(@"progress %.2f", endValue);
//    [self.calsProgress setStrokeEnd:endValue animated:NO];
}

- (void)startAnimation {
    
    //test
    CGFloat endValue = (float)(1+arc4random()%99)/100;
    NSLog(@"progress %.2f", endValue);
    [self.calsProgress setStrokeEnd:endValue animated:NO];
    [self.stepProgress setStrokeEnd:endValue animated:YES];
    [self.mileProgress setStrokeEnd:endValue/2 animated:YES];
    [self.timeProgress setStrokeEnd:endValue/3 animated:YES];
    
    __block typeof(self) weakSelf = self;
    [self.calsProgress setFinishedBlock:^{
        weakSelf.finishView.hidden = NO;
        [weakSelf targetFinishedAnimation];
    }];
    
    [self.stepProgress setFinishedBlock:^{
       [weakSelf targetDidFinish:weakSelf.stepProgress];
    }];
    
    [self.mileProgress setFinishedBlock:^{
        [weakSelf targetDidFinish:weakSelf.mileProgress];
    }];
    
    [self.timeProgress setFinishedBlock:^{
        [weakSelf targetDidFinish:weakSelf.timeProgress];
    }];
}

//暂停动画.保存当前位置和时间
- (void)pauseCircleAnimation {
    CFTimeInterval pausedTimeOne = [self.circleOne.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.circleOne.layer.timeOffset = pausedTimeOne;
    
    CFTimeInterval pausedTimeTwo = [self.circleTwo.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.circleTwo.layer.timeOffset = pausedTimeTwo;
}

//恢复动画
- (void)resumeCircleLayer {
    [self.circleOne.layer removeAllAnimations];
    circleAnimationOne.timeOffset = [self.circleOne.layer convertTime:CACurrentMediaTime() fromLayer:nil] - self.circleOne.layer.timeOffset;
    [self.circleOne.layer addAnimation:circleAnimationOne forKey:nil];
    
    [self.circleTwo.layer removeAllAnimations];
    circleAnimationTwo.timeOffset = [self.circleTwo.layer convertTime:CACurrentMediaTime() fromLayer:nil] - self.circleTwo.layer.timeOffset;
    [self.circleTwo.layer addAnimation:circleAnimationTwo forKey:nil];
}

- (void)targetDidFinish:(CircleProgressView *)view {
    
    SBHomeImageView    *imageView = nil;
    CircleProgressView *progsView = nil;
    [imageView.layer removeAllAnimations];
    [progsView.layer removeAllAnimations];
    
    if (view == self.stepProgress) {
        imageView = self.stepFinish;
        progsView = self.stepProgress;
    }else if (view == self.mileProgress) {
        imageView = self.mileFinish;
        progsView = self.mileProgress;
    }else if (view == self.timeProgress) {
        imageView = self.timeFinish;
        progsView = self.timeProgress;
    }else{
        return;
    }
    
    imageView.hidden = NO;
    progsView.alpha  = 1.f;
    [UIView animateWithDuration:0.2f animations:^{
        
        // 进度条减隐
        progsView.alpha = 0.f;
        imageView.starImage.alpha = 1.f;
        
        // 六边形的缩放
        CAKeyframeAnimation *hexaAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        hexaAnimation.values = @[@(0),@(1.16),@(1.06)];
        hexaAnimation.duration = 0.5f;
        hexaAnimation.removedOnCompletion = NO;
        hexaAnimation.fillMode = kCAFillModeForwards;
        [imageView.hexagonImage.layer addAnimation:hexaAnimation forKey:@"hexaAnimation"];
        
        // 中间✨的缩放
        CAKeyframeAnimation *starAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        starAnimation.values = @[@(0),@(1.5),@(1.3)];
        starAnimation.duration = 0.5f;
        starAnimation.removedOnCompletion = NO;
        starAnimation.fillMode = kCAFillModeForwards;
        [imageView.starImage.layer addAnimation:starAnimation forKey:@"starAnimation"];
        
    } completion:^(BOOL finished) {
        
        // 圆点彩蛋的缩放
        CAKeyframeAnimation *starAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        starAnimation.values = @[@(0),@(2.3),@(2.5)];
        starAnimation.duration = 1.f;
        starAnimation.removedOnCompletion = NO;
        starAnimation.fillMode = kCAFillModeForwards;
        [imageView.colorsImage.layer addAnimation:starAnimation forKey:@"starAnimation"];
        
        // 彩蛋的渐变
        imageView.colorsImage.alpha = 1.f;
        [UIView animateWithDuration:0.6f delay:0.4f options:UIViewAnimationOptionCurveLinear animations:^{
            imageView.colorsImage.alpha = 0.f;
        } completion:^(BOOL finished) {
            
            // 星星,步数 icon 的渐变及位移
            imageView.starImage.alpha = 1.f;
            [UIView animateWithDuration:0.2f animations:^{
                imageView.starImage.alpha = 0.f;
                imageView.starImage.top += 3.f;
            } completion:^(BOOL finished) {
                
                // 进度条中间icon的渐变及位移
                progsView.alpha = 1.f;
                progsView.bgImageView.alpha = 0.f;
                progsView.circleLayer.hidden = YES;
                progsView.bgCircleLayer.hidden = YES;
                progsView.bgImageView.layer.hidden = NO;
                imageView.starImage.top -= 3;
                progsView.bgImageView.top -= 3.f;
                [UIView animateWithDuration:0.2 animations:^{
                    progsView.bgImageView.top += 3.f;
                    progsView.bgImageView.alpha = 1.f;
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }];
    }];
}

#pragma mark - 卡路里目标达成(大)
// 目标达成的动画
- (void)targetFinishedAnimation {
    
    // 先移除 layer 上之前的动画
    [self.finishView.layer removeAllAnimations];
    [self.homeCalsView.layer removeAllAnimations];
    
    // 文案渐隐
    self.homeCalsView.alpha = 1.f;
    self.finishView.starImage.alpha = 0.f;
    self.finishView.colorsImage.alpha = 0.f;
    [UIView animateWithDuration:0.2f animations:^{
        self.homeCalsView.alpha = 0.f;
        self.finishView.starImage.alpha = 1.f;
        
        // 五角星的缩放
        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(0),@(1.1),@(1.0)];
            animation.duration = 0.5f;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [self.finishView.starImage.layer addAnimation:animation forKey:@"scaleAnim"];
        } completion:^(BOOL finished) {
        
        }];
        
    } completion:^(BOOL finished) {
       
        // 彩蛋的缩放
        [UIView animateWithDuration:1.f animations:^{
            self.finishView.colorsImage.alpha = 1.f;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(0),@(1.0),@(1.1)];
            animation.duration = 1.f;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [self.finishView.colorsImage.layer addAnimation:animation forKey:@"colorsScaleAnim"];
            
        } completion:^(BOOL finished) {
           
            // 五角星渐隐
            [UIView animateWithDuration:0.4f animations:^{
                self.finishView.colorsImage.alpha = 0.f;
                self.finishView.starImage.alpha = 1.f;
                [UIView animateWithDuration:0.2f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    self.finishView.starImage.alpha = 0.f;
                    self.homeCalsView.top -= 5;
                    self.finishView.top += 5;
                } completion:^(BOOL finished) {
                    self.finishView.top -= 5;
                    
                    // 卡路里渐现及位移
                    [UIView animateWithDuration:0.2 animations:^{
                        self.homeCalsView.top += 5;
                        self.homeCalsView.alpha = 1.f;
                    } completion:^(BOOL finished) {
                        self.homeCalsView.hidden = NO;
                        self.finishView.hidden = YES;
                    }];
                }];
                
            } completion:^(BOOL finished) {
            
            }];
            
        }];
        
    }];
}

 #pragma mark - 外围两个圆的动画
- (void)startCircleAnimation {
    circleAnimationOne = [CABasicAnimation animation];
    circleAnimationOne = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    circleAnimationOne.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    circleAnimationOne.speed = 0.5f;
    circleAnimationOne.duration = 3.f;
    circleAnimationOne.repeatCount = MAXFLOAT;
    circleAnimationOne.removedOnCompletion = NO;
    circleAnimationOne.fillMode = kCAFillModeForwards;
    [self.circleOne.layer addAnimation:circleAnimationOne forKey:@"circleOneAnimation"];
    
    circleAnimationTwo = [CABasicAnimation animation];
    circleAnimationTwo = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    circleAnimationTwo.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    circleAnimationTwo.speed = 1.f;
    circleAnimationTwo.duration = 5.f;
    circleAnimationTwo.repeatCount = MAXFLOAT;
    [self.circleTwo.layer addAnimation:circleAnimationTwo forKey:@"circleTwoAnimation"];
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
        _calsProgress.isNeedCallBack   = YES;
        _calsProgress.isNeedBackground = YES;
        [_calsProgress makeConfigEffective];
    }
    return _calsProgress;
}

- (UIImageView *)circleOne {
    if (!_circleOne) {
        _circleOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 205, 205)];
        _circleOne.center = _calsProgress.center;
        _circleOne.image = Image(@"sb_home_circle_one");
    }
    return _circleOne;
}

- (UIImageView *)circleTwo {
    if (!_circleTwo) {
        _circleTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 205, 205)];
        _circleTwo.center = _calsProgress.center;
        _circleTwo.image = Image(@"sb_home_circle_two");
    }
    return _circleTwo;
}

- (SBHomeCalsView *)homeCalsView {
    if (!_homeCalsView) {
        _homeCalsView = [[SBHomeCalsView alloc] initWithFrame:CGRectMake(_calsProgress.left, _calsProgress.top+32, _calsProgress.width, _calsProgress.height)];
        _homeCalsView.center = _calsProgress.center;
    }
    return _homeCalsView;
}

- (SBHomeImageView *)finishView {
    if (!_finishView) {
        _finishView = [[SBHomeImageView alloc] initWithFrame:self.calsProgress.frame];
        _finishView.hexagonImage.hidden = YES;
        _finishView.hidden = YES;
    }
    return _finishView;
}

#pragma mark - Getter(步数,里程,时长等子控件)
// 步数
- (UIView *)stepView {
    if (!_stepView) {
        _stepView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)-35-60-50, self.calsProgress.bottom+21, 60, 77)];
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
        _stepProgress.isNeedCallBack   = YES;
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
    }
    return _stepNum;
}

- (SBHomeImageView *)stepFinish {
    if (!_stepFinish) {
        _stepFinish = [[SBHomeImageView alloc] initWithFrame:self.stepProgress.frame];
        _stepFinish.hidden = YES;
    }
    return _stepFinish;
}

// 里程
- (UIView *)mileView {
    if (!_mileView) {
        _mileView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)-30, self.stepView.top, 60, 77)];
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
        _mileProgress.isNeedCallBack   = YES;
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
    }
    return _mileNum;
}

- (SBHomeImageView *)mileFinish {
    if (!_mileFinish) {
        _mileFinish = [[SBHomeImageView alloc] initWithFrame:self.mileProgress.frame];
        _mileFinish.hidden = YES;
    }
    return _mileFinish;
}

// 时长
- (UIView *)timeView {
    if (!_timeView) {
        _timeView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)+25+60, self.stepView.top, 60, 77)];
    }
    return _timeView;
}

- (CircleProgressView *)timeProgress {
    if (!_timeProgress) {
        CGRect frame  = CGRectMake(CGRectGetMidX(self.timeView.bounds)-25, CGRectGetMinY(self.timeView.bounds), 50, 50);
        _timeProgress = [CircleProgressView circleProgressViewWithFrame:frame
                                                              lineWidth:3.f
                                                              lineColor:RGB(180, 219, 246)
                                                              clockWise:YES
                                                             startAngle:1.5*M_PI];
        _timeProgress.isNeedBackground = YES;
        _timeProgress.isNeedBgImg      = YES;
        _timeProgress.isNeedCallBack   = YES;
        _timeProgress.bgLineWidth      = 2.f;
        _timeProgress.bgImgName        = @"sb_home_time";
        [_timeProgress makeConfigEffective];
    }
    return _timeProgress;
}

- (UILabel *)timeNum {
    if (!_timeNum) {
        _timeNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.timeView.bounds), self.timeProgress.bottom+6, self.timeView.width, 21)];
        [self setNumLabel:_timeNum];
    }
    return _timeNum;
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

- (SBHomeImageView *)timeFinish {
    if (!_timeFinish) {
        _timeFinish = [[SBHomeImageView alloc] initWithFrame:self.timeProgress.frame];
        _timeFinish.hidden = YES;
    }
    return _timeFinish;
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
