//
//  ApplyRecordCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ApplyRecordCell.h"

@implementation ApplyRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setLeftView];
        [self setRightView];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"youxiaoyouhuiquan"]];
        _bgImageView.userInteractionEnabled = YES;
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
    }
    return _bgImageView;
}

-(void)setLeftView{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    [self.bgImageView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(136);
    }];
    
    self.bgLabel = [[TCCopyableLabel alloc]init];
    [self.bgLabel setDelegate:self];
    [bgView addSubview:self.bgLabel];
    [self.bgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.bgLabel.textColor = [UIColor clearColor];
    self.bgLabel.backgroundColor = [UIColor clearColor];
    

    self.codeLabel = [[TCCopyableLabel alloc]init];
    self.codeLabel.text = @"12345";
    self.codeLabel.textColor = k555555Color;
    self.codeLabel.font = kMediumFont(13);
    self.codeLabel.textAlignment = NSTextAlignmentCenter;
    self.codeLabel.numberOfLines = 0;
//    [self.codeLabel setDelegate:self];
    
    [bgView addSubview:self.codeLabel];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3);
        make.right.mas_equalTo(-3);
//        make.height.mas_equalTo(18);
        make.top.mas_equalTo(3);
    }];
    
    self.availableLabel = [UILabel labelWithTitle:@"可使用" color:k888888Color font:kLightFont(12)];
    [bgView addSubview:self.availableLabel];
    [self.availableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.codeLabel.mas_bottom).mas_equalTo(5);
//        make.height.mas_equalTo(12);
//        make.bottom.mas_equalTo();
    }];
}



-(void)setRightView{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    [self.bgImageView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(KHScreenW-136);
    }];
    
    self.nameLabel = [UILabel labelWithTitle:@"张三" color:k555555Color font:kMediumFont(14)];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(14);
        make.top.mas_equalTo(13);
    }];
    
    self.phoneLabel = [UILabel labelWithTitle:@"18758105737" color:k555555Color font:kLightFont(14)];
    [bgView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(4);
        make.height.mas_equalTo(14);
    }];
    
    self.timeLabel = [UILabel labelWithTitle:@"2017-6-20 - 2017-6-30" color:k888888Color font:kLightFont(12)];
    [bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).mas_equalTo(15);
        make.height.mas_equalTo(12);
    }];
}

-(void)setModel:(codeModel *)model{
    _model = model;
    self.bgLabel.text = model.promotionCode;
    self.codeLabel.text = model.promotionCode;
    self.nameLabel.text = model.name;
    self.phoneLabel.text = model.cellphone;
    NSString *time = [NSString stringWithFormat:@"%@ - %@",[LUtils stringToDate:[model.startTime stringValue]],[LUtils stringToDate:[model.endTime stringValue]]];
    self.timeLabel.text = time;
    self.availableLabel.text = [self codeStatusWithStatus:model.status];
    if ([self.availableLabel.text isEqualToString:@"可使用"]) {
        self.bgImageView.image = [UIImage imageNamed:@"youxiaoyouhuiquan"];
        self.availableLabel.text = @"可使用 长按复制";
        self.bgImageView.userInteractionEnabled = YES;
    }else{
        self.bgImageView.image = [UIImage imageNamed:@"shixiaoyouhuiquan"];
        self.bgImageView.userInteractionEnabled = NO;
    }
    
}

-(NSString *)codeStatusWithStatus:(NSNumber *)status{
    switch (status.intValue) {
        case 1:
            return @"可使用";
            break;
        case 2:
            return @"已使用";
            break;
        case 3:
            return @"已过期";
            break;
        default:
            return @"";
            break;
    }
}

@end
