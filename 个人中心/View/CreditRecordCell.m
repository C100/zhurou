//
//  CreditRecordCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "CreditRecordCell.h"

@implementation CreditRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"头像"]];
//        [self addSubview:self.iconImageView];
//        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.top.mas_equalTo(12);
//            make.bottom.mas_equalTo(-12);
//            make.size.mas_equalTo(CGSizeMake(44, 44));
//        }];
        
        self.nameLabel = [Tool labelWithTitle:@"" color:k4D4D4DColor fontSize:16 alignment:0];
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(12);
            make.height.mas_equalTo(22);
        }];
        [self.nameLabel sizeToFit];
        
        
        self.timeLabel = [Tool labelWithTitle:@"托管：2017-06-20" color:k888888Color fontSize:12 alignment:0];
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(9);
            make.height.mas_equalTo(12);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-13);
        }];
        
        self.moneyLabel = [Tool labelWithTitle:@"¥22400.00" color:k4D4D4DColor fontSize:16 alignment:1];
        self.moneyLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-16);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(16);
        }];
    }
    return self;
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    self.nameLabel.text = infoDic[@"nominal"];
    self.timeLabel.text = [NSString stringWithFormat:@"托管：%@",[LUtils stringToDate:infoDic[@"createStamp"]]];
    NSString *money = infoDic[@"showMoney"];
    if ([money componentsSeparatedByString:@"-"].count==2) {
        NSString *moneyStr = [money componentsSeparatedByString:@"-"].lastObject;
        self.moneyLabel.text = [NSString stringWithFormat:@"-¥%.2f",moneyStr.floatValue];
    }else{
        NSString *moneyStr = [money componentsSeparatedByString:@"+"].lastObject;
        self.moneyLabel.text = [NSString stringWithFormat:@"+¥%.2f",moneyStr.floatValue];
    }
    
}

@end
