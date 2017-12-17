//
//  WelfareTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/15.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WelfareTableView.h"

@implementation WelfareTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = The_list_backgroundColor;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.textColor = The_wordsColor;
        
        cell.textLabel.font = [UIFont fontWithName:The_titleFont size:15];
        cell.separatorInset = UIEdgeInsetsMake(16,10,15,0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        cell.detailTextLabel.textColor = The_wordsColor;
        cell.detailTextLabel.font = [UIFont fontWithName:The_titleFont size:15];
        
    }
    NSArray *arr = self.contents[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    if (indexPath.section==0) {
        cell.detailTextLabel.text = @"已认证";
        cell.detailTextLabel.textColor = kDefinedColor;
        cell.accessoryType=UITableViewCellAccessoryNone;
    }else{
        if (indexPath.row == 0) {
            if (self.totalMoney) {
                cell.detailTextLabel.text = self.totalMoney;
            }else{
                cell.detailTextLabel.text = @"0";
            }
            
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        if (indexPath.row==1) {
            if (self.withdrawMoney) {
                cell.detailTextLabel.text = self.withdrawMoney;
            }else{
                cell.detailTextLabel.text = @"0";
            }
            
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self.welfareTableViewDelegate selectIndexPathRow:indexPath.row];
    }
}

-(NSArray *)contents{
    if (_contents == nil) {
        _contents = @[@[@"认证状态"],@[@"佣金总金额",@"可提现佣金",@"佣金提现",@"获取优惠码",@"订单记录"]];
    }
    return _contents;
}

-(void)setWithdrawMoney:(NSString *)withdrawMoney{
    _withdrawMoney = withdrawMoney;
    [self reloadData];
}

@end
