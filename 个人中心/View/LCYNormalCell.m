//
//  LCYNormalCell.m
//  XiJuOBJ
//
//  Created by 刘岑颖 on 2017/12/16.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "LCYNormalCell.h"

@implementation LCYNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self leftLabel];
        [self rightLabel];
    }
    return self;
}

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        [self addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
        }];
        _leftLabel.textColor = [LUtils colorHex:@"#888888"];
        _leftLabel.font = [UIFont systemFontOfSize:14];
        _leftLabel.text = @"left";
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        [self addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.leftLabel.mas_right).mas_equalTo(5);
        }];
        _rightLabel.textColor = [LUtils colorHex:@"#333333"];
        _rightLabel.font = [UIFont systemFontOfSize:14];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.text = @"right";
    }
    return _rightLabel;
}

@end
