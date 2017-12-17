//
//  logisticsInfoCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/1.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "logisticsInfoCell.h"

@implementation logisticsInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"物流 (2)"]];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(20, 14));
            make.centerY.mas_equalTo(0);
        }];
        
        UILabel *sellerLabel = [Tool labelWithTitle:@"物流公司：" color:kB0B0B0Color fontSize:14 alignment:0];
        [self addSubview:sellerLabel];
        [sellerLabel sizeToFit];
        [sellerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconImageView.mas_right).mas_equalTo(14);
            make.top.mas_equalTo(11);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(sellerLabel.bounds.size.width);
        }];
        
        self.sellerLabel = [Tool labelWithTitle:@"顺丰" color:[UIColor blackColor] fontSize:14 alignment:0];
        [self addSubview:self.sellerLabel];
        [self.sellerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(sellerLabel.mas_right).mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(11);
        }];
        
        UILabel *numLabel = [Tool labelWithTitle:@"物流单号：" color:kB0B0B0Color fontSize:14 alignment:0];
        [self addSubview:numLabel];
        [numLabel sizeToFit];
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconImageView.mas_right).mas_equalTo(14);
            make.top.mas_equalTo(sellerLabel.mas_bottom).mas_equalTo(6);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(numLabel.bounds.size.width);
            make.bottom.mas_equalTo(-11);
        }];
        
        self.numLabel = [Tool labelWithTitle:@"2890388650787" color:[UIColor blackColor] fontSize:14 alignment:0];
        [self addSubview:self.numLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(numLabel.mas_right).mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(sellerLabel.mas_bottom).mas_equalTo(6);
        }];
    }
    return self;
}

@end
