//
//  MyCreditLimitTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyCreditLimitTableView.h"
#import "MyCreditLimitHeadCell.h"
#import "CreditInfoCell.h"
#import "CreditRecordCell.h"

@implementation MyCreditLimitTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        //注册
        [self registerClass:[MyCreditLimitHeadCell class] forCellReuseIdentifier:@"MyCreditLimitHeadCell"];
        [self registerClass:[CreditInfoCell class] forCellReuseIdentifier:@"CreditInfoCell"];
        [self registerClass:[CreditRecordCell class] forCellReuseIdentifier:@"CreditRecordCell"];
        
        self.estimatedRowHeight = 60;
        self.tableFooterView = [[UIView alloc]init];
        self.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
        
        self.titles = @[@"可用信用额度",@"提前交割额度",@"可托管额度",@"未交割额度"];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1+self.titles.count;
    }
    return self.records.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            MyCreditLimitHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCreditLimitHeadCell" forIndexPath:indexPath];
            cell.infoDic = self.creditInfoDic;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.depositButton addTarget:self action:@selector(depositAction)];
            return cell;
        }
        else{
            CreditInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreditInfoCell" forIndexPath:indexPath];
            cell.titleLabel.text = self.titles[indexPath.row-1];
            switch (indexPath.row-1) {
                case 0:
                {
                    NSNumber *money = self.creditInfoDic[@"balance"];
                    cell.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",money.floatValue];
                }
                    break;
                case 1:
                {
                    NSNumber *money = self.creditInfoDic[@"delivery"];
                    cell.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",money.floatValue];
                }
                    
                    break;
                case 2:
                {
                    NSNumber *money = self.creditInfoDic[@"live"];
                    cell.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",money.floatValue];
                }
                    
                    break;
                case 3:
                {
                    NSNumber *money = self.creditInfoDic[@"late"];
                    cell.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",money.floatValue];
                }
                    
                    break;
                default:
                    break;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        CreditRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreditRecordCell" forIndexPath:indexPath];
        cell.infoDic = self.records[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 47;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, 47)];
    bgView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [Tool labelWithTitle:@"变动记录" color:k4D4D4DColor fontSize:16 alignment:0];
    [bgView addSubview:titleLabel];
    titleLabel.frame = CGRectMake(10, 11, KHScreenW-10, 22);
    
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)depositAction{
    [self.myCreditLimitTableViewDelegate deposit];
}

-(void)setCreditInfoDic:(NSDictionary *)creditInfoDic{
    _creditInfoDic = creditInfoDic;
    
    [self reloadData];
}

-(void)setRecords:(NSArray *)records{
    _records = records;
    [self reloadData];
}

@end
