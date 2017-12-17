//
//  BackProViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProViewController.h"
#import "BackProTableView.h"
#import "OrderDetail2VC.h"
#import "logisticsInfoViewController.h"
#import "OrderDetailVC.h"

@interface BackProViewController ()<BackProTableViewDelegate>

@property(nonatomic, strong) BackProTableView *myTableView;

@end

@implementation BackProViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的退换货";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    self.myTableView = [[BackProTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.myTableView.backProTableViewDelegate = self;
    [self.view addSubview:self.myTableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

-(void)requestData{
    [HttpRequestManager getMyBackProOrderListsWithFinishBlock:^(NSArray *datas) {
        if (datas) {
            self.myTableView.backPros = datas;
        }
    }];
}

-(void)clickToDetailWithBackProductModel:(BackProductModel *)model{
    OrderDetail2VC *vc = [[OrderDetail2VC alloc]init];
    vc.orderId = model.receiptId.stringValue;
    vc.backProModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)logisticsWithBackProductModel:(BackProductModel *)model{
    logisticsInfoViewController *vc = [[logisticsInfoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)receiveOrBuyAgainWithTitle:(NSString *)title andBackProductModel:(BackProductModel *)model{
    if ([title isEqualToString:@"确认收货"]) {
        [[MyAlert manage] showBtnAlertWithTitle:@"提醒" detailTitle:@"是否确认收货？" confirm:^{
            [HttpRequestManager finishBackProductWithReceiptId:model.backId andFinishBlock:^(NSDictionary *dataDic) {
                if (dataDic) {
                    //刷新界面
                    [self requestData];
                }
            }];
//            [HttpRequestManager postOrderSouhuoRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
//
//            }];
        }];
    }else{
        //再次购买
        OrderDetailModel *orderDetailModel = [[OrderDetailModel alloc]init];
        orderDetailModel.goodsArr = [@[model.goodsModel] mutableCopy];
        OrderDetailVC *vc = [[OrderDetailVC alloc]init];
        vc.model = orderDetailModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
