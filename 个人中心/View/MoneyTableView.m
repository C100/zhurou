//
//  MoneyTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MoneyTableView.h"
#import "WithdrawModel.h"

@implementation MoneyTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.tableFooterView = [[UIView alloc]init];
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([self.type isEqualToString:@"我的佣金"]) {
                cell.textLabel.text = @"佣金总计";
            }else{
                cell.textLabel.text = @"提现总计";
            }
            
            cell.textLabel.textColor = k4D4D4DColor;
            cell.textLabel.font = kFont(15);
            
            cell.detailTextLabel.textColor = kD02E27Color;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2f",self.totalMoney/100.0];
            cell.detailTextLabel.font = kLightFont(17);
        }
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([self.type isEqualToString:@"我的佣金"]) {
                NSDictionary *infoDic = self.infos[indexPath.row-1];
                cell.textLabel.text = @"二级佣金1.00元";
                NSNumber *levelNum = infoDic[@"level"];
                NSNumber *moneyNum = infoDic[@"money"];
                if (levelNum.intValue==2) {
                    cell.textLabel.text = [NSString stringWithFormat:@"二级佣金%.2f元",moneyNum.floatValue/100];
                }else{
                    cell.textLabel.text = [NSString stringWithFormat:@"三级佣金%.2f元",moneyNum.floatValue/100];
                }
                NSNumber *timeNum = infoDic[@"ctime"];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[LUtils stringToDateAndTime:timeNum.stringValue]];
            }else{
                WithdrawModel *model = self.infos[indexPath.row-1];
                cell.textLabel.text = [NSString stringWithFormat:@"提现%.2f元",model.totalMoney.floatValue/100];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[LUtils stringToDateAndTime:model.withdrawTime.stringValue]];
            }
            
            
            cell.textLabel.textColor = k4D4D4DColor;
            cell.textLabel.font = kFont(15);
            
            cell.detailTextLabel.textColor = k9A9A9AColor;
            
            cell.detailTextLabel.font = kLightFont(12);
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
