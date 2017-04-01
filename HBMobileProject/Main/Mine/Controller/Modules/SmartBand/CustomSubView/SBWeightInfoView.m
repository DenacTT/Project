//
//  SBWeightInfoView.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/31.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBWeightInfoView.h"
#import "CircleProgressView.h"

@interface SBWeightInfoView ()

@property (nonatomic, strong) CircleProgressView *weightProgress;  //体重进度
@property (nonatomic, strong) UILabel *curWeight;       //当前体重
@property (nonatomic, strong) UILabel *tarWeight;       //目标体重

@end

@implementation SBWeightInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor orangeColor];
        
        [self addSubview:self.weightProgress];
        [self addSubview:self.curWeight];
        [self addSubview:self.tarWeight];
    }
    return self;
}

#pragma mark - Previte Methods
- (void)setValue:(SBHomeModel *)model {
    [self.weightProgress setStrokeEnd:0.8 animated:NO];
}

#pragma mark - Setter
//- (void)setModel:(SBHomeModel *)model {
//    
//    
//}

#pragma mark - Getter
- (CircleProgressView *)weightProgress {
    if (!_weightProgress) {
        
        CGRect frame = CGRectMake(CGRectGetMidX(self.bounds)-106/2-3, 28, 106+6, 53+3+3);
        _weightProgress = [CircleProgressView circleProgressViewWithFrame:frame
                                                              lineWidth:6.f
                                                              lineColor:nil
                                                              clockWise:YES
                                                             startAngle:0];

        _weightProgress.isNeedBackground = YES;
        _weightProgress.startAngle       = M_PI;
        _weightProgress.endAngle         = 2*M_PI;
        _weightProgress.lineWidth        = 6.f;
        _weightProgress.bgLineWidth      = 6.f;
        _weightProgress.lineColor        = RGB(92, 184, 236);
        _weightProgress.bgLineColor      = RGBA(92, 184, 236, 0.2);
        [_weightProgress makeConfigEffective];
    }
    return _weightProgress;
}

- (UILabel *)curWeight {
    if (!_curWeight) {
        _curWeight = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-10, 16, 10)];
        _curWeight.text = @"86";
        _curWeight.textColor = RGB(136, 136, 136);
        _curWeight.font = Font(10);
        _curWeight.textAlignment = NSTextAlignmentCenter;
    }
    return _curWeight;
}

- (UILabel *)tarWeight {
    if (!_tarWeight) {
        _tarWeight = [[UILabel alloc] initWithFrame:CGRectMake(self.width-16, self.height-10, 16, 10)];
        _tarWeight.text = @"10";
        _tarWeight.font = Font(10);
        _tarWeight.textColor = RGB(136, 136, 136);
        _tarWeight.textAlignment = NSTextAlignmentCenter;
    }
    return _tarWeight;
}

@end
