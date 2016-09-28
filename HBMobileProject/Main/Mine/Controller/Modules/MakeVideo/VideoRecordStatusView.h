//
//  VideoRecordStatusView.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/28.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YMRecordType) {
    YMRecordType_RecordVideo = 1110001, //录制视频
    YMRecordType_StopDelay = 1110002,   //停止倒计时
    YMRecordType_StopRecord = 1110003,  //结束录制
};

@interface VideoRecordStatusView : UIView

- (void)strokeEndNumberChange;  //开始圆周运动
- (void)returnCircularStroke;   //还原
- (void)setType:(YMRecordType)type;

@end
