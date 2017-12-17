//
//  OrderRecordViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/22.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "OrderRecordViewController.h"
#import "OrderRecordTableView.h"
#import "OrderRecordModel.h"

@interface OrderRecordViewController ()

@property (nonatomic,strong) OrderRecordTableView *tableView;

@end

@implementation OrderRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单记录";
    self.tableView = [[OrderRecordTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    [self.view addSubview:self.tableView];
    [self prepareData];
//    self.tableView.details = @[@[@"12345"],@[@"正常",@"返回值",@"返回值",@"返回值"],@[@"返回值",@"返回值"],@[@"返回值",@"返回值"]];
}

-(void)prepareData{
    [HttpRequestManager getOrderInfoWithOrderId:self.model.withdrawId andFinishBlock:^(OrderRecordModel *model) {
        if (model) {
            self.tableView.details = @[@[model.promotionCode],@[model.receiptId,model.createTime,model.showStatus,model.price],@[model.name,model.mobile],@[model.totalMoney,model.withdrawStatus]];
            [self.tableView reloadData];
        }
    }];
}



@end
