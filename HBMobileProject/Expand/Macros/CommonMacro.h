//
//  CommonMacro.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

// AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]

// MainScreen bounds
#define Main_Screen_Bounds [[UIScreen mainScreen] bounds]

// 获取设备的宽高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

// String字符串
#define STR(key) NSLocalizedString(key, nil)

// 字体
#define Font(fontSize) [UIFont systemFontOfSize:fontSize]

// 图片
#define Image(imageName) [UIImage imageNamed:imageName]

//字符串转URL
#define UrlStr(str)            [NSURL URLWithString:str]

// Color
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RandomNumber (arc4random() % 501) + 500

typedef NS_ENUM(NSInteger, OrderStatus) {
    OrderStatusWaitPay = 1,     // 待支付
    OrderStatusWaitRec = 2,     // 待收货
    OrderStatusHaveRec = 3,     // 已收货
    OrderStatusHaveCel = 4,     // 已取消
};

//typedef enum : NSInteger {
//    OrderStatusWaitPay = 1,     // 待支付
//    OrderStatusWaitRec = 2,     // 待收货
//    OrderStatusHaveRec = 3,     // 已收货
//    OrderStatusHaveCel = 4,     // 已取消
//}OrderStatus;


// 当前是否debug模式
#ifdef DEBUG
#  define isDebug 1
#else
#  define isDebug 0
#endif

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content: %s", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* CommonMacro_h */
