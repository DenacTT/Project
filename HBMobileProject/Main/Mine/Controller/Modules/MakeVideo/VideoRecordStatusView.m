//
//  VideoRecordStatusView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/28.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "VideoRecordStatusView.h"
#import "CircularSlider.h"

@interface VideoRecordStatusView ()

@property (atomic, assign) YMRecordType recordType;

@end

@implementation VideoRecordStatusView
{
    CircularSlider *_slider;    //进度圆动画
    UIView *_circleView;        //中间的圆
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        _slider = [[CircularSlider alloc]initWithRadius: 66];
        [self addSubview: _slider];
        
        _circleView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, 60, 60)];
        [self addSubview: _circleView];
        [self setType: YMRecordType_RecordVideo];
    }
    return self;
}
- (void)returnCircularStroke
{
    [_slider returnCircularStroke];
}
- (void)strokeEndNumberChange
{
    [_slider strokeEndNumberChange];
}
- (void)setType:(YMRecordType)type
{
    switch (type) {
        case YMRecordType_RecordVideo:
        {
            _circleView.width = 50;
            _circleView.height = 50;
            _circleView.layer.cornerRadius = _circleView.width/2;
            _circleView.backgroundColor = [UIColor redColor];
            
        }
            self.recordType = YMRecordType_RecordVideo;
            break;
        case YMRecordType_StopDelay:
        {
            _circleView.width = 28;
            _circleView.height = 28;
            _circleView.layer.cornerRadius = 8;
            _circleView.backgroundColor = [UIColor whiteColor];
        }
            self.recordType = YMRecordType_StopDelay;
            break;
        case YMRecordType_StopRecord:
        {
            _circleView.width = 28;
            _circleView.height = 28;
            _circleView.layer.cornerRadius = 8;
            _circleView.backgroundColor = [UIColor redColor];
        }
            self.recordType = YMRecordType_StopRecord;
            break;
            
        default:
            break;
    }
    _circleView.center = _slider.center;
}

@end
