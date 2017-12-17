//
//  WithdrawRecordTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WithdrawRecordTableView.h"
#import "WithdrawRecordCell.h"

@implementation WithdrawRecordTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = kF5F5F5Color;
        self.tableFooterView = [[UIView alloc]init];
        
        //注册
        [self registerClass:[WithdrawRecordCell class] forCellReuseIdentifier:@"WithdrawRecordCell"];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.records.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WithdrawRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WithdrawRecordCell" forIndexPath:indexPath];
    cell.model = self.records[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WithdrawModel *model = self.records[indexPath.row];
    [self.withdrawRecordTableViewDelegate browseWithdrawRecordDetailWithModel:model];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79;
}

-(void)setRecords:(NSArray *)records{
    _records = records;
    [self reloadData];
}

@end
