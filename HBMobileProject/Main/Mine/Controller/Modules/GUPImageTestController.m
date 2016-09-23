//
//  GUPImageTestController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/23.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "GUPImageTestController.h"

@interface GUPImageTestController ()

@end

@implementation GUPImageTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *inputImage = [UIImage imageNamed:@"test"];
    
    // 获取图像源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    
    /* 褐色（怀旧）滤镜 */
//    GPUImageSepiaFilter *stillImageFilter = [[GPUImageSepiaFilter alloc] init];
//    [stillImageSource addTarget:stillImageFilter];
//    [stillImageFilter useNextFrameForImageCapture];
//    [stillImageSource processImage];
    
    /* 晕影，形成黑色边缘，突出中间图像的效果 */
    GPUImageVignetteFilter *disFilter = [[GPUImageVignetteFilter alloc] init];
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:inputImage.size];
    [disFilter useNextFrameForImageCapture];
    
    //添加滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片并加载到 View
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.frame = CGRectMake(0, 0, newImage.size.width, newImage.size.height);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
