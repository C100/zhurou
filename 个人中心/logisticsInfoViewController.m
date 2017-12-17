//
//  logisticsInfoViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/1.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "logisticsInfoViewController.h"
#import "logisticsTableView.h"

@interface logisticsInfoViewController ()

@property(nonatomic, strong) logisticsTableView *myTableView;

@end

@implementation logisticsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"物流详情";
    [self requestData];
    self.myTableView = [[logisticsTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.myTableView.infos = @[@[@[@"派送中",@"[杭州市]杭州拱墅区派件员：张三16278778798"]],@[@[@"运输中",@"快件从 杭州中转站 发出"],@[@"快件从 上海中心 发出"],@[@"快件从 嘉兴 发出"]],@[@[@"已揽件",@"您的快递已揽件"]]];
    [self.view addSubview:self.myTableView];
}

-(void)requestData{
    [HttpRequestManager getOrderTracesWithCompanyNo:self.orderModel.companyNo andWaybillNumber:self.orderModel.waybillNumber andFinishBlock:^(NSDictionary *data) {
        
    }];
}


@end
