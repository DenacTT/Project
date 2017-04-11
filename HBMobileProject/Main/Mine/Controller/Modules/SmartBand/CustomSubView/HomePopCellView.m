//
//  HomePopCellView.m
//  HBMobileProject
//
//  Created by HarbingWang on 2017/4/6.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "HomePopCellView.h"
#import "POP.h"

#define CELLW 210
#define CELLH 55

@interface HomePopCellView ()

@property (nonatomic, strong) UIView      *selectView;//被选中时高亮
@property (nonatomic, strong) UIImageView *userIcon;  //用户头像
@property (nonatomic, strong) UILabel     *userName;  //用户昵称
@property (nonatomic, strong) UIView      *rightPoint;//右边标识
@property (nonatomic, strong) UIView      *bottomLine;//底部描边

@end

@implementation HomePopCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        self.userInteractionEnabled = YES;
        self.backgroundColor = RGBA(34, 34, 34, 0.9);
        
        [self.contentView addSubview:self.selectView];
        [self.contentView addSubview:self.userIcon];
        [self.contentView addSubview:self.userName];
        [self.contentView addSubview:self.rightPoint];
        [self.contentView addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark - Setter


#pragma mark - Getter
- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 200, 45)];
        _selectView.backgroundColor = RGBA(255, 255, 255, 0.15);
        _selectView.layer.masksToBounds = YES;
        _selectView.layer.cornerRadius = 3;
    }
    return _selectView;
}

- (UIImageView *)userIcon {
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, CELLH/2-32/2, 32, 32)];
        _userIcon.image = Image(@"familyUser_boy");
    }
    return _userIcon;
}

- (UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(self.userIcon.right+10, 0, CELLW-10*2-32-20, CELLH)];
        [_userName setLabelText:@"Judy"
                           font:Font(16.f)
                      textColor:[UIColor whiteColor]
                  textAlignment:NSTextAlignmentLeft];
    }
    return _userName;
}

- (UIView *)rightPoint {
    if (!_rightPoint) {
        _rightPoint = [[UIView alloc] initWithFrame:CGRectMake(CELLW-10-8, CELLH/2-4, 8, 8)];
        _rightPoint.backgroundColor = RGB(0, 175, 132);
        _rightPoint.layer.masksToBounds = YES;
        _rightPoint.layer.cornerRadius  = 4;
    }
    return _rightPoint;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(10, CELLH-0.5, CELLW-10*2, 0.5)];
        _bottomLine.backgroundColor = RGB(70, 70, 70);
    }
    return _bottomLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (self.selected){
        
        self.selectView.alpha = 1.f;
        [self.selectView.layer pop_removeAllAnimations];

        POPSpringAnimation *backgroundColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
        backgroundColor.toValue             = (id)RGBA(255, 255, 255, 0.1);
        [self.selectView.layer pop_addAnimation:backgroundColor forKey:nil];
        
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration           = 0.35f;
        scaleAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(0.98, 0.98)];
        [self.selectView pop_addAnimation:scaleAnimation forKey:nil];
        
    } else {
        
        self.selectView.alpha = 0.f;
        [self.selectView.layer pop_removeAllAnimations];
    }
}

@end
