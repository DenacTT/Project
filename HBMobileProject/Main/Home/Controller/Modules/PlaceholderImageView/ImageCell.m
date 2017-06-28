//
//  ImageCell.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/6/27.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.placeholderImageView = [PlaceholderImageView placeholderImageViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/2) placeholderImage:[UIImage imageNamed:@"loading"]];
        self.placeholderImageView.placeholderImage = [UIImage imageNamed:@"loading"];
        [self addSubview:self.placeholderImageView];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
