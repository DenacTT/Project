//
//  NormalTableViewCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/10/31.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "NormalTableViewCell.h"
#import "UILabel+Multiline.h"
#imp

@interface NormalTableViewCell ()

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *isNewLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIImageView *descImage;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation NormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.topLine];
        [self addSubview:self.headImage];
        [self addSubview:self.nickNameLabel];
        [self addSubview:self.isNewLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.descLabel];
        [self addSubview:self.moreBtn];
        [self addSubview:self.descImage];
        [self addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark - method
+ (CGFloat)cellHeightWithModel:(TextBarGroupModel *)model
{
    NSString *text = [NSString stringWithFormat:@"【%@】%@", model.title, model.desc];
    CGSize textSize = [UILabel sizeWithText:text lines:0 font:[UIFont systemFontOfSize:14.f] andLineSpacing:7.f constrainedToSize:CGSizeMake(ScreenWidth-15*2, MAXFLOAT)];
    return 8+15+35+15+textSize.height+13+14+13+(ScreenWidth-15*2)+30;
}

#pragma mark - setter
- (void)setGroupModel:(TextBarGroupModel *)groupModel
{
    _groupModel = groupModel;
    if (groupModel) {
        
//        self.headImage
        
        self.nickNameLabel.text = [NSString stringWithFormat:@"%@", groupModel.usersInfo.realName];
        
        if (groupModel.readType==YMSysReadTypeUnRead) {
            self.isNewLabel.hidden = NO;
        }else{
            self.isNewLabel.hidden = YES;
        }
        
        self.timeLabel.text = [NSString stringWithFormat:@"%f", groupModel.createTime];
        
        self.descLabel.text = [NSString stringWithFormat:@"【%@】%@", groupModel.title, groupModel.desc];
        
        self.moreBtn.top = self.descLabel.bottom+13;
        self.descImage.top = self.moreBtn.bottom+13;
        
//        self.descImage
        
        self.bottomLine.top = self.descImage.bottom+30;
    }
}

#pragma mark - ButtonClick
- (void)readDetail:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(readDetail:)]) {
        [self.delegate readDetail:self];
    }
}

#pragma mark - getter
- (UIView *)topLine
{
    if (!_topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 8)];
        _topLine.backgroundColor = RGB(243, 243, 247);
    }
    return _topLine;
}

- (UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, _topLine.bottom+15, 35, 35)];
        
        _headImage.layer.borderWidth = 0.5;
        _headImage.layer.borderColor = RGBA(0, 0, 0, 0.1).CGColor;
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius  = _headImage.width/2;
        
        _headImage.image = Image(@"headImage");
    }
    return _headImage;
}

- (UILabel *)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headImage.right+6, _headImage.center.y-5, 40, 14)];
        _nickNameLabel.text = @"昵称";
        _nickNameLabel.width = [self textWidth:_nickNameLabel.text];
        _nickNameLabel.font = Font(14);
        _nickNameLabel.textColor = RGB(50, 50, 50);
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nickNameLabel;
}

- (UILabel *)isNewLabel
{
    if (!_isNewLabel) {
        _isNewLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nickNameLabel.right+6, _headImage.center.y-4, 40, 12)];
        _isNewLabel.text = @"NEW";
        _isNewLabel.font = Font(12);
        _isNewLabel.textColor = RGB(240, 65, 47);
        _isNewLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _isNewLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-115, _headImage.center.y-4, 100, 15)];
        _timeLabel.text = @"2016年11月11日";
        _timeLabel.font = Font(12);
        _timeLabel.textColor = RGB(136, 136, 136);
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _headImage.bottom+15, ScreenWidth-15*2, 100)];
        _descLabel.numberOfLines = 0;
        _descLabel.text = @"拍摄人像时背景的选择很重要，如果运用得当可以很好的衬托画面的气氛，复杂的背景容易分散观赏 者的注意力，因此拍摄时应尽量选择简洁协调的背景，这样可以更好的突出被摄者。如果在室内拍摄，采 用平视的角度，可以优先考虑使用墙壁或背景布，采用俯视的角度可以考虑使用床单或地板。如果在室外 拍摄，可以考虑使用大光圈虚化背景，或寻找漂亮的建筑外墙，密集的花丛，还可以通过仰视以蓝天为背 景，或俯视拍摄以草地为背景。 总之，只要在选取背景方面以简洁为原则，总能够找到合适的拍摄场景与角度。";
        _descLabel.font = Font(14);
        _descLabel.textColor = RGB(50, 50, 50);
    }
    return _descLabel;
}

- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _moreBtn.frame = CGRectMake(_headImage.left, _descLabel.bottom+11, 60, 16);
        _moreBtn.titleLabel.font = Font(14.f);
        [_moreBtn setTitle:@"查看详情" forState:(UIControlStateNormal)];
        [_moreBtn setTintColor:RGB(74, 144, 226)];
        
        [_moreBtn addTarget:self action:@selector(readDetail:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _moreBtn;
}

- (UIImageView *)descImage
{
    if (!_descImage) {
        
        _descImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, _moreBtn.bottom+13, ScreenWidth-15*2, ScreenWidth-15*2)];
        _descImage.image = Image(@"test");
        
        [_descImage setContentMode:(UIViewContentModeScaleAspectFill)];
        [_descImage.layer setMasksToBounds:YES];
        
    }
    return _descImage;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _descImage.bottom+30, ScreenWidth, 0.5)];
        _bottomLine.backgroundColor = RGB(170, 170, 170);
    }
    return _bottomLine;
}

- (CGFloat)textWidth:(NSString*)string
{
    CGSize contantSize = CGSizeMake(ScreenWidth-115-50, MAXFLOAT);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.f]};
    CGRect rect = [string boundingRectWithSize:contantSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat width = rect.size.width;
    return width;
}

@end
