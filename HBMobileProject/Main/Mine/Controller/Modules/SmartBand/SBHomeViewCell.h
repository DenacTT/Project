//
//  SBHomeViewCell.h
//  scale
//
//  Created by HarbingWang on 17/3/28.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBHomeModel.h"

@interface SBHomeViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;//背景图片
@property (nonatomic, strong) UILabel *mainText;//主要信息
@property (nonatomic, strong) UILabel *subText; //次要信息

- (void)setValue:(SBHomeModel *)model;

@end
