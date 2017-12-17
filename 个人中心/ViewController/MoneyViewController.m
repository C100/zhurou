//
//  MoneyViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/27.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MoneyViewController.h"
#import "MoneyTableView.h"
#import "WithdrawModel.h"

@interface MoneyViewController ()

@property(nonatomic, strong) MoneyTableView *tableView;

@end

@implementation MoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[MoneyTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64-178)];
    self.tableView.type = self.type;
    [self.view addSubview:self.tableView];
    if ([self.type isEqualToString:@"我的佣金"]) {
        [self requestMyCommisionInfoData];
    }else{
        [self requestWithdrawListData];
    }
}

-(void)requestWithdrawListData{
    [HttpRequestManager getWithdrawRecordWithFinishBlock:^(NSArray *infos) {
        if (infos) {
            int totalMoney = 0;
            for (WithdrawModel *model in infos) {
                totalMoney += model.totalMoney.intValue;
            }
            self.tableView.infos = infos;
        }
    }];
}

-(void)requestMyCommisionInfoData{
    [HttpRequestManager postMyCommisionInfoWithFinishBlock:^(NSArray *infos) {
        if (infos) {
            int totalMoney = 0;
            for (NSDictionary *infoDic in infos) {
                NSNumber *totalNum = infoDic[@"money"];
                totalMoney += totalNum.intValue;
            }
            self.tableView.totalMoney = totalMoney;
            self.tableView.infos = infos;
        }
    }];
}

@end
