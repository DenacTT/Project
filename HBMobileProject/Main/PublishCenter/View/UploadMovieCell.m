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
        [self addSubview:self.statusLabel];
        [self addSubview:self.downloadBtn];
    }
    return self;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenWidth - 15 * 2 - 60, self.height / 2 - 15 * 2 - 5)];
        _nameLabel.backgroundColor = [UIColor redColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = Font(12.f);
    }
    return _nameLabel;
}

- (UILabel *)filePathLabel
{
    if (!_filePathLabel) {
        _filePathLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom + 5, _nameLabel.width, _nameLabel.height)];
        _filePathLabel.backgroundColor = [UIColor blueColor];
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
    }
    return _downloadBtn;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(_downloadBtn.left, -_downloadBtn.bottom + 10, _downloadBtn.width, _downloadBtn.height)];
        _statusLabel.backgroundColor = [UIColor orangeColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = Font(14.f);
    }
    return _statusLabel;
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
