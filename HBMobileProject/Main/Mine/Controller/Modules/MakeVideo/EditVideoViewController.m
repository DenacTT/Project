//
//  EditVideoViewController.m
//  scale
//
//  Created by HarbingWang on 16/9/21.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "EditVideoViewController.h"
//#import "YMNetRequset.h"
//#import "YMManagerCardDay.h"
#import "WBStatusComposeTextParser.h"
#import "WBStatusLayout.h"
#import "BiggerBtn.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "RecordVideoController.h"

@interface EditVideoViewController ()<YYTextViewDelegate>

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) YYTextView    *textView;
@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) UIView        *shareView;
@property (nonatomic, strong) BiggerBtn     *weixinBtn;
@property (nonatomic, strong) BiggerBtn     *sinaBtn;
@property (nonatomic, strong) UIButton      *privateView;
@property (nonatomic, strong) UIButton      *privateBtn;
@property (nonatomic, strong) UILabel       *privateLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indictorView;

@property (nonatomic, strong) MPMoviePlayerViewController *playerVC;
@property (nonatomic, strong) AVPlayerViewController *moviePlayer;
@property (nonatomic, strong) AVPlayer *player;

@end

@implementation EditVideoViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(232, 232, 232);
    self.isUseBackBtn = YES;
    self.isUseRightBtn = YES;
    
    [self.backBtn setImage:nil forState:(UIControlStateNormal)];
    [self.backBtn setFrame:CGRectMake(6, 20, 44, 44)];
    [self.backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    [self.backBtn setTitleColor:RGB(18, 196, 190) forState:(UIControlStateNormal)];
    
    [self.rightBtn setFrame:CGRectMake(ScreenWidth-50, 20, 44, 44)];
    [self.rightBtn setTitle:@"发送" forState:(UIControlStateNormal)];
    [self.rightBtn setTitleColor:RGB(18, 196, 190) forState:(UIControlStateNormal)];
    
    [self setUpSubViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - private methods
- (void)setUpSubViews
{
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.shareView];
    
    [self.mainView addSubview:self.textView];
    [self.mainView addSubview:self.imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewVideo:)];
    _imageView.userInteractionEnabled = YES;
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_imageView addGestureRecognizer:tap];
    
    NSLog(@"\n 视频路径: %@ \n 时长: %.f %.2f", self.videoPath, _videoLength ,_videoLength);
}

- (void)clickBack
{
    [self.textView resignFirstResponder];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)clickRight
{
    [self.textView resignFirstResponder];
    
    
//    [[YMNetRequset shareInstance] setBBsDakaOfVideoWithPhotoPath:self.photoPath videoPath:self.videoPath videoLength:10 tags:nil content:nil status:0 videoUploadProgres:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
//        
//    } success:^(id object) {
//        [YMManagerCardDay shareInstance].isTodayDaka = YES;
//
//    } andFail:^(id object) {
//        
//    }];
    
}

#pragma mark - ButtonClick
- (void)weixinBtnClick:(BiggerBtn *)btn
{
    
}

- (void)sinaBtnClick:(BiggerBtn *)btn
{
    
}

-(void)privateBtnClick:(UIButton *)sender
{
    [self.textView resignFirstResponder];
}

- (void)previewVideo:(UITapGestureRecognizer *)tap
{
    [self.textView resignFirstResponder];
    
    self.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:self.videoPath];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:[_playerVC moviePlayer]];
    [[_playerVC moviePlayer] prepareToPlay];
    
    [self presentMoviePlayerViewControllerAnimated:_playerVC];
    [[_playerVC moviePlayer] play];
}

//点击完成或者播放完毕时调用
- (void)playVideoFinished:(NSNotification *)theNotification {
    MPMoviePlayerController *player = [theNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [player stop];
    [self.playerVC dismissMoviePlayerViewControllerAnimated];
    self.playerVC = nil;
}

#pragma mark - YYTextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - setter
- (void)setThumbnailImage:(UIImage *)thumbnailImage
{
    _thumbnailImage = thumbnailImage;
}

- (void)setVideoPath:(NSURL *)videoPath
{
    _videoPath = videoPath;
}

#pragma mark - getter
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 190)];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (UIView *)shareView
{
    if (!_shareView) {
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, _mainView.bottom, ScreenWidth, 44)];
        _shareView.backgroundColor = [UIColor whiteColor];
        
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        topLine.backgroundColor = [UIColor colorWithRGB:0xf6f6f7ff];
        [_shareView addSubview:topLine];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _shareView.frame.size.height-1, ScreenWidth, 1)];
        bottomLine.backgroundColor = [UIColor colorWithRGB:0xf6f6f7ff];
        [_shareView addSubview:bottomLine];
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, _shareView.frame.size.height/2-24/2, 60, 24)];
        shareLabel.text = STR(@"EIVC_synchronization");
        shareLabel.textColor = RGB(136, 136, 136);
        shareLabel.font = Font(16.f);
        [_shareView addSubview:shareLabel];
        
        CGFloat btnH = 24;
        _weixinBtn = [BiggerBtn buttonWithType:UIButtonTypeCustom];
        _weixinBtn.frame = CGRectMake(CGRectGetMaxX(shareLabel.frame), _shareView.frame.size.height/2-btnH/2, btnH, btnH);
        [_weixinBtn setImage:Image(@"UMS_wechat_timeline_off") forState:UIControlStateNormal];
        [_weixinBtn setImage:Image(@"UMS_wechat_timeline_icon") forState:UIControlStateSelected];
        [_weixinBtn addTarget:self action:@selector(weixinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:_weixinBtn];
        
        _sinaBtn = [BiggerBtn buttonWithType:UIButtonTypeCustom];
        _sinaBtn.frame = CGRectMake(CGRectGetMaxX(_weixinBtn.frame)+4, _shareView.frame.size.height/2-btnH/2+2, btnH, btnH);
        [_sinaBtn setImage:Image(@"UMS_sina_off") forState:UIControlStateNormal];
        [_sinaBtn setImage:Image(@"UMS_sina_icon") forState:UIControlStateSelected];
        [_sinaBtn addTarget:self action:@selector(sinaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:_sinaBtn];
        
        //私密打卡
        _privateView = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _privateView.width = 12+4+24;
        _privateView.height = 24;
        _privateView.top = (_shareView.height - _privateView.height)/2;
        _privateView.left = _shareView.width - 14 - _privateView.width;
        [_privateView addTarget:self action:@selector(privateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:_privateView];
        
        _privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _privateBtn.frame = CGRectMake(0, 6, 12, 12);
        [_privateBtn setImage:Image(@"privateCard_unLock") forState:UIControlStateNormal];
        [_privateView addSubview:_privateBtn];
        
        _privateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_privateBtn.right + 4, 6, 26, 12)];
        _privateLabel.text = STR(@"EIVC_publicLabel");
        _privateLabel.textColor = [UIColor lightGrayColor];
        _privateLabel.font = [UIFont boldSystemFontOfSize:12];
        [_privateView addSubview:_privateLabel];
    }
    return _shareView;
}

- (YYTextView *)textView
{
    if (!_textView) {
        _textView = [[YYTextView alloc] initWithFrame:CGRectMake(13, 9, self.view.frame.size.width-30, 100-7)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = Font(14);
        _textView.textColor = [UIColor blackColor];
        
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;/* 自动调整自己的宽,高,保证其与左右,上下的距离不变*/
        _textView.showsVerticalScrollIndicator = NO;
        _textView.alwaysBounceVertical = YES;
        
        _textView.allowsCopyAttributedString = YES;
        _textView.allowsPasteAttributedString = YES;
        
        _textView.delegate = self;
        
        _textView.textParser = [WBStatusComposeTextParser new];
        
        WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
        modifier.font = Font(14);
        modifier.paddingTop = 12;
        modifier.paddingBottom = 12;
        modifier.lineHeightMultiple = 1.5;
        _textView.linePositionModifier = modifier;
        
        _textView.text = @"#小视频#";
        
        [_textView becomeFirstResponder];
        
    }
    return _textView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, _mainView.frame.size.height-13-60, 60, 60)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.cornerRadius = 3;
        _imageView.layer.masksToBounds = YES;
        _imageView.image = _thumbnailImage;
    }
    return _imageView;
}

- (UIActivityIndicatorView *)indictorView
{
    if (!_indictorView) {
        _indictorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(ScreenWidth/2-20/2, _mainView.frame.size.height/2-20/2, 20, 20)];
        _indictorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_indictorView hidesWhenStopped];
    }
    return _indictorView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
