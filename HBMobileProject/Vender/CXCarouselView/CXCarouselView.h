//
//  CXCarouselView.h
//  pregnant-information
//
//  Created by 王长旭 on 16/2/25.
//  Copyright © 2016年 sw. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DeviceWidth     [UIScreen mainScreen].bounds.size.width
#define DeviceHeight    [UIScreen mainScreen].bounds.size.height

@protocol CXCarouseViewDelegate;
@interface CXCarouselView : UIView

@property (weak, nonatomic) id<CXCarouseViewDelegate> delegate;

+(instancetype)initWithFrame:(CGRect)frame hasTimer:(BOOL) hastimer interval:(NSUInteger) inter placeHolder:(UIImage*) image;

-(void) setupWithArray:(NSArray *)array;

@end

@protocol CXCarouseViewDelegate <NSObject>

- (void) carouselTouch:(CXCarouselView*)carousel atIndex:(NSUInteger)index;

@end
