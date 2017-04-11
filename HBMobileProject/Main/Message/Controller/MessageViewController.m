//
//  MessageViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "MessageViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <ImageIO/ImageIO.h>

@interface MessageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVC;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"消息";
    self.isUseRightBtn = YES;
    [self.rightBtn setTitle:@"读取" forState:UIControlStateNormal];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, ScreenWidth, ScreenHeight-200)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_imageView];
}

- (void)clickRightBtn {
    
    self.imagePickerVC = [[UIImagePickerController alloc] init];
    self.imagePickerVC.delegate = self;
    [self presentViewController:_imagePickerVC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    [self dismissViewControllerAnimated:YES completion:nil];
    self.imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    /**
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x174289b00> size {750, 1334} orientation 0 scale 1.000000";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.PNG?id=62F615A2-3650-4334-8F77-42375A7AE4F7&ext=PNG";
     */
    NSString *urlStr = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    [self getExifInfoWithImageData:[NSData dataWithContentsOfFile:urlStr]];
}

- (NSMutableDictionary *)getExifInfoWithImageData:(NSData *)imageData{
    CGImageSourceRef cImageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    NSDictionary *dict =  (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(cImageSource, 0, NULL));
    NSMutableDictionary *dictInfo = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSLog(@"ExifInfo: %@", dictInfo);
    return dictInfo;
}

@end
