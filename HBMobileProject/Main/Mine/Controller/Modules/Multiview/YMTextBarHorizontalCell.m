//
//  YMTextBarHorizontalCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/2.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "YMTextBarHorizontalCell.h"

@interface YMTextBarHorizontalCell ()

@property (nonatomic, strong) UIImageView *bigImage;

@end

@implementation YMTextBarHorizontalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.bigImage];
    }
    return self;
}

- (UIImageView *)bigImage
{
    if (!_bigImage) {
        
        _bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 95)];
        _bigImage.image = Image(@"defaultImage");
    }
    return _bigImage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
