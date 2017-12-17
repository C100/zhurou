//
//  dispatchStateCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/1.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "dispatchStateCell.h"

@implementation dispatchStateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.dateLabel = [Tool labelWithTitle:@"11-21" color:kB0B0B0Color fontSize:14 alignment:2];
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
            make.top.mas_equalTo(self.dateLabel.mas_bottom).mas_equalTo(0);
            make.height.mas_equalTo(12);
//            make.width.mas_equalTo(self.dateLabel.bounds.size.width);
        }];
        
        UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"物流状态"]];
        self.iconImageView = iconImageView;
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dateLabel.mas_right).mas_equalTo(8);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        UILabel *corLabel = [Tool labelWithTitle:@"" color:kD1D1D1Color fontSize:0 alignment:0];
        self.corLabel = corLabel;
        corLabel.backgroundColor = kD1D1D1Color;
        corLabel.layer.cornerRadius = 3;
        corLabel.layer.masksToBounds = YES;
        corLabel.hidden = YES;
        [self addSubview:corLabel];
        [corLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dateLabel.mas_right).mas_equalTo(13);
            make.top.mas_equalTo(3);
            make.size.mas_equalTo(CGSizeMake(6, 6));
        }];
        
        self.stateLabel = [Tool labelWithTitle:@"派送中" color:k5F5F5FColor fontSize:14 alignment:0];
        [self addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconImageView.mas_right).mas_equalTo(20);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(-30);
        }];
        
        self.instructionLabel = [Tool labelWithTitle:@"[杭州市]杭州拱墅区派件员：张三16278778798" color:k5F5F5FColor fontSize:12 alignment:0];
        self.instructionLabel.numberOfLines = 0;
        [self addSubview:self.instructionLabel];
        [self.instructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.stateLabel.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(iconImageView.mas_right).mas_equalTo(20);
            make.right.mas_equalTo(-30);
            make.bottom.mas_equalTo(-26);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        self.lineView = lineView;
        lineView.backgroundColor = kD8D8D8Color;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(iconImageView.mas_bottom).mas_equalTo(0);
            make.centerX.mas_equalTo(iconImageView.mas_centerX);
            make.width.mas_equalTo(0.5);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)setInfos:(NSArray *)infos{
    _infos = infos;
    self.lineView.hidden = NO;
    self.stateLabel.textColor = k555555Color;
    self.instructionLabel.textColor = k888888Color;
    self.dateLabel.textColor = k888888Color;
    self.timeLabel.textColor = k888888Color;
    if (infos.count==2) {
        self.dateLabel.font = kFont(14);
        self.stateLabel.hidden = NO;
        self.corLabel.hidden = YES;
        self.iconImageView.hidden = NO;
        self.stateLabel.text = infos.firstObject;
        self.instructionLabel.text = infos.lastObject;
        [self.instructionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.stateLabel.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(20);
            make.right.mas_equalTo(-30);
            make.bottom.mas_equalTo(-26);
        }];
        
        if ([infos.firstObject isEqualToString:@"已揽件"]) {
            self.lineView.hidden = YES;
            self.iconImageView.image = [UIImage imageNamed:@"物流状态"];
        }
        if ([infos.firstObject isEqualToString:@"派送中"]) {
            self.iconImageView.image = [UIImage imageNamed:@"勾"];
            self.stateLabel.textColor = The_MainColor;
            self.instructionLabel.textColor = The_MainColor;
            self.dateLabel.textColor = The_MainColor;
            self.timeLabel.textColor = The_MainColor;
        }
        
    }else{
        self.dateLabel.font = kFont(10);
        self.stateLabel.hidden = YES;
        self.corLabel.hidden = NO;
        self.iconImageView.hidden = YES;
        self.instructionLabel.text = infos.firstObject;
        [self.instructionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(20);
            make.right.mas_equalTo(-30);
            make.bottom.mas_equalTo(-26);
        }];
    }
    
    
}

@end
