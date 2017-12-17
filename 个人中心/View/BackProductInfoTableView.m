//
//  BackProductInfoTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProductInfoTableView.h"

@implementation BackProductInfoTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.tableFooterView = [[UIView alloc]init];
        self.infos = @[@"运单号",@"退款金额",@"说明："];
        self.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.textColor = k888888Color;
        cell.textLabel.font = kFont(14);
        cell.detailTextLabel.textColor = k888888Color;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.infos[indexPath.row];
    if (indexPath.row==self.infos.count-1) {//说明
        if (self.backProModel.refundReason.length==0||self.backProModel.refundReason==nil) {
            cell.detailTextLabel.text = @"买家未填写留言内容";
        }else{
            cell.detailTextLabel.text = self.backProModel.refundReason;
        }
    }
    if (self.backProModel.waybillNumber==nil) {
        if (indexPath.row==0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2f",self.backProModel.money.floatValue/100];
        }
    }else{
        if (indexPath.row==0) {
            cell.detailTextLabel.text = self.backProModel.waybillNumber;
        }else if (indexPath.row==1){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2f",self.backProModel.money.floatValue/100];
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38;
}

-(void)setBackProModel:(BackProductModel *)backProModel{
    _backProModel = backProModel;
    if (backProModel.waybillNumber==nil) {
        self.infos = @[@"退款金额",@"说明："];
    }else{
        self.infos = @[@"运单号",@"退款金额",@"说明："];
    }
    [self reloadData];
}

@end
