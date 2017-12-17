//
//  dispatchInfoCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/1.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "dispatchInfoCell.h"

@implementation dispatchInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.dateLabel = [Tool labelWithTitle:@"11-21" color:kB0B0B0Color fontSize:10 alignment:0];
        [self addSubview:self.dateLabel];
        [self sizeToFit];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(12);
            make.width.mas_equalTo(self.dateLabel.bounds.size.width);
        }];
        
        self.timeLabel = [Tool labelWithTitle:@"14:32" color:kB0B0B0Color fontSize:10 alignment:2];
        [self addSubview:self.timeLabel];
        [self sizeToFit];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.dateLabel.mas_right);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(12);
            //            make.width.mas_equalTo(self.dateLabel.bounds.size.width);
        }];
        
        UILabel *corLabel = [Tool labelWithTitle:@"" color:kD1D1D1Color fontSize:0 alignment:0];
        corLabel.backgroundColor = kD1D1D1Color;
        corLabel.layer.cornerRadius = 3;
        corLabel.layer.masksToBounds = YES;
        [self addSubview:corLabel];
        [corLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dateLabel.mas_right).mas_equalTo(13);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(6, 6));
        }];
        
        self.instructionLabel = [Tool labelWithTitle:@"快件从 上海中心 发出" color:k5F5F5FColor fontSize:12 alignment:0];
        self.instructionLabel.numberOfLines = 0;
        [self addSubview:self.instructionLabel];
        [self.instructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(corLabel.mas_right).mas_equalTo(25);
            make.right.mas_equalTo(-30);
            make.bottom.mas_equalTo(-26);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kD8D8D8Color;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(corLabel.mas_bottom).mas_equalTo(0);
            make.centerX.mas_equalTo(corLabel.mas_centerX);
            make.width.mas_equalTo(0.5);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

@end
