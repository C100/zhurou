//
//  WithdrawCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WithdrawCell.h"

@implementation WithdrawCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self selectedButton];
//        [self orderMoneyLabel];
    }
    return self;
}

//-(void)setInfos:(NSArray *)infos{
//    _infos = infos;
//    NSString *isShow = infos[1];
//    if ([isShow isEqualToString:@"已完成"]||[isShow isEqualToString:@"待评价"]) {
//        self.selectedButton.hidden = NO;
//        self.backgroundColor = [UIColor whiteColor];
//    }else{
//        self.selectedButton.hidden = YES;
//        self.backgroundColor = kF5F5F5Color;
//    }
//    self.orderMoneyLabel.text = infos[0];
//    self.orderStatusLabel.text = infos[1];
//    self.orderDateLabel.text = infos[2];
//    self.commisionLabel.text = [NSString stringWithFormat:@"¥%@",infos[3]];
//}
-(void)setModel:(WithdrawModel *)model{
    _model = model;
    if ([[LUtils orderStatusWithStatus:model.status] isEqualToString:@"已完成"]||[[LUtils orderStatusWithStatus:model.status] isEqualToString:@"待评价"]) {
        self.selectedButton.hidden = NO;
        self.backgroundColor = [UIColor whiteColor];
    }else{
        self.selectedButton.hidden = YES;
        self.backgroundColor = kF5F5F5Color;
    }
    self.orderMoneyLabel.text = [NSString stringWithFormat:@"订单金额：%.2f",model.totalMoney.floatValue/100];
    self.orderStatusLabel.text = [LUtils orderStatusWithStatus:model.status];
    self.orderDateLabel.text = [self stringToDate:model.createTime.stringValue];
    self.commisionLabel.text = [NSString stringWithFormat:@"¥%.2f",model.withdrawMoney.floatValue/100];

    
}


#pragma mark life circle
-(UIButton *)selectedButton{
    if (!_selectedButton) {
        _selectedButton = [UIButton buttonWithTitle:@"" titleColor:nil font:0 imageName:@"weigouxuan@2x" target:nil action:nil];
        _selectedButton.selected = NO;
        _selectedButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //[_selectedButton setImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
        [_selectedButton setImage:[UIImage imageNamed:@"yigouxuan"] forState:UIControlStateSelected];
        [self addSubview:_selectedButton];
        [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(79);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _selectedButton;
}

-(UILabel *)orderMoneyLabel{
    if (!_orderMoneyLabel) {
        _orderMoneyLabel = [UILabel labelWithTitle:@"" color:k555555Color font:kFont(14)];
        [self addSubview:_orderMoneyLabel];
        [_orderMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectedButton.mas_right).mas_equalTo(16);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(22);
        }];
        
    }
    return _orderMoneyLabel;
}

-(UILabel *)orderStatusLabel{
    if (!_orderStatusLabel) {
        _orderStatusLabel = [UILabel labelWithTitle:@"" color:k555555Color font:kFont(14)];
        [self addSubview:_orderStatusLabel];
        [_orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(22);
        }];
        
    }
    return _orderStatusLabel;
}

-(UILabel *)orderDateLabel{
    if (!_orderDateLabel) {
        _orderDateLabel = [UILabel labelWithTitle:@"" color:k888888Color font:kFont(14)];
        [self addSubview:_orderDateLabel];
        [_orderDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(40);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(self.orderMoneyLabel.mas_bottom).mas_equalTo(14);
        }];
        
    }
    return _orderDateLabel;
}

-(UILabel *)commisionLabel{
    if (!_commisionLabel) {
        _commisionLabel = [UILabel labelWithTitle:@"" color:kDefinedColor font:[UIFont systemFontOfSize:16]];
        [self addSubview:_commisionLabel];
        [_commisionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(16);
            make.top.mas_equalTo(self.orderStatusLabel.mas_bottom).mas_equalTo(12);
        }];
        
    }
    return _commisionLabel;
}


-(NSString *)stringToDate:(NSString *)date{
    long long time=[date longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString*timeString=[formatter stringFromDate:d];
    return timeString;
}


@end
