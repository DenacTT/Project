//
//  UploadMovieCell.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/8.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UploadMovieDelegate <NSObject>

- (void)downloadMovie:(UITableViewCell *)cell;

@end

@interface UploadMovieCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *filePathLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIButton *downloadBtn;
@property (nonatomic, strong) CuttingLine *cuttingLine;

@property (nonatomic, assign) id<UploadMovieDelegate> delegate;
@property (nonatomic, strong) QPUploadTask *uploadTask;

@end
