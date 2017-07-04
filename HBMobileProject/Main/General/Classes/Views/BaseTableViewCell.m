//
//  BaseTableViewCell.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/6/29.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupCell];
        [self setupSubView];
    }
    return self;
}

- (void)setupCell {}

- (void)setupSubView {}

- (void)loadContent {}

@end
