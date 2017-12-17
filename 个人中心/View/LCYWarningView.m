//
//  WarningView.m
//  XiJuOBJ
//
//  Created by 刘岑颖 on 2017/12/16.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "LCYWarningView.h"

@implementation LCYWarningView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [LUtils colorHex:@"#FFF8EB"];
        [self leftImageView];
        [self deleteButton];
        [self warningLabel];
    }
    return self;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"注意"]];
        [self addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(18);
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _leftImageView;
}

- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setImage:[UIImage imageNamed:@"叉叉"] forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(38);
            make.right.mas_equalTo(0);
        }];
    }
    return _deleteButton;
}

- (UILabel *)warningLabel{
    if (!_warningLabel) {
        _warningLabel = [[UILabel alloc] init];
        _warningLabel.textColor = [LUtils colorHex:@"#E8B85D"];
        _warningLabel.font = [UIFont systemFontOfSize:14];
        _warningLabel.text = @"一经操作后无法撤销";
        [self addSubview:_warningLabel];
        [_warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_leftImageView.mas_right).mas_equalTo(8);
            make.right.mas_equalTo(_deleteButton.mas_left).mas_equalTo(-8);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _warningLabel;
}

@end
