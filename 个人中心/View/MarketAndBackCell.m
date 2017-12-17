//
//  MarketAndBackCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MarketAndBackCell.h"

@implementation MarketAndBackCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.moneyLabel = [Tool labelWithTitle:@"¥200.00" color:k272F3FColor fontSize:15 alignment:2];
        self.moneyLabel.font = kLightFont(15);
        [self.moneyLabel sizeToFit];
        [self addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(20);
//            make.width.mas_equalTo(self.moneyLabel.bounds.size.width+15);
        }];
        
        
        
        self.orderNumLabel = [Tool labelWithTitle:@"订单编号：2732738127327132" color:k5F5F5FColor fontSize:14 alignment:0];
        [self addSubview:self.orderNumLabel];
        [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.moneyLabel.mas_left).mas_equalTo(-10);
        }];
        
        self.timeLabel = [Tool labelWithTitle:@"2017-11-23  23:00" color:k9A9A9AColor fontSize:12 alignment:0];
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.orderNumLabel.mas_bottom).mas_equalTo(5);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(15);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-5);
        }];
    }
    return self;
}

@end
