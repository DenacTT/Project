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

//获取设备的宽高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

// String字符串
#define STR(key)            NSLocalizedString(key, nil)

//字体
#define Font(fontSize)         [UIFont systemFontOfSize:fontSize]

//图片
#define Image(imageName)       [UIImage imageNamed:imageName]

// Color
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/* --------------  DEBUG  模式下打印日志,当前行  -----------*/
#define NSLog(format, ...) do {                                                                                                         \
fprintf(stderr, "<%s : %d> %s\n",                                                                                                      \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],                     \
__LINE__, __func__);                                                                                                                       \
(NSLog)((format), ##__VA_ARGS__);                                                                                            \
fprintf(stderr, "------------------------------------------------------\n");        \
} while (0)

#endif /* CommonMacro_h */
