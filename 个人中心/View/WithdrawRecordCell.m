//
//  WithdrawRecordCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WithdrawRecordCell.h"

@implementation WithdrawRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.priceLabel = [UILabel labelWithTitle:@"" color:kDefinedColor font:kLightFont(16)];
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(22);
            make.height.mas_equalTo(16);
        }];
        
        self.timeLabel = [UILabel labelWithTitle:@"" color:k888888Color font:kLightFont(14)];
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_equalTo(12);
            make.height.mas_equalTo(14);
        }];
        
        UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiayibu"]];
        [self addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-9.6);
            make.height.mas_equalTo(14);
            make.centerY.mas_equalTo(0);
        }];
        
        self.statusLabel = [UILabel labelWithTitle:@"" color:kED8677Color font:kLightFont(14)];
        [self addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(arrowImageView.mas_left).mas_equalTo(-6);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(14);
        }];
        
        
    }
    return self;
}

//-(void)setRecords:(NSArray *)records{
//    _records = records;
//    self.priceLabel.text = records[0];
//    self.timeLabel.text = records[1];
//    self.statusLabel.text = records[2];
////    if ([self.statusLabel.text isEqualToString:@"提现成功"]||[self.statusLabel.text isEqualToString:@"已发放"]) {
//        self.statusLabel.textColor = kED8677Color;
////    }else{
////        self.statusLabel.textColor = k94C0BCColor;
////    }
//}

-(void)setModel:(WithdrawModel *)model{
    _model = model;
    if (model.withdrawTime) {
        self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.totalMoney.floatValue/100];
        self.timeLabel.text = [LUtils stringToDate:model.withdrawTime.stringValue];
        self.statusLabel.text = [self withdrawStatus:model.withdrawStatus];
    }else{
        self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.withdrawMoney.floatValue/100];
        self.timeLabel.text = [self stringToDate:model.createTime.stringValue];
        self.statusLabel.text = [LUtils orderStatusWithStatus:model.status];
    }
    
    
}

-(NSString *)stringToDate:(NSString *)date{
    long long time=[date longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString*timeString=[formatter stringFromDate:d];
    return timeString;
}


-(NSString *)withdrawStatus:(NSNumber *)status{
    if (status.intValue==0) {
        return @"待处理";
    }else if (status.intValue==1){
        return @"提现成功";
    }else{
        return @"";
    }
}




@end
