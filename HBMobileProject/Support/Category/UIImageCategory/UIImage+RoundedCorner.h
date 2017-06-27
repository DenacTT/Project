//
//  UIImage+RoundedCorner.h
//  scale
//
//  Created by HarbingWang on 16/2/23.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedCorner)

/**
 *  @author HarbingWang, 16-09-09 10:09:36
 *
 *  为图片切圆角
 *  避免在大量cell离屏渲染的时候拖慢fps
 *
 */
-(UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius;

@end
