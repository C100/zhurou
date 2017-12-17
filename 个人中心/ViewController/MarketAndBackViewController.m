//
//  MarketAndBackViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/27.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MarketAndBackViewController.h"
#import "MarketAndBackTableView.h"
#import "LoginAndRegisterVC.h"
#import "BXNavigationController.h"

@interface MarketAndBackViewController ()

@property(nonatomic, strong) MarketAndBackTableView *tableView;

@end

@implementation MarketAndBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[MarketAndBackTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64-178)];
    self.tableView.type = self.type;
    [self.view addSubview:self.tableView];
    
    [self requestReceiptRefundData];
    if ([self.type isEqualToString:@"商城消费"]) {
        [self requestShopList];
    }else{
        [self requestReceiptRefundData];
    }
}

-(void)requestShopList{
    [HttpRequestManager getShopListWithFinishBlock:^(NSArray *datas) {
        if (datas) {
            CGFloat totalMoney = 0;
            for (NSDictionary *infoDic in datas) {
                NSNumber *totalNum = infoDic[@"netAmount"];
                totalMoney += totalNum.floatValue;
            }
            self.tableView.totalMoney = totalMoney;
            self.tableView.infos = datas;
        }
    }];
}

-(void)requestReceiptRefundData{
  
        [HttpRequestManager postMyReceiptRefundWithFinishBlock:^(NSArray *datas) {
            if (datas) {
                CGFloat totalMoney = 0;
                for (NSDictionary *infoDic in datas) {
                    NSNumber *totalNum = infoDic[@"money"];
                    totalMoney += totalNum.floatValue;
                }
                self.tableView.totalMoney = totalMoney;
                self.tableView.infos = datas;
            }
        }];
}


@end
