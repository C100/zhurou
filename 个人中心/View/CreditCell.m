//
//  CreditCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "CreditCell.h"

@implementation CreditCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self cardNumLabel];
    }
    return self;
}

//-(void)setInfos:(NSArray *)infos{
//    _infos = infos;
//    self.bankLabel.text = infos[0];
//    self.cardNumLabel.text = [NSString stringWithFormat:@"尾号%@",infos[1]];
//    
//}

-(void)setModel:(CreditCardModel *)model{
    _model = model;
    self.bankLabel.text = model.openBank;
    NSString *num = @"";
    if (model.openNumber.length>4) {
        num = [model.openNumber substringFromIndex:model.openNumber.length-4];
    }else{
        num = model.openNumber;
    }
    
    self.cardNumLabel.text = [NSString stringWithFormat:@"尾号%@",num];
}

-(UIButton *)selectButton{
    if (_selectButton == nil) {
        _selectButton = [UIButton buttonWithTitle:@"" titleColor:nil font:nil imageName:@"weigouxuan" target:nil action:nil];
        [_selectButton setImage:[UIImage imageNamed:@"yigouxuan"] forState:UIControlStateSelected];
        _selectButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _selectButton.selected = NO;
        [self addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(14, 76));
            make.centerY.mas_equalTo(0);
        }];
    }
    return _selectButton;
}

-(UILabel *)bankLabel{
    if (_bankLabel == nil) {
        _bankLabel = [UILabel labelWithTitle:@"" color:k555555Color font:[UIFont fontWithName:@"STHeitiSC-Medium" size:16]];
        [self addSubview:_bankLabel];
        [_bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectButton.mas_right).mas_equalTo(16);
            make.top.mas_equalTo(18);
            make.height.mas_equalTo(16);
        }];
    }
    return _bankLabel;
}

-(UILabel *)cardNumLabel{
    if (_cardNumLabel == nil) {
        _cardNumLabel = [UILabel labelWithTitle:@"" color:k888888Color font:kLightFont(14)];
        [self addSubview:_cardNumLabel];
        [_cardNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectButton.mas_right).mas_equalTo(16);
            make.top.mas_equalTo(self.bankLabel.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(16);
        }];
        
        UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiayibu"]];
        [self addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-9.6);
            make.size.mas_equalTo(CGSizeMake(7.4, 14));
            make.centerY.mas_equalTo(0);
        }];
    }
    return _cardNumLabel;
}

@end
