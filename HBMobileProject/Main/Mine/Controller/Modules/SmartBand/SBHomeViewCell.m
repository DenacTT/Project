//
//  SBHomeViewCell.m
//  scale
//
//  Created by HarbingWang on 17/3/28.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBHomeViewCell.h"
#import "SBSleepInfoView.h"
#import "SBWeightInfoView.h"

#define UnitCals    @"Cals"
#define UnitMinute  @"min"
#define UnitHour    @"h"
#define UnitWeight  @"kg"
#define UnitKm      @"km"

@interface SBHomeViewCell ()

@property (nonatomic, strong) UIView  *exeProgs;    //锻炼Progress
@property (nonatomic, strong) UILabel *progressLab; //显示当前进度
@property (nonatomic, strong) SBSleepInfoView *sleProgs;//睡眠进度
@property (nonatomic, strong) SBWeightInfoView *weigProgs;//体重进度

@end

@implementation SBHomeViewCell

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(244, 244, 244);
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.mainText];
        [self.contentView addSubview:self.subText];
        
        [self.contentView addSubview:self.exeProgs];
        [self.contentView addSubview:self.progressLab];
        [self.contentView addSubview:self.sleProgs];
        [self.contentView addSubview:self.weigProgs];
    }
    return self;
}

#pragma mark - Setter
- (void)setValue:(SBHomeModel *)model {
    
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sb_home_cell_type0%zi@2x", model.cellType+1]];
    
    self.subText.text  = [NSString stringWithFormat:@"%@", model.subText];//append
    switch (model.cellType) {
        case SBHomeCellType_Exercise:
        {
            self.mainText.attributedText = [self attributedNumStr:[NSString stringWithFormat:@"%zi ", model.calsNum] unitStr:UnitCals];
            self.exeProgs.hidden    = NO;
            self.progressLab.hidden = NO;
            self.sleProgs.hidden    = YES;
            self.weigProgs.hidden   = YES;
            self.progressLab.frame  = CGRectMake(self.exeProgs.left, self.exeProgs.top, self.exeProgs.width*model.exeProgress, self.exeProgs.height);
            
        }
            break;
        case SBHomeCellType_HeartRate:
        {
            self.mainText.attributedText = [self attributedNumStr:[NSString stringWithFormat:@"%zi/", model.heartRate] unitStr:UnitMinute];
            self.exeProgs.hidden    = YES;
            self.progressLab.hidden = YES;
            self.sleProgs.hidden    = YES;
            self.weigProgs.hidden   = YES;
        }
            break;
        case SBHomeCellType_SleepTime:
        {
            self.mainText.attributedText = [self attributedSleepTime:model.sleepTime];
            self.exeProgs.hidden    = YES;
            self.progressLab.hidden = YES;
            self.sleProgs.hidden    = NO;
            self.weigProgs.hidden   = YES;
        }
            break;
        case SBHomeCellType_BodyWeight:
        {
            self.mainText.attributedText = [self attributedNumStr:[NSString stringWithFormat:@"%zi ", model.weightNum] unitStr:UnitWeight];
            self.exeProgs.hidden    = YES;
            self.progressLab.hidden = YES;
            self.sleProgs.hidden    = YES;
            self.weigProgs.hidden   = NO;
            [self.weigProgs setValue:model];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Private methods
// 富文本
- (NSMutableAttributedString *)attributedNumStr:(NSString *)numStr unitStr:(NSString *)unitStr {
    
    NSString *originString = [numStr stringByAppendingString:unitStr];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:originString];
    [string addAttribute:NSFontAttributeName value:Font(16) range:NSMakeRange(0, numStr.length)];
    [string addAttribute:NSFontAttributeName value:Font(14) range:NSMakeRange(numStr.length, unitStr.length)];
    return string;
}

- (NSMutableAttributedString *)attributedSleepTime:(NSInteger)sleepTime {
    
    NSString *hour = [NSString stringWithFormat:@"%zi", sleepTime / 60];
    NSString *mint = [NSString stringWithFormat:@"%zi", sleepTime % 60];
    NSString *hourUnit = UnitHour;
    NSString *mintUnit = UnitMinute;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@ %@%@", hour,hourUnit,mint,mintUnit]];
    [string addAttribute:NSFontAttributeName value:Font(16) range:NSMakeRange(0, hour.length)];
    [string addAttribute:NSFontAttributeName value:Font(14) range:NSMakeRange(hour.length, hourUnit.length)];
    [string addAttribute:NSFontAttributeName value:Font(16) range:NSMakeRange(hour.length+hourUnit.length+1, mint.length)];
    [string addAttribute:NSFontAttributeName value:Font(14) range:NSMakeRange(hour.length+hourUnit.length+mint.length+1, hourUnit.length+2)];
    
    return string;
}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)-90/2, 27, 90, 90)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
//        _imageView.backgroundColor = RGBA(64, 159, 232, 0.5);
    }
    return _imageView;
}

- (UILabel *)mainText {
    if (!_mainText) {
        _mainText = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.bottom+5, CGRectGetWidth(self.bounds), 17)];
        [_mainText setLabelText:@""
                           font:Font(16)
                      textColor:RGB(0, 0, 0)
                  textAlignment:NSTextAlignmentCenter];
    }
    return _mainText;
}

- (UILabel *)subText {
    if (!_subText) {
        _subText = [[UILabel alloc] initWithFrame:CGRectMake(0, _mainText.bottom+4, CGRectGetWidth(self.bounds), 14)];
        [_subText setLabelText:@""
                          font:Font(12)
                     textColor:RGB(136, 136, 136)
                 textAlignment:NSTextAlignmentCenter];
    }
    return _subText;
}

// 锻炼
- (UIView *)exeProgs {
    if (!_exeProgs) {
        _exeProgs = [[UIView alloc] initWithFrame:CGRectMake(self.imageView.left+3, self.imageView.bottom-4-6, self.imageView.width-3*2, 6)];
        _exeProgs.backgroundColor = RGBA(92, 184, 236, 0.2);
        _exeProgs.layer.masksToBounds = YES;
        _exeProgs.layer.cornerRadius  = 3;
        _exeProgs.hidden = YES;
    }
    return _exeProgs;
}

- (UILabel *)progressLab {
    if (!_progressLab) {
        _progressLab = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.left+3, self.imageView.bottom-4-6, self.imageView.width-3*2, 6)];
        _progressLab.backgroundColor = RGB(92, 184, 236);
        _progressLab.layer.masksToBounds = YES;
        _progressLab.layer.cornerRadius  = 3;
        _progressLab.hidden = YES;
    }
    return _progressLab;
}

// 睡眠
- (SBSleepInfoView *)sleProgs {
    if (!_sleProgs) {
        _sleProgs = [[SBSleepInfoView alloc] initWithFrame:CGRectMake(self.imageView.left-10, self.imageView.bottom-14-8-14-10, 110, 8+14+10)];
        _sleProgs.hidden = YES;
    }
    return _sleProgs;
}

// 体重
- (SBWeightInfoView *)weigProgs {
    if (!_weigProgs) {
        _weigProgs = [[SBWeightInfoView alloc] initWithFrame:CGRectMake(self.imageView.center.x-122/2, self.imageView.top+4, 122, 73)];
        _weigProgs.hidden = YES;
    }
    return _weigProgs;
}


@end
