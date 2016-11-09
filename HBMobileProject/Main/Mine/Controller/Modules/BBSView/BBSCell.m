//
//  BBSCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "BBSCell.h"
#import "BBSCellTopView.h"

@interface BBSCell ()

@property (nonatomic, strong) BBSCellTopView *topView;

@end

@implementation BBSCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.topView];
    }
    return self;
}

- (BBSCellTopView *)topView
{
    if (!_topView) {
        _topView = [[BBSCellTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 54.5)];
    }
    return _topView;
}

@end
