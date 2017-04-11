//
//  SBHeadStatusView.h
//  HBMobileProject
//
//  Created by whb on 2017/4/5.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SynStatusBleIsOff,  //蓝牙未开启
    SynStatusBleIsOn,   //蓝牙已开启
    SynStatusBandIsOff, //手环未开启
    SynStatusBandIsOn,  //手环已开启
    
    SynStatusTimeOut,   //连接超时了
    SynStatusUnConnect, //未连接设备
    
    SynStatusSynStart,  //开始下拉同步
    SynStatusSyning,    //数据同步中
    SynStatusSynSucced, //数据同步成功
    SynStatusSynFailed, //数据同步失败
} SynStatus;

static NSString * const BluetoothIsOff  = @"           Bluetooth Is Off";
static NSString * const NotConnected    = @"           Not Connected";
static NSString * const Syning          = @"Syncing...";
static NSString * const Synced          = @"Synced";
static NSString * const PullToSync      = @"Pull to Sync";
static NSString * const ReleaseToSync   = @"Release to Sync";

@protocol SBHeadStatusViewDelegate <NSObject>

- (void)userBtnClicked;
- (void)runBtnClicked;

@end

@interface SBHeadStatusView : UIView

@property (nonatomic, strong) UILabel   *synText; //状态文案
@property (nonatomic, assign) SynStatus synStatus;//同步状态

@property (nonatomic, weak) id<SBHeadStatusViewDelegate>delegate;

- (void)setSynStatus:(SynStatus)synStatus;
- (void)setSynProgress:(CGFloat)progress;

@end
