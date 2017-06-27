//
//  SBHeadStatusView.m
//  HBMobileProject
//
//  Created by whb on 2017/4/5.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBHeadStatusView.h"
#import "CircleProgressView.h"

#define AniDuration 0.5f//动画执行时间
#define AniDelay 5.f    //动画延迟时间

@interface SBHeadStatusView ()<CAAnimationDelegate>

@property (nonatomic, strong) UIButton *headBtn; //头像按钮

@property (nonatomic, strong) CircleProgressView *synProgsView;//同步进度条
@property (nonatomic, strong) UIImageView *synCircIcon; //同步进行中的icon
@property (nonatomic, strong) UIImageView *productIcon; //产品图片
@property (nonatomic, strong) UIImageView *unConneIcon; //未连接状态icon

@property (nonatomic, strong) UIView *batteryStatus;    //电池状态
@property (nonatomic, strong) UIImageView *batteryIcon; //电池icon
@property (nonatomic, strong) UILabel *batteryLevel;    //剩余电量

@property (nonatomic, strong) UIView *synSuccessView;   //同步完成
@property (nonatomic, strong) UIImageView *successIcon; //同步成功icon
@property (nonatomic, strong) UILabel *successText;     //同步成功文案

@property (nonatomic, strong) UIButton *runButton; //进入奔跑模式Btn

@end

@implementation SBHeadStatusView
{
    CABasicAnimation *synAnimation;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.headBtn];
        
        [self addSubview:self.synProgsView];
        [self addSubview:self.productIcon];
        [self addSubview:self.synCircIcon];
        [self addSubview:self.unConneIcon];
        
        [self addSubview:self.batteryStatus];
        [self.batteryStatus addSubview:self.batteryIcon];
        [self.batteryStatus addSubview:self.batteryLevel];
        
        [self addSubview:self.synText];
        [self addSubview:self.synSuccessView];
        [self.synSuccessView addSubview:self.successIcon];
        [self.synSuccessView addSubview:self.successText];
        
        [self addSubview:self.runButton];
    }
    return self;
}

#pragma mark - Setter
- (void)setSynStatus:(SynStatus)synStatus {
    _synStatus = synStatus;
    
    switch (synStatus) {
        case SynStatusBleIsOff://蓝牙未开启
            [self synStatusChangeToBleOff];
            break;
        case SynStatusBandIsOff://手环离线
            
            break;
            
        case SynStatusUnConnect://未连接成功
            [self synStatusChangeToUnConnect];
            break;
        case SynStatusSynStart://开始同步
            [self synStatusChangeToSynStart];
            break;
        case SynStatusSyning://同步进行中
            [self synStatusChangeToSyning];
            break;
        case SynStatusSynSucced://同步成功
            [self synStatusChangeToSynSucceed];
            break;
        case SynStatusSynFailed://同步失败
            break;
        default:
            break;
    }
}

- (void)setSynProgress:(CGFloat)progress {
    if (progress > 0 && progress < 1) {
        // 显示同步进度
        [self.synProgsView setStrokeEnd:progress animated:NO];
    }
}

#pragma mark - Private Method
// 点击头像切换
- (void)switchUser:(UIButton *)sender {

    // 电池状态显示
    CGFloat batteryPercent = 0.6f;
    CGRect frame = CGRectMake(self.batteryIcon.left+6, self.batteryIcon.bottom-2.5-11*batteryPercent, 5, 11 * batteryPercent);
    self.batteryLevel.frame = frame;
    
    // 弹出设备切换视图
    if ([self.delegate respondsToSelector:@selector(userBtnClicked)]) {
        [self.delegate userBtnClicked];
    }
}

// 跑步模式点击
- (void)runButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(runBtnClicked)]) {
        [self.delegate runBtnClicked];
    }
}

// 同步正在进行中的旋转动画
- (void)synIconCircleAnimation {
    
    synAnimation = [CABasicAnimation animation];
    synAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    synAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    synAnimation.duration = 1.2f;
    synAnimation.repeatCount = MAXFLOAT;
    //    synAnimation.delegate = self;
    //    synAnimation.removedOnCompletion = NO;
    //    synAnimation.fillMode = kCAFillModeForwards;
    //    synAnimation.autoreverses = NO;
    //    synAnimation.additive = YES;//在原来的基础上添加动画
    synAnimation.timeOffset = 0.0f;
    [self.synCircIcon.layer addAnimation:synAnimation forKey:@"synAnimation"];
}

//暂停动画.保存当前位置和时间
- (void)pauseSynAnimation
{
    CFTimeInterval pausedTime = [self.synCircIcon.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.synCircIcon.layer.timeOffset = pausedTime;
}
//恢复动画
- (void)resumeSynLayer
{
    [self.synCircIcon.layer removeAllAnimations];
    synAnimation.timeOffset = [self.synCircIcon.layer convertTime:CACurrentMediaTime() fromLayer:nil] - self.synCircIcon.layer.timeOffset;
    [self.synCircIcon.layer addAnimation:synAnimation forKey:nil];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

#pragma mark - 同步状态切换
// 切换至蓝牙未开启
- (void) synStatusChangeToBleOff{
    self.productIcon.hidden = NO;
    self.unConneIcon.hidden = NO;
    self.batteryStatus.hidden = YES;
    self.synText.text = BluetoothIsOff;
    [self statusShakeAnimation];
}

// 切换至未连接状态
- (void)synStatusChangeToUnConnect {
    
    self.productIcon.hidden = NO;
    self.unConneIcon.hidden = NO;
    self.synText.text = NotConnected;
    self.batteryStatus.hidden = YES;
    [self statusShakeAnimation];
    
    self.productIcon.alpha = 0.f;
    self.unConneIcon.alpha = 0.f;
    self.synCircIcon.alpha = 1.f;

    
    
    
    [UIView animateWithDuration:AniDuration animations:^{
        self.productIcon.alpha = 1.f;
        self.unConneIcon.alpha = 1.f;
        self.synCircIcon.alpha = 0.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:AniDuration delay:AniDelay options:UIViewAnimationOptionCurveLinear animations:^{
            self.synText.alpha = 0.f;
        } completion:^(BOOL finished) {
        }];
    }];
}

// 状态切换至开始同步
- (void)synStatusChangeToSynStart {
    
    // 停掉所有还在进行中的动画
    [self stopSynAnimation:self.layer];
    if ([self.synText.text isEqualToString:ReleaseToSync]) {
        self.synText.hidden = NO;
        self.synText.alpha = 1.f;
    }
    if ([self.synText.text isEqualToString:PullToSync]) {
        //停止掉当前正在进行的动画
        [self stopSynAnimation:self.synCircIcon.layer];
    }
    
    self.synText.hidden = NO;
    self.batteryStatus.hidden = YES;
    
    self.productIcon.alpha = 1.f;
    self.batteryStatus.alpha = 1.f;
    self.synText.alpha = 0.f;
    self.synCircIcon.alpha = 0.f;
    
    [UIView animateWithDuration:AniDuration animations:^{
        
        self.productIcon.alpha = 0.f;
        self.batteryStatus.alpha = 0.f;
        self.synText.alpha = 1.f;
        self.synCircIcon.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        self.synCircIcon.hidden = NO;
        self.batteryStatus.hidden = YES;
        self.productIcon.hidden = YES;
    }];
    
}

// 状态切换至同步中
- (void)synStatusChangeToSyning {
    
    self.synCircIcon.hidden = NO;
    self.synProgsView.hidden = NO;
    self.batteryStatus.hidden = YES;
    
    self.productIcon.alpha = 1.f;
    self.unConneIcon.alpha = 1.f;
    self.synCircIcon.alpha = 0.f;
    self.synText.alpha     = 0.f;
    
    [UIView animateWithDuration:AniDuration animations:^{
        self.productIcon.alpha = 0.f;
        self.unConneIcon.alpha = 0.f;
        self.synCircIcon.alpha = 1.f;
        self.synText.alpha     = 1.f;
        self.synText.text      = Syning;
        
    } completion:^(BOOL finished) {
        
        self.productIcon.hidden = YES;
        self.unConneIcon.hidden = YES;
        [self synIconCircleAnimation];
    }];
}

// 状态切换至同步成功
- (void)synStatusChangeToSynSucceed {
    
    self.synCircIcon.hidden  = NO;
    self.synProgsView.hidden = NO;
    self.synText.hidden = NO;
    self.batteryStatus.hidden = YES;
    self.synSuccessView.hidden = NO;
    self.synText.text = Syning;
    
    self.synText.alpha = 1.f;
    self.productIcon.alpha = 0.f;
    self.synCircIcon.alpha = 1.f;
    self.synSuccessView.alpha = 0.f;
    self.batteryStatus.alpha  = 0.f;
    
    [UIView animateWithDuration:AniDuration animations:^{
        
        self.productIcon.alpha = 1.f;
        self.synCircIcon.alpha = 0.f;
        self.synSuccessView.alpha = 1.f;
        self.synText.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.synText.hidden = YES;
        self.synCircIcon.hidden = YES;
        self.synProgsView.hidden= NO;
        self.productIcon.hidden = NO;
        self.unConneIcon.hidden = YES;
        self.batteryStatus.hidden = NO;
        self.batteryStatus.alpha  = 0.f;
        
        [UIView animateWithDuration:AniDuration delay:AniDelay options:UIViewAnimationOptionCurveLinear animations:^{
            self.synSuccessView.alpha = 0.f;
            self.batteryStatus.alpha = 1.f;
        } completion:^(BOOL finished) {
            self.synSuccessView.hidden = YES;
            self.batteryStatus.hidden  = NO;
        }];
    }];
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
    CGPoint layerPosition = self.synText.layer.position;
    // 起始点
    NSValue *startValue = [NSValue valueWithCGPoint:layerPosition];
    // 关键点数组
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:startValue, nil];
    for (int i = 0; i < numberOfShakes; i++) {
        // 设置左右摇晃的点
        NSValue *leftValue = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x-self.synText.frame.size.width*ranggeOfShake*(1-(float)i/numberOfShakes), layerPosition.y)];
        NSValue *rightValue = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x+self.synText.frame.size.width*ranggeOfShake*(1-(float)i/numberOfShakes), layerPosition.y)];
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
    [self.synText.layer addAnimation:shakeAnimation forKey:kCATransition];
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

// 移除正在进行中的动画
- (void)stopSynAnimation:(CALayer *)layer {
    
    [layer removeAllAnimations];
}

#pragma mark - Getter
// 头像
- (UIButton *)headBtn {
    if (!_headBtn) {
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(8, CGRectGetHeight(self.bounds)/2-32/2, 32, 32);
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
        _productIcon.image = Image(@"sb_home_band");
    }
    return _productIcon;
}

// 同步中循环动画的icon
- (UIImageView *)synCircIcon {
    if (!_synCircIcon) {
        _synCircIcon = [[UIImageView alloc] initWithFrame:self.productIcon.frame];
        _synCircIcon.image = Image(@"sb_home_syn_icon");
        _synCircIcon.hidden = YES;
    }
    return _synCircIcon;
}

// 未连接icon
- (UIImageView *)unConneIcon {
    if (!_unConneIcon) {
        _unConneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.synProgsView.right-11, self.synProgsView.bottom-11, 11, 11)];
        _unConneIcon.image = Image(@"sb_home_unconnect");
        _unConneIcon.hidden = YES;
    }
    return _unConneIcon;
}

// 同步状态文案
- (UILabel *)synText {
    if (!_synText) {
        _synText = [[UILabel alloc] initWithFrame:CGRectMake(self.synProgsView.right+5, self.top, self.width-32*2-20, self.height)];
        [_synText setLabelText:@""
                                font:[UIFont boldSystemFontOfSize:16]
                           textColor:[UIColor whiteColor]
                       textAlignment:NSTextAlignmentLeft];
    }
    return _synText;
}

// 电池电量状态
- (UIView *)batteryStatus {
    if (!_batteryStatus) {
        _batteryStatus = [[UIView alloc] initWithFrame:CGRectMake(self.synProgsView.right, 13, 17, 17)];
        _batteryStatus.hidden = NO;
    }
    return _batteryStatus;
}

- (UIImageView *)batteryIcon {
    if (!_batteryIcon) {
        _batteryIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
        _batteryIcon.image = Image(@"sb_home_battery_icon");
    }
    return _batteryIcon;
}

- (UILabel *)batteryLevel {
    if (!_batteryLevel) {
        _batteryLevel = [[UILabel alloc] initWithFrame:CGRectMake(self.batteryIcon.left+6, self.batteryIcon.bottom-2.5-11, 5, 11)];
        _batteryLevel.backgroundColor = [UIColor whiteColor];
    }
    return _batteryLevel;
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

- (UIButton *)runButton {
    if (!_runButton) {
        _runButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _runButton.frame = CGRectMake(ScreenWidth-32-15, CGRectGetHeight(self.bounds)/2-32/2, 32, 32);
        _runButton.backgroundColor = [UIColor clearColor];
        [_runButton setImage:Image(@"sb_home_run_icon") forState:UIControlStateNormal];
        [_runButton setImage:Image(@"sb_home_run_icon") forState:UIControlStateSelected];
        
        [_runButton addTarget:self action:@selector(runButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _runButton;
}

@end
