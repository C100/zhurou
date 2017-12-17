//
//  MarketAndBackTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MarketAndBackTableView.h"
#import "MarketAndBackCell.h"

@implementation MarketAndBackTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc]init];
        
        //注册
        [self registerClass:[MarketAndBackCell class] forCellReuseIdentifier:@"MarketAndBackCell"];
        
        self.estimatedRowHeight = 60;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infos.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
            cell.textLabel.textColor = k4D4D4DColor;
            cell.textLabel.font = kFont(15);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.textColor = kD02E27Color;
            
            cell.detailTextLabel.font = kLightFont(17);
        }
        if ([self.type isEqualToString:@"商城消费"]) {
            cell.textLabel.text = @"商城消费总计";
        }else{
            cell.textLabel.text = @"退款明细";
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2f",self.totalMoney/100];
        
        return cell;
    }else{
        MarketAndBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketAndBackCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *infoDic = self.infos[indexPath.row-1];
        if ([self.type isEqualToString:@"商城消费"]) {
            cell.orderNumLabel.text = [NSString stringWithFormat:@"订单编号：10000000%@",infoDic[@"id"]];
            NSString *time = infoDic[@"payTime"];
            cell.timeLabel.text = [LUtils stringToDateAndTime:@(time.longLongValue*1000).stringValue];
            NSNumber *money = infoDic[@"netAmount"];
            cell.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",money.floatValue/100];
        }else{
            cell.orderNumLabel.text = [NSString stringWithFormat:@"订单编号：10000000%@",infoDic[@"receiptId"]];
            cell.timeLabel.text = [LUtils stringToDateAndTime:infoDic[@"ctime"]];
            NSNumber *money = infoDic[@"money"];
            cell.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",money.floatValue/100];
        }
        
        
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)setInfos:(NSArray *)infos{
    _infos = infos;
    [self reloadData];
}

@end
