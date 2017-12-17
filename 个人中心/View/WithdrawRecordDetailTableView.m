//
//  WithdrawRecordDetailTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WithdrawRecordDetailTableView.h"

@implementation WithdrawRecordDetailTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc]init];
        self.backgroundColor = kF5F5F5Color;
        
        self.titles = @[@"状态",@"提现佣金",@"日期",@"持卡人",@"卡户号",@"开户行",@"手机号"];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.font = kLightFont(14);
        cell.textLabel.textColor = k888888Color;
        cell.detailTextLabel.font = kLightFont(14);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.titles[indexPath.row];
        cell.detailTextLabel.text = self.details[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextLabel.textColor = kED8677Color;
        }else if(indexPath.row==1){
            cell.detailTextLabel.textColor = kDefinedColor;
        }else{
            cell.detailTextLabel.textColor = k888888Color;
        }
    }else{
        cell.textLabel.text = self.titles[indexPath.row+3];
        cell.detailTextLabel.text = self.details[indexPath.row+3];
        cell.detailTextLabel.textColor = k888888Color;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

@end
