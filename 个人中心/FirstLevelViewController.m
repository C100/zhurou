//
//  FirstLevelViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "FirstLevelViewController.h"
#import "MyPigFirstLevelTableView.h"
#import "ZHPigMyOrderViewController.h"

@interface FirstLevelViewController ()<MyPigFirstLevelTableViewDelegate>

@property(nonatomic, strong) MyPigFirstLevelTableView *myTableView;

@end

@implementation FirstLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView = [[MyPigFirstLevelTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW-16, KHScreenH-130)];
    self.myTableView.myPigFirstLevelTableViewDelegate = self;
    [self.view addSubview:self.myTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

-(void)requestData{
    [HttpRequestManager getPigListWithFinishBlock:^(NSArray *datas) {
        if (datas) {
            self.myTableView.myPigs = datas;
        }
    }];
}

- (void)enterOrderDetail {
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"付款" object:nil];
}

-(void)leftButtonActionWithModel:(MyPigListModel *)model andTitle:(NSString *)title{
    
    if ([title isEqualToString:@"发起变售"]) {
        NSTimeInterval time = model.payTime.longValue+30*24*3600*1000.0;
        if (time>[LUtils getSystemCurrentTime]) {
            
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"变售需要早购买一个月之后方能发起"];

            
        }else{
            [[MyAlert manage]showBtnAlertWithTitle:@"温馨提示" detailTitle:@"发起变售请先下载新版本" confirm:^{
                
                //跳转appstore
                
            }];
        }
        
    }else if ([title isEqualToString:@"删除"]){
        [HttpRequestManager deleteMyPigOrderWithOrderId:model.orderId andFinishBlock:^(NSDictionary *data) {
            [self requestData];
        }];
    }else if ([title isEqualToString:@"托管"]){
        //到期时间
        if (model.endTime.longLongValue>[LUtils getSystemCurrentTime]) {
            NSString *time = [LUtils stringToDate:model.endTime.stringValue];
            NSArray *components = [time componentsSeparatedByString:@"-"];
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:[NSString stringWithFormat:@"托管在%@年%@月%@日之后,方能发起！",components[0],components[1],components[2]]];
        }else{
            [[MyAlert manage]showBtnAlertWithTitle:@"温馨提示" detailTitle:@"托管请先下载新版本" confirm:^{
                
                //跳转appstore
                
            }];
        }
        
        
    }
}

-(void)rightButtonActionWithModel:(MyPigListModel *)model andTitle:(NSString *)title{
    if ([title isEqualToString:@"付款"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"付款" object:@[model]];
    }else if ([title isEqualToString:@"托管详情"]){
        
    }else if ([title isEqualToString:@"提前交割"]){
        //跳转提前交割协议
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"提前交割" object:@[model]];

        
    }else if ([title isEqualToString:@"删除"]){
        [HttpRequestManager deleteMyPigOrderWithOrderId:model.orderId andFinishBlock:^(NSDictionary *data) {
            [self requestData];
        }];
    } else if ([title isEqualToString:@"交割"]){
        if (model.endTime.longLongValue>[LUtils getSystemCurrentTime]) {
            NSString *time = [LUtils stringToDate:model.endTime.stringValue];
            NSArray *components = [time componentsSeparatedByString:@"-"];
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:[NSString stringWithFormat:@"交割在%@年%@月%@日之后,方能发起！",components[0],components[1],components[2]]];
        }else{
            [[MyAlert manage]showBtnAlertWithTitle:@"温馨提示" detailTitle:@"交割请先下载新版本" confirm:^{
                
                //跳转appstore
                
            }];
        }
    }
}

-(void)buyActionWithModel:(MyPigListModel *)model{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"购买凭证" object:@[@"购买凭证",model.buyContractUrl]];
}

-(void)consumeActionWithModel:(MyPigListModel *)model andTitle:(NSString *)title{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"购买凭证" object:@[title,model.contractUrl]];
}

- (void)pigGiftedWithModel:(MyPigListModel *)model{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"猪种礼包" object:model];
}

@end
