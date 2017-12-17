//
//  CreditInfoCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "CreditInfoCell.h"

@implementation CreditInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleLabel = [Tool labelWithTitle:@"其中提前交割" color:k333333Color fontSize:14 alignment:0];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(85, 14));
        }];
        
        self.moneyLabel = [UILabel labelWithTitle:@"¥600.00" color:k333333Color fontSize:14 alignment:0];
        [self addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right).mas_equalTo(5);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(12);
            make.height.mas_equalTo(14);
            make.bottom.mas_equalTo(-12);
        }];
    }
    return self;
}

@end
