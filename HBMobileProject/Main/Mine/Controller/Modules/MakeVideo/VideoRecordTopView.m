//
//  VideoRecordTopView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/27.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "VideoRecordTopView.h"
#import "DelayView.h"

@implementation VideoRecordTopView
{
    UIButton    *_cameraBtn;
    UIView      *_delaySelectView;
    DelayView   *_delayView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _delayView = [[DelayView alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
        [self addSubview:_delayView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget: self action:@selector(onDelay:)];
        [_delayView addGestureRecognizer: tap];
        
        _delaySelectView = [[UIView alloc] initWithFrame:CGRectZero];
        _delaySelectView.width = 196;
        _delaySelectView.height = self.height;
        _delaySelectView.left = (self.width - _delaySelectView.width) / 2;
        [self addSubview:_delaySelectView];
        
        _delaySelectView.hidden = YES;
        
        CGFloat space = (_delaySelectView.width - 3*44) / 2;
        // 关闭按钮
        UIButton * closeBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [_delaySelectView addSubview: closeBtn];
        closeBtn.tag = 10000;
        [closeBtn setTitle: STR(@"MWV_close") forState: UIControlStateNormal];
        [closeBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [closeBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
        [closeBtn addTarget: self action: @selector(onClose:) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.frame = CGRectMake(0, 0, 44, 44);
        closeBtn.titleLabel.font = [UIFont systemFontOfSize: 13.f];
        //3秒
        UIButton * threeBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [_delaySelectView addSubview: threeBtn];
        threeBtn.tag = 10001;
        [threeBtn setTitle: STR(@"SecondThree") forState: UIControlStateNormal];
        [threeBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [threeBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
        [threeBtn addTarget: self action: @selector(onClose:) forControlEvents:UIControlEventTouchUpInside];
        threeBtn.frame = CGRectMake(closeBtn.right + space, 0, 44, 44);
        threeBtn.titleLabel.font = [UIFont systemFontOfSize: 13.f];
        //10秒
        UIButton * tenBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [_delaySelectView addSubview: tenBtn];
        tenBtn.tag = 10002;
        [tenBtn setTitle: STR(@"SecondTen") forState: UIControlStateNormal];
        [tenBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [tenBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
        [tenBtn addTarget: self action: @selector(onClose:) forControlEvents:UIControlEventTouchUpInside];
        tenBtn.frame = CGRectMake(threeBtn.right + space, 0, 44, 44);
        tenBtn.titleLabel.font = [UIFont systemFontOfSize: 13.f];
        
//        _cameraBtn = [UIButton buttonWithType: UIButtonTypeCustom];
////        [self addSubview: _cameraBtn];
//        [_cameraBtn setImage: [UIImage imageNamed: @"CameraChange"] forState: UIControlStateNormal];
//        [_cameraBtn setImage: [UIImage imageNamed: @"CameraChange"] forState: UIControlStateHighlighted];
//        _cameraBtn.frame = CGRectMake(ScreenWidth - 44, 0, 44, 44);
//        [_cameraBtn addTarget: self action: @selector(onCameraChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - UIButton
- (void)onDelay:(UITapGestureRecognizer *)sender
{
    if ([self.captureMovieFileOutput isRecording]) {//视频正在录制情况按钮禁用
        return;
    }
    _delaySelectView.hidden = NO;
    _cameraBtn.hidden = YES;
}
- (void)onCameraChange:(UIButton *)sender
{
    if ([self.captureMovieFileOutput isRecording]) {//视频正在录制情况按钮禁用
        return;
    }
}

- (void)onClose:(UIButton *)sender
{
    _delaySelectView.hidden = YES;
    _cameraBtn.hidden = NO;
    switch (sender.tag) {
        case 10000:
        {
            _delayView.delaySeconds = 0;
        }
            break;
        case 10001:
        {
            _delayView.delaySeconds = 3;
        }
            break;
        case 10002:
        {
            _delayView.delaySeconds = 10;
        }
            break;
        default:
            break;
    }
}

#pragma mark - getDelaySecond
- (NSInteger)getDelaySecond
{
    if (_delayView.delaySeconds == 0) {
        return _delayView.delaySeconds;
    }
    return (_delayView.delaySeconds + 1);
}


@end
