//
//  BackProMoneyCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProMoneyCell.h"

@implementation BackProMoneyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.receiveButton = [[UIButton alloc]init];
        [self.receiveButton setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.receiveButton setTitleColor:k888888Color forState:UIControlStateNormal];
        self.receiveButton.titleLabel.font = kFont(12);
        self.receiveButton.layer.borderWidth = 1;
        self.receiveButton.layer.borderColor = kDDDDDDColor.CGColor;
        [self.receiveButton setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.receiveButton];
        [self.receiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(60, 20));
            make.centerY.mas_equalTo(0);
        }];
        
        self.seeLoButton = [[UIButton alloc]init];
        [self.seeLoButton setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.seeLoButton setTitleColor:k888888Color forState:UIControlStateNormal];
        self.seeLoButton.titleLabel.font = kFont(12);
        self.seeLoButton.layer.borderWidth = 1;
        self.seeLoButton.layer.borderColor = kDDDDDDColor.CGColor;
        [self.seeLoButton setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.seeLoButton];
        [self.seeLoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.receiveButton.mas_left).mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(60, 20));
            make.centerY.mas_equalTo(0);
        }];
        
        self.moneyLabel = [Tool labelWithTitle:@"总金额：￥1664" color:k888888Color fontSize:12 alignment:0];
        [self addSubview:self.moneyLabel];
        self.moneyLabel.font = [UIFont systemFontOfSize:12];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(13);
            make.bottom.mas_equalTo(-13);
            make.height.mas_equalTo(12);
            make.right.mas_equalTo(self.seeLoButton.mas_left).mas_equalTo(-10);
        }];
    }
    return self;
}

-(void)setBackProModel:(BackProductModel *)backProModel{
    _backProModel = backProModel;
    self.moneyLabel.text = [NSString stringWithFormat:@"总金额：￥%.2f",backProModel.money.floatValue/100];
    if (backProModel.status.intValue==1) {//申请中
        self.receiveButton.hidden = YES;
        self.seeLoButton.hidden = YES;
    }else{
        if (backProModel.status.intValue!=2) {
            self.receiveButton.hidden = NO;
            self.seeLoButton.hidden = YES;
            [self.receiveButton setTitle:@"再次购买" forState:UIControlStateNormal];
        }else{
            self.seeLoButton.hidden = NO;
            self.receiveButton.hidden = NO;
            [self.receiveButton setTitle:@"确认收货" forState:UIControlStateNormal];
        }
        
    }
}

@end
