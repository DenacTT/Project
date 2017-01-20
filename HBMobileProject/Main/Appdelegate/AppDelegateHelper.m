//
//  AppDelegateHelper.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/22.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "AppDelegateHelper.h"

@implementation AppDelegateHelper

/**
 *  @brief  趣拍初始设置
 */
- (void)qupaiSDKSetup
{
    // space 是上传视频时为每一个用户创建的文件夹名，建议设置为用户的uuid（最大支持32位，如获取的uuid大于32位请自行处理）。例如：A用户的uuid是110001，在paas平台的空间中为A用户生成一个110001的文件夹存放A用户上传的内容。
    // 注册成功后就取得了对指定文件夹的上传权限，并取得 accessToken
    
//    NSString *userId = 0;
//    if (userId == 0) {
//        userId = @"99999999";
//    }
    
//    [[QPAuth shared] registerAppWithKey:kQPAppKey secret:kQPAppSecret space:userId success:^(NSString *accessToken) {
//        NSLog(@"qupai regist success! accessToken : %@", accessToken);
        
//    } failure:^(NSError *error) {
//        NSLog(@"qupai regist failed! reason: %@", error.description);
//    }];
    
    /*
     常见错误码
     1101 Host（请求的域名） 未授权， 通常都是域名地址错误导致
     1102 appSecret不正确
     1103 bundleId不正确
     1104 包名和签名为空
     1105 包名或签名不正确
     1106 存储空间里的目录不正确
     1107 AppKey不正确
     */
}

@end
