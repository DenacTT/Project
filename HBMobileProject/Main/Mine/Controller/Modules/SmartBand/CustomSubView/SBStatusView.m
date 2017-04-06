//
//  SBStatusView.m
//  HBMobileProject
//
//  Created by whb on 2017/4/5.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBStatusView.h"
#import "CircleProgressView.h"

@interface SBStatusView ()

@property (nonatomic, strong) CircleProgressView *synProgsView;//同步进度条
@property (nonatomic, strong) UIImageView *productIcon;   //产品图片
@property (nonatomic, strong) UIImageView *unConneIcon;   //未连接状态icon
@property (nonatomic, strong) UIImageView *synCircleIcon; //同步进行中的icon

@property (nonatomic, strong) UIView *batteryStatusView;  //电池状态View,承载icon和label
@property (nonatomic, strong) UIImageView *batteryIcon;   //电池图标icon
@property (nonatomic, strong) UILabel     *batteryStatus; //电量状态显示

@property (nonatomic, strong) UILabel     *synStatusText; //同步状态文案
@property (nonatomic, strong) UIButton    *headBtn;       //头像按钮

@property (nonatomic, strong) UIView *synSuccessView;    //同步完成的View,承载icon和text
@property (nonatomic, strong) UIImageView *successIcon;  //同步成功icon
@property (nonatomic, strong) UILabel *successText;      //同步成功文案

@end

@implementation SBStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.headBtn];
        
        [self addSubview:self.synProgsView];
        [self addSubview:self.productIcon];
        [self addSubview:self.synCircleIcon];
        [self addSubview:self.unConneIcon];
        
        [self addSubview:self.batteryStatusView];
        [self.batteryStatusView addSubview:self.batteryIcon];
        [self.batteryStatusView addSubview:self.batteryStatus];
        
        [self addSubview:self.synStatusText];
        [self addSubview:self.synSuccessView];
        [self.synSuccessView addSubview:self.successIcon];
        [self.synSuccessView addSubview:self.successText];
        
        [self synIconCircleAnimation];
    }
    return self;
}

#pragma mark - Private Method
// 点击头像切换
- (void)switchUser:(UIButton *)sender {

    // 电池状态显示
    CGFloat batteryPercent = 0.6f;
    CGRect frame = CGRectMake(self.batteryIcon.left+6, self.batteryIcon.bottom-2.5-11*batteryPercent, 5, 11 * batteryPercent);
    self.batteryStatus.frame = frame;
    
    // 开启摇晃动画
    [self statusShakeAnimation];
    
    // 显示同步进度
    [self.synProgsView setStrokeEnd:0.8 animated:NO];
    
    // 停止同步动画
    [self stopSynAnimation:self.synCircleIcon.layer];
    
    // 弹出设备切换视图
    
}

// 同步正在进行中的旋转动画
- (void)synIconCircleAnimation {
    
    CABasicAnimation *synAnimation = [CABasicAnimation animation];
    synAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    synAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    synAnimation.duration = 1.2f;
    synAnimation.repeatCount = MAXFLOAT;
    [self.synCircleIcon.layer addAnimation:synAnimation forKey:@"synAnimation"];
}

#pragma mark - 状态栏左右摇晃动画
- (void)statusShakeAnimation {

    // 晃动次数
    NSInteger numberOfShakes = 2;
    // 晃动幅度(相对于总宽度而言)
    CGFloat ranggeOfShake = 0.05f;
    // 摇晃延续时长(s)
    CGFloat durationOfShake = 0.65f;
    
    
    // 获取关键点
    CGPoint layerPosition = self.synStatusText.layer.position;
    // 起始点
    NSValue *startValue = [NSValue valueWithCGPoint:layerPosition];
    // 关键点数组
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:startValue, nil];
    for (int i = 0; i < numberOfShakes; i++) {
        // 设置左右摇晃的点
        NSValue *leftValue = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x-self.synStatusText.frame.size.width*ranggeOfShake*(1-(float)i/numberOfShakes), layerPosition.y)];
        NSValue *rightValue = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x+self.synStatusText.frame.size.width*ranggeOfShake*(1-(float)i/numberOfShakes), layerPosition.y)];
        // 加入到values数组中
        [values addObject:leftValue];
        [values addObject:rightValue];
    }
    // 最后回归到起始点
    [values addObject:startValue];
    
    
    // 创建关键帧动画
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animation];
    // 设置关键帧路径
    shakeAnimation.keyPath = @"position";
    // 设置关键帧动画的 values 变化数组
    shakeAnimation.values = values;
    shakeAnimation.duration = durationOfShake;
    
    //将动画添加到控件layer上
    [self.synStatusText.layer addAnimation:shakeAnimation forKey:kCATransition];
}

#pragma mark - 动画的控制
// 暂停正在进行中的动画
- (void)pauseSynAnimation:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

// 恢复正在进行中的动画
- (void)resumeSynAnimation:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

// 停止正在进行中的动画
- (void)stopSynAnimation:(CALayer *)layer {
    
    [layer removeAllAnimations];
}

#pragma mark - Getter
// 头像
- (UIButton *)headBtn {
    if (!_headBtn) {
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(10, CGRectGetHeight(self.bounds)/2-32/2, 32, 32);
        _headBtn.layer.borderColor = RGBA(255, 255, 255, 0.8).CGColor;
        _headBtn.layer.borderWidth = 1.f;
        
        _headBtn.layer.cornerRadius  = 32/2;
        _headBtn.layer.masksToBounds = YES;
        
        [_headBtn setImage:Image(@"familyBoy") forState:UIControlStateNormal];
        [_headBtn addTarget:self action:@selector(switchUser:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headBtn;
}

// 同步进度条
- (CircleProgressView *)synProgsView {
    if (!_synProgsView) {
        CGRect frame = CGRectMake(self.headBtn.right+10, self.headBtn.top, 32, 32);
        _synProgsView = [CircleProgressView circleProgressViewWithFrame:frame
                                                              lineWidth:1.f
                                                              lineColor:RGB(255, 255, 255)
                                                              clockWise:YES
                                                             startAngle:1.5*M_PI];
        _synProgsView.isNeedBackground = YES;
        _synProgsView.bgLineWidth      = 1.f;
        _synProgsView.bgLineColor      = RGBA(255, 255, 255, 0.2);
        [_synProgsView makeConfigEffective];
    }
    return _synProgsView;
}

// 产品图片
- (UIImageView *)productIcon {
    if (!_productIcon) {
        CGRect frame = CGRectMake(self.headBtn.right+10, self.headBtn.top, 32, 32);
        _productIcon = [[UIImageView alloc] initWithFrame:frame];
        _productIcon.image = Image(@"");
    }
    return _productIcon;
}

// 同步中循环动画的icon
- (UIImageView *)synCircleIcon {
    if (!_synCircleIcon) {
        _synCircleIcon = [[UIImageView alloc] initWithFrame:self.productIcon.frame];
        _synCircleIcon.image = Image(@"sb_home_syn_icon");
    }
    return _synCircleIcon;
}

// 未连接icon
- (UIImageView *)unConneIcon {
    if (!_unConneIcon) {
        _unConneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.synProgsView.right-11, self.synProgsView.bottom-11, 11, 11)];
        _unConneIcon.image = Image(@"sb_home_unconnect");
    }
    return _unConneIcon;
}

// 同步状态文案
- (UILabel *)synStatusText {
    if (!_synStatusText) {
        _synStatusText = [[UILabel alloc] initWithFrame:CGRectMake(self.synProgsView.right, self.top, self.width-32*2-20, self.height)];
        [_synStatusText setLabelText:@"            Bluetooth Is Off"
                                font:[UIFont boldSystemFontOfSize:16]
                           textColor:[UIColor whiteColor]
                       textAlignment:NSTextAlignmentLeft];
        //        _synStatusText.hidden = YES;
    }
    return _synStatusText;
}

// 电池电量状态
- (UIView *)batteryStatusView {
    if (!_batteryStatusView) {
        _batteryStatusView = [[UIView alloc] initWithFrame:CGRectMake(self.synProgsView.right, 13, 17, 17)];
        _batteryStatusView.hidden = NO;
    }
    return _batteryStatusView;
}

- (UIImageView *)batteryIcon {
    if (!_batteryIcon) {
        _batteryIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
        _batteryIcon.image = Image(@"sb_home_battery_icon");
    }
    return _batteryIcon;
}

- (UILabel *)batteryStatus {
    if (!_batteryStatus) {
        _batteryStatus = [[UILabel alloc] initWithFrame:CGRectMake(self.batteryIcon.left+6, self.batteryIcon.bottom-2.5-11, 5, 11)];
        _batteryStatus.backgroundColor = [UIColor whiteColor];
    }
    return _batteryStatus;
}

// 同步成功View
- (UIView *)synSuccessView {
    if (!_synSuccessView) {
        
        _synSuccessView = [[UIView alloc] initWithFrame:CGRectMake(self.synProgsView.right, self.synProgsView.top, 100, self.synProgsView.height)];
        _synSuccessView.backgroundColor = [UIColor clearColor];
        
        _synSuccessView.hidden = YES;
    }
    return _synSuccessView;
}

- (UIImageView *)successIcon {
    if (!_successIcon) {
        _successIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, _synSuccessView.height/2-17/2, 17, 17)];
        _successIcon.image = Image(@"sb_home_syn_success");
    }
    return _successIcon;
}

- (UILabel *)successText {
    if (!_successText) {
        _successText = [[UILabel alloc] initWithFrame:CGRectMake(_successIcon.right+4, 0, _synSuccessView.width-17, _synSuccessView.height)];
        [_successText setLabelText:@"Synced"
                              font:Font(14.f)
                         textColor:[UIColor whiteColor]
                     textAlignment:NSTextAlignmentLeft];
    }
    return _successText;
}

@end
