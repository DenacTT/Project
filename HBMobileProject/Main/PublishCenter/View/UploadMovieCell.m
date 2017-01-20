//
//  UploadMovieCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/8.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "UploadMovieCell.h"

@interface UploadMovieCell ()

@end

@implementation UploadMovieCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.filePathLabel];
        [self addSubview:self.downloadBtn];
        [self addSubview:self.statusLabel];
        [self addSubview:self.cuttingLine];
    }
    return self;
}

#pragma mark - setter
//- (void)setUploadTask:(QPUploadTask *)uploadTask
//{
//    _uploadTask = uploadTask;
//    self.nameLabel.text = uploadTask.uploadId;
//    self.filePathLabel.text = uploadTask.taskId;
//    self.statusLabel.text = [NSString stringWithFormat:@"%f", uploadTask.progress];
//    
//    if (uploadTask.uploadFinished) {
//        [self.downloadBtn setTitle:@"打开视频" forState:(UIControlStateNormal)];
//    }else{
//        [self.downloadBtn setTitle:@"上传" forState:(UIControlStateNormal)];
//    }
//}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.top + 5, ScreenWidth - 15 * 2 - 60, 20)];
//        _nameLabel.backgroundColor = [UIColor redColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = Font(14.f);
    }
    return _nameLabel;
}

- (UILabel *)filePathLabel
{
    if (!_filePathLabel) {
        _filePathLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom + 5, _nameLabel.width, _nameLabel.height)];
//        _filePathLabel.backgroundColor = [UIColor blueColor];
        _filePathLabel.textAlignment = NSTextAlignmentLeft;
        _filePathLabel.numberOfLines = 0;
        _filePathLabel.font = Font(14.f);
    }
    return _filePathLabel;
}

- (UIButton *)downloadBtn
{
    if (!_downloadBtn) {
        _downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(_nameLabel.right + 10, _nameLabel.top, 60, _nameLabel.height)];
        [_downloadBtn setTitle:@"下载" forState:(UIControlStateNormal)];
        [_downloadBtn addTarget:self action:@selector(downloadMovie) forControlEvents:(UIControlEventTouchUpInside)];
        [_downloadBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _downloadBtn;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(_downloadBtn.left, _downloadBtn.bottom + 5, _downloadBtn.width, _downloadBtn.height)];
        _statusLabel.backgroundColor = [UIColor orangeColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = Font(14.f);
    }
    return _statusLabel;
}

- (CuttingLine *)cuttingLine
{
    if (!_cuttingLine) {
        _cuttingLine = [[CuttingLine alloc] initWithFrame:CGRectMake(0, _filePathLabel.bottom + 4.f, ScreenWidth, 1.f)];
        [_cuttingLine setLineWidth:1.f];
        [_cuttingLine setStrokeColor:[UIColor lightGrayColor]];
        [_cuttingLine setBackgroundColor:[UIColor whiteColor]];
    }
    return _cuttingLine;
}

- (void)downloadMovie
{
    if ([self.delegate respondsToSelector:@selector(downloadMovie:)])
    {
        [self.delegate downloadMovie:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
