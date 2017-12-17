//
//  OrderRecordTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/22.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "OrderRecordTableView.h"

@implementation OrderRecordTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kF5F5F5Color;
        self.titles = @[@[@"优惠码"],@[@"订单编号",@"订单时间",@"订单状态",@"订单金额"],@[@"客户姓名",@"客户号码"],@[@"预计返利",@"返利状态"]];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 2;
            break;
        default:
            break;
    }
    return 0;
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
    
    NSArray *titles = self.titles[indexPath.section];
    NSArray *arr = self.details[indexPath.section];
    cell.textLabel.text = titles[indexPath.row];
    cell.detailTextLabel.text = arr[indexPath.row];
    if (indexPath.section == 0) {
        cell.detailTextLabel.textColor = k555555Color;
    }else if (indexPath.section == 1&& indexPath.row==0) {
        if ([cell.detailTextLabel.text isEqualToString:@"过期"]) {
            cell.detailTextLabel.textColor = k94C0BCColor;
        }else{
            cell.detailTextLabel.textColor = [UIColor colorWithRed:211/255.0 green:24/255.0 blue:21/255.0 alpha:1.0];
        }
    }else{
        cell.detailTextLabel.textColor = k888888Color;
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

@end
