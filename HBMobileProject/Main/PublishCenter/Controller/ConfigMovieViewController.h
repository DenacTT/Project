//
//  ConfigMovieViewController.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigMovieViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *mainDuration;                // 最小时长
@property (weak, nonatomic) IBOutlet UITextField *maxDuration;                 // 最大时长
@property (weak, nonatomic) IBOutlet UITextField *bitRate;                           // 视频码率
@property (weak, nonatomic) IBOutlet UITextField *photoQuality;                  // 第一帧图片质量

/* 可选参数 */
@property (weak, nonatomic) IBOutlet UISwitch *enableWaterMask;            // 是否开启水印
@property (weak, nonatomic) IBOutlet UISwitch *enableMoreMusic;             // 是否开启更多音乐功能
@property (weak, nonatomic) IBOutlet UISwitch *enableEditVideo;                // 是否支持编辑视频
@property (weak, nonatomic) IBOutlet UISwitch *enableImportVideo;            // 是否开启导入本地视频的功能
@property (weak, nonatomic) IBOutlet UISwitch *enableBeautyFunction;      // 是否支持美颜功能
@property (weak, nonatomic) IBOutlet UISwitch *enableFrontCamera;          // 是否支持开启前置摄像头

// TintColor
@property (weak, nonatomic) IBOutlet UISlider *colorR;
@property (weak, nonatomic) IBOutlet UISlider *colorG;
@property (weak, nonatomic) IBOutlet UISlider *colorB;

@end
