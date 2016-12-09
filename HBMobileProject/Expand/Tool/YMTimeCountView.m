//
//  YMTimeCountView.m
//  scale
//
//  Created by HarbingWang on 16/12/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "YMTimeCountView.h"
// label数量
#define labelCount 3
#define separateLabelCount 2
#define padding 5

@interface YMTimeCountView ()
{
//    NSTimer *_timer;
    dispatch_source_t _timer;
}

//@property (nonatomic, strong) NSMutableArray *timeLabelArr;
//@property (nonatomic, strong) NSMutableArray *separateLabelArr;

@property (nonatomic, strong) UILabel *timeLabel;

// 时
@property (nonatomic, strong) UILabel *hourLabel;
// :
@property (nonatomic, strong) UILabel *sepLabelA;
// 分
@property (nonatomic, strong) UILabel *minuesLabel;
// :
@property (nonatomic, strong) UILabel *sepLabelB;
// 秒
@property (nonatomic, strong) UILabel *secondsLabel;

@end

@implementation YMTimeCountView

+ (instancetype)shareCountDown {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YMTimeCountView alloc] init];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:self.timeLabel];
        
        [self addSubview:self.hourLabel];
        [self addSubview:self.sepLabelA];
        [self addSubview:self.minuesLabel];
        [self addSubview:self.sepLabelB];
        [self addSubview:self.secondsLabel];
    }
    return self;
}

- (void)setRushStartTime:(NSTimeInterval)rushStartTime {
    _rushStartTime = rushStartTime;
}

- (void)runTimerWithRushStartTime:(NSTimeInterval)rushStartTime {
    
    // 倒计时开始时间(当前时间)
    NSDate *timerStartDate = [NSDate date];
    
    // 倒计时结束的时间(活动开始时间)
    NSDate *timerEndDate = [NSDate dateWithTimeIntervalSince1970:rushStartTime];
    
    // 倒计时时间差
    NSTimeInterval timeInterval = [timerEndDate timeIntervalSinceDate:timerStartDate];
    
    if (!_timer) {
        
        __block int timeOut = timeInterval;
        if (timeOut != 0) {
         
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
            dispatch_source_set_event_handler(_timer, ^{
                
                if (timeOut > 0) {
                    
                    int ss = 1;       // 秒
                    int mi = ss * 60; // 分
                    int hh = mi * 60; // 时
                    int dd = hh * 24; // 天
                
                    // 剩余的时间
                    int days     = timeOut / dd;//天
                    int hours    = (timeOut - days * dd) / hh;//时
                    int minutes  = (timeOut - days * dd - hours * hh) / mi;//分
                    int seconds  = (timeOut - days * dd - hours * hh - minutes * mi) / ss;//秒
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (hours < 10) {
                            self.hourLabel.text = [NSString stringWithFormat:@"0%d", hours];
                        } else {
                            self.hourLabel.text = [NSString stringWithFormat:@"%d", hours];
                        }
                        if (minutes < 10) {
                            self.minuesLabel.text = [NSString stringWithFormat:@"0%d", minutes];
                        } else {
                            self.minuesLabel.text = [NSString stringWithFormat:@"%d", minutes];
                        }
                        if (seconds < 10) {
                            self.secondsLabel.text = [NSString stringWithFormat:@"0%d", seconds];
                        } else {
                            self.secondsLabel.text = [NSString stringWithFormat:@"%d", seconds];
                        }
                    });
                    
                    timeOut--;
                    
                } else {
                    
                    //倒计时结束，关闭定时器
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.hourLabel.text     = @"00";
                        self.minuesLabel.text   = @"00";
                        self.secondsLabel.text  = @"00";
                    });
                    self.timeStopBlock();
                }
                
            });
            dispatch_resume(_timer);
        }
    }
}


//- (void)setTimeStamp:(NSInteger)timeStamp {
//    _timeStamp = timeStamp;
//    if (_timeStamp != 0) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
//    }
//}

//- (void)timer:(NSTimer *)timer {
//    _timeStamp--;
////    [self getDetailTimeWithTimeStamp:_timeStamp];
//    if (_timeStamp==0) {
//        [_timer invalidate];
//        _timer = nil;
//        // 执行 block
//        self.timeStopBlock();
//    }
//}

//- (void)getDetailTimeWithTimeStamp:(NSInteger)timestamp {
//    
//    NSInteger ms = timestamp;
//    NSInteger ss = 1;       // 秒
//    NSInteger mi = ss * 60; // 分
//    NSInteger hh = mi * 60; // 时
//    NSInteger dd = hh * 24; // 天
//    
//    // 剩余的时间
//    NSInteger day       = ms / dd;//天
//    NSInteger hour      = (ms - day * dd) / hh;//时
//    NSInteger minute    = (ms - day * dd - hour * hh) / mi;//分
//    NSInteger second    = (ms - day * dd - hour * hh - minute * mi) / ss;//秒
//    
////    self.hourLabel.text = [NSString stringWithFormat:@"%zd", hour];
////    self.minuesLabel.text = [NSString stringWithFormat:@"%zd", minute];
////    self.secondsLabel.text = [NSString stringWithFormat:@"%zd", second];
//    
//    self.timeLabel.text = [NSString stringWithFormat:@"%zd:%zd:%zd", hour, minute , second];
//}

#pragma mark - layoutSubViews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    CGFloat labelW = viewW / 8;
    CGFloat labelH = viewH;
    
//    self.timeLabel.frame = CGRectMake(0, 0, viewW, viewH);
    
    self.hourLabel.frame    = CGRectMake(0, 0, labelW*2, labelH);
    self.sepLabelA.frame    = CGRectMake(labelW*2, 0, labelW,   labelH);
    self.minuesLabel.frame  = CGRectMake(labelW*3, 0, labelW*2, labelH);
    self.sepLabelB.frame    = CGRectMake(labelW*5, 0, labelW,   labelH);
    self.secondsLabel.frame = CGRectMake(labelW*6, 0, labelW*2, labelH);
}

#pragma mark - setter & getter

//- (NSMutableArray *)timeLabelArr{
//    if (!_timeLabelArr) {
//        _timeLabelArr = [[NSMutableArray alloc] init];
//    }
//    return _timeLabelArr;
//}
//
//- (NSMutableArray *)separateLabelArrM{
//    if (!_separateLabelArr) {
//        _separateLabelArr = [[NSMutableArray alloc] init];
//    }
//    return _separateLabelArr;
//}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = RGB(255, 255, 255);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont fontWithName:@"miso-bold" size:32];
    }
    return _timeLabel;
}

- (UILabel *)hourLabel{
    if (!_hourLabel) {
        _hourLabel = [[UILabel alloc] init];
        [self labelFormate:_hourLabel];
//        _hourLabel.textAlignment = NSTextAlignmentCenter;
//        _hourLabel.backgroundColor = [UIColor redColor];
    }
    return _hourLabel;
}

- (UILabel *)sepLabelA {
    if (!_sepLabelA) {
        _sepLabelA = [[UILabel alloc] init];
        _sepLabelA.text = @":";
        [self labelFormate:_sepLabelA];
    }
    return _sepLabelA;
}

- (UILabel *)minuesLabel{
    if (!_minuesLabel) {
        _minuesLabel = [[UILabel alloc] init];
        [self labelFormate:_minuesLabel];
//        _minuesLabel.textAlignment = NSTextAlignmentCenter;
//        _minuesLabel.backgroundColor = [UIColor orangeColor];
    }
    return _minuesLabel;
}

- (UILabel *)sepLabelB {
    if (!_sepLabelB) {
        _sepLabelB = [[UILabel alloc] init];
        _sepLabelB.text = @":";
        [self labelFormate:_sepLabelB];
    }
    return _sepLabelB;
}

- (UILabel *)secondsLabel{
    if (!_secondsLabel) {
        _secondsLabel = [[UILabel alloc] init];
        [self labelFormate:_secondsLabel];
//        _secondsLabel.textAlignment = NSTextAlignmentCenter;
//        _secondsLabel.backgroundColor = [UIColor yellowColor];
    }
    return _secondsLabel;
}

- (void)labelFormate:(UILabel *)label {
    label.textColor = RGB(255, 255, 255);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"miso-bold" size:32];
}

@end
