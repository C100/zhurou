//
//  WithdrawViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WithdrawViewController.h"
#import "LUtils.h"
#import "WithdrawView.h"
#import "WithdrawSureViewController.h"
#import "WithdrawRecordViewController.h"
#import "WithdrawModel.h"

@interface WithdrawViewController ()<WithdrawViewDelegate>

@property (nonatomic,strong) WithdrawView *withdrawView;

@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"佣金提现";
//    [self setNaviRightButton];
    
    [self prepareData];
    
    self.withdrawView = [[WithdrawView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.withdrawView.withdrawViewDelegate = self;
    //self.withdrawView.infos = @[@[@"订单金额：10000.00",@"已完成",@"207-9-9",@"300.00"],@[@"订单金额：10000.00",@"待评价",@"207-9-9",@"300.00"],@[@"订单金额：10000.00",@"待收货",@"207-9-9",@"300.00"],@[@"订单金额：10000.00",@"待付款",@"207-9-9",@"300.00"]];
    [self.view addSubview:self.withdrawView];
}

-(void)prepareData{
    [HttpRequestManager getWithdrawListWithFinishBlock:^(NSArray *datas) {
        if (datas) {
            self.withdrawView.infos = datas;
        }
    }];
}

//设置右侧按钮
-(void)setNaviRightButton{
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Medium" size:16];
    UIButton *rightButton = [Tool buttonWithTitle:@"提现记录" titleColor:[UIColor whiteColor] font:0 imageName:nil target:self action:@selector(withdrawRecord)];
    rightButton.frame = CGRectMake(KHScreenW-64-10, (64-16)/2, 64, 16);
    rightButton.titleLabel.font = font;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

-(void)withdrawRecord{
    WithdrawRecordViewController *vc = [[WithdrawRecordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark WithdrawView delegate
-(void)withdrawMoneyWithSelectedModels:(NSMutableArray *)selectedOrders andTotalMoney:(CGFloat)money{
    NSMutableString *ids = [NSMutableString string];
    WithdrawSureViewController *vc = [[WithdrawSureViewController alloc]init];
    vc.withdrawMoney = money;
    for (int i = 0;i<selectedOrders.count;i++) {
        WithdrawModel *model = selectedOrders[i];
        [ids appendString:model.withdrawId.stringValue];
        if (i != selectedOrders.count-1) {
            [ids appendString:@","];
        }
        
    }

    vc.receiptIdLists = ids;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
