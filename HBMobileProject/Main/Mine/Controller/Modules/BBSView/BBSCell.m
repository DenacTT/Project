//
//  BBSCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "BBSCell.h"
#import "YYKit.h"

@interface BBSCell ()

@property (nonatomic,strong) UIView *bbsContentView;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) YYLabel *zanLabel;

@property (nonatomic,strong) YYLabel *contentLabel;

@property (nonatomic,strong) UILabel *commentCountLabel;

@property (nonatomic,strong) YYLabel *commentALabel;

@property (nonatomic,strong) YYLabel *commentBLabel;

@end

@implementation BBSCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.headView];
        [self addSubview:self.bbsContentView];
        [self addSubview:self.operateView];
        [self addSubview:self.zanLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.commentCountLabel];
        [self addSubview:self.commentALabel];
        [self addSubview:self.commentBLabel];
        [self addSubview:self.bottomView];
    }
    return self;
}

#pragma mark - getter
- (BBSCellTopView *)headView
{
    if (!_headView) {
        _headView = [[BBSCellTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 54.5)];
    }
    return _headView;
}

-(UIView *)bbsContentView{
    if (!_bbsContentView) {
        _bbsContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headView.bottom, ScreenWidth, ScreenWidth)];
        _bbsContentView.backgroundColor = [UIColor yellowColor];
    }
    return _bbsContentView;
}

-(BBSCellOperateView *)operateView{
    if (!_operateView) {
        _operateView = [[BBSCellOperateView alloc] initWithFrame:CGRectMake(0, self.bbsContentView.bottom, ScreenWidth, 45)];
    }
    return _operateView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.commentBLabel.bottom+18, ScreenWidth, 4)];
        _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    }
    return _bottomView;
}

-(YYLabel *)zanLabel{
    if (!_zanLabel) {
        _zanLabel = [[YYLabel alloc] initWithFrame:CGRectMake(15, self.operateView.bottom+12, ScreenWidth-15*2, 15)];
        _zanLabel.backgroundColor = [UIColor grayColor];
    }
    return _zanLabel;
}

-(YYLabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc] initWithFrame:CGRectMake(15, self.zanLabel.bottom+12, ScreenWidth-15*2, 14)];
        _contentLabel.backgroundColor = [UIColor blueColor];
    }
    return _contentLabel;
}

-(UILabel *)commentCountLabel{
    if (!_commentCountLabel) {
        _commentCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.contentLabel.bottom+16, ScreenWidth-15*2, 14)];
        _commentCountLabel.textColor = RGB(172, 172, 172);
        _commentCountLabel.font = Font(14);
        _commentCountLabel.backgroundColor = [UIColor purpleColor];
    }
    return _commentCountLabel;
}

-(YYLabel *)commentALabel{
    if (!_commentALabel) {
        _commentALabel = [[YYLabel alloc] initWithFrame:CGRectMake(15, self.commentCountLabel.bottom+7, ScreenWidth-15*2, 14)];
        _commentALabel.backgroundColor = [UIColor yellowColor];
    }
    return _commentALabel;
}

-(YYLabel *)commentBLabel{
    if (!_commentBLabel) {
        _commentBLabel = [[YYLabel alloc] initWithFrame:CGRectMake(15, self.commentALabel.bottom+7, ScreenWidth-15*2, 14)];
        _commentBLabel.backgroundColor = [UIColor orangeColor];
    }
    return _commentBLabel;
}

@end
