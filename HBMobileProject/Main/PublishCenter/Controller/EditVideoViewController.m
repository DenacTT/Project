//
//  EditVideoViewController.m
//  scale
//
//  Created by HarbingWang on 16/9/21.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "EditVideoViewController.h"
#import "WBStatusComposeTextParser.h"
#import "WBStatusLayout.h"
#import "BiggerBtn.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

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
    [self.backBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.backBtn setTitleColor:RGB(18, 196, 190) forState:(UIControlStateNormal)];
    
    [self.rightBtn setFrame:CGRectMake(ScreenWidth-50, 20, 44, 44)];
    [self.rightBtn setTitle:@"发送" forState:(UIControlStateNormal)];
    [self.rightBtn setTitleColor:RGB(18, 196, 190) forState:(UIControlStateNormal)];
    
    [self setUpSubViews];
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
}

- (void)clickBack
{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickRight
{
    [self.textView resignFirstResponder];
    NSLog(@"\n 视频路径: %@ \n 图片路径: %@", self.videoPath, self.photoPath);
    
    
}

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
    
    self.moviePlayer = [[AVPlayerViewController alloc] init];
    _moviePlayer.view.frame = self.view.bounds;
    _moviePlayer.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_moviePlayer.view];
    
    self.player = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:self.videoPath]];
    _moviePlayer.player = _player;
    [self.player play];
}



#pragma mark - YYTextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
        shareLabel.font = Font(14);
        shareLabel.textColor = RGB(136, 136, 136);
        [_shareView addSubview:shareLabel];
        
        CGFloat btnH = 24;
        _weixinBtn = [BiggerBtn buttonWithType:UIButtonTypeCustom];
        _weixinBtn.frame = CGRectMake(CGRectGetMaxX(shareLabel.frame)+15, _shareView.frame.size.height/2-btnH/2, btnH, btnH);
        [_weixinBtn setImage:Image(@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_wechat_timeline_off") forState:UIControlStateNormal];
        [_weixinBtn setImage:Image(@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_wechat_timeline_icon") forState:UIControlStateSelected];
        [_weixinBtn addTarget:self action:@selector(weixinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:_weixinBtn];
        
        _sinaBtn = [BiggerBtn buttonWithType:UIButtonTypeCustom];
        _sinaBtn.frame = CGRectMake(CGRectGetMaxX(_weixinBtn.frame)+15, _shareView.frame.size.height/2-btnH/2+2, btnH, btnH);
        [_sinaBtn setImage:Image(@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_sina_off") forState:UIControlStateNormal];
        [_sinaBtn setImage:Image(@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_sina_icon") forState:UIControlStateSelected];
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
        _privateLabel.font = Font(12);
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
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.clipsToBounds = YES;
        _imageView.image = [UIImage imageWithContentsOfFile:self.photoPath];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
