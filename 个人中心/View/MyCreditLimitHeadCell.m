//
//  MyCreditLimitHeadCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyCreditLimitHeadCell.h"

@implementation MyCreditLimitHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleLabel = [Tool labelWithTitle:@"信用额度" color:k333333Color fontSize:14 alignment:0];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(22);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(14);
        }];
        
        
        UILabel *mLabel = [Tool labelWithTitle:@"¥" color:k333333Color fontSize:24 alignment:0];
        mLabel.font = [UIFont systemFontOfSize:24];
        [mLabel sizeToFit];
        [self addSubview:mLabel];
        [mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(26);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        self.depositButton = [[UIButton alloc]init];
        [self.depositButton setTitle:@"托管" forState:UIControlStateNormal];
        [self addSubview:self.depositButton];
        [self.depositButton setTitleColor:The_MainColor forState:UIControlStateNormal];
        self.depositButton.titleLabel.font = kFont(14);
        [self.depositButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-14);
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        self.depositButton.layer.borderWidth = 1;
        self.depositButton.layer.cornerRadius = 4;
        self.depositButton.layer.borderColor = The_MainColor.CGColor;
        
        self.moneyLabel = [Tool labelWithTitle:@"0.00" color:k333333Color fontSize:36 alignment:0];
        [self addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(mLabel.mas_right).mas_equalTo(0);
            make.right.mas_equalTo(self.depositButton.mas_left).mas_equalTo(-5);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(-20);
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(16);
        }];
    }
    return self;
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    NSNumber *money = infoDic[@"moneyCount"];
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",money.floatValue];
}

@end
