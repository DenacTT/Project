//
//  Note.h
//  HBProject
//
//  Created by HarbingWang on 16/9/3.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

// 项目架构说明
HBProject
    // 主目录
    |- Main
            |- Appdelegate
            |- Discover       // 发现
                    |- Model
                    |- View
                    |- Controller
            |- Follow           // 关注
                    |- Model
                    |- View
                    |- Controller
            |- FriendCircle // 朋友圈
                    |- Model
                    |- View
                    |- Controller
            |- Mine             // 我的
                    |- Model
                    |- View
                    |- Controller

            |- General        // 这个目录放一些会被重用的Views/Classes
                    |- Views
                            |- BaseViewView
                            ...
                    |- Classes
                            |- BaseViewController
                            ...
            |- Other            // 其他
                    |- Login    // 登录
                    |- Setting  // 设置
                    |- Helpers // 帮助类
            ...

    |- Expand
            |- Category     // 分类
            |- Const           // 常量
            |- DataBase    // 数据库
            |- Macro          // 宏文件
                    |- AppMacro.h               // App 相关的宏定义
                    |- NotificationMacro.h
                    |- VendorMacro.h
                    |- UtilsMacro.h
            |- Network       // 网络相关
            |- Tool              // 工具类
            ...

    |- Resource // 资源库
            |- Images   // 图片资源
            |- Plist        //  plist 文件
            ...
    |- Vender // 第三方





@end
