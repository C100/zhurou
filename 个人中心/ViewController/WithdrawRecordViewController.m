//
//  WithdrawRecordViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WithdrawRecordViewController.h"
#import "WithdrawRecordTableView.h"
#import "WithdrawRecordDetailTableView.h"
#import "OrderRecordViewController.h"

@interface WithdrawRecordViewController ()<WithdrawRecordTableViewDelegate>

@property (nonatomic,strong) WithdrawRecordTableView *tableView;
@property (nonatomic,strong) WithdrawRecordDetailTableView *detailTableView;

@end

@implementation WithdrawRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationTitle) {
        self.title = self.navigationTitle;
        self.detailTableView = [[WithdrawRecordDetailTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
        [self.view addSubview:self.detailTableView];
        [self getWithdrawInfo];

    }else{
        self.tableView = [[WithdrawRecordTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
        self.tableView.withdrawRecordTableViewDelegate = self;
        [self.view addSubview:self.tableView];
        
        if (self.orderRecord) {
            self.title = @"订单记录";
//            self.tableView.records = @[@[@"¥300.00",@"2017-9-9",@"已发放"],@[@"¥300.00",@"2017-9-9",@"待付款"]];
            [self getOrderRecord];
        }else{
            self.title = @"提现记录";
            [self prepareData];
        }
    }
    
}

//订单记录
-(void)getOrderRecord{
    [HttpRequestManager getOrderRecordsWithFinishBlock:^(NSArray *datas) {
        if (datas) {
            self.tableView.records = datas;
        }
    }];
}

//获取订单信息
-(void)getWithdrawInfo{
    [HttpRequestManager getWithdrawDetailOrderId:self.clickModel.withdrawId andFinishBlock:^(WithdrawModel *model) {
        if (model) {
            self.detailTableView.details = @[[self withdrawStatus:model.withdrawStatus],[NSString stringWithFormat:@"¥%.2f",model.totalMoney.floatValue/100],[LUtils stringToDate:model.withdrawTime.stringValue],model.owner,model.openNumber,model.openBank,model.cellphone];
            [self.detailTableView reloadData];
        }
    }];
}

//提现记录列表
-(void)prepareData{
    //提现记录
    [HttpRequestManager getWithdrawRecordWithFinishBlock:^(NSArray *datas) {
        if (datas) {
            self.tableView.records = datas;
        }
    }];
}

-(void)browseWithdrawRecordDetailWithModel:(WithdrawModel *)model{
    if (self.orderRecord) {
        OrderRecordViewController *vc = [[OrderRecordViewController alloc]init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        WithdrawRecordViewController *vc = [[WithdrawRecordViewController alloc]init];
        vc.navigationTitle =@"提现详情";
        vc.clickModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
