//
//  WelfareViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/15.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WelfareViewController.h"
#import "WelfareTableView.h"
#import "WithdrawViewController.h"
#import "CouponApplyViewController.h"
#import "WithdrawRecordViewController.h"

@interface WelfareViewController ()<WelfareTableViewDelegate>

@property (nonatomic,strong) WelfareTableView *welTableView;

@end

@implementation WelfareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设计师福利";
    
    //self.view.backgroundColor = [UIColor redColor];
    self.welTableView = [[WelfareTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH)];
    self.welTableView.welfareTableViewDelegate = self;
    [self.view addSubview:self.welTableView];
    
    [self prepareData];
}

-(void)setRefresh:(NSString *)refresh{
    _refresh = refresh;
    [self prepareData];
}

-(void)prepareData{
    [HttpRequestManager postDesignerProfitWithFinishBlock:^(NSDictionary *dataDic) {
        if (dataDic) {
            NSNumber *totalMoney = dataDic[@"totalMoney"];
            NSNumber *withdrawMoney = dataDic[@"withdrawMoney"];
            self.welTableView.totalMoney = [NSString stringWithFormat:@"%.2f",totalMoney.floatValue/100];
            self.welTableView.withdrawMoney = [NSString stringWithFormat:@"%.2f",withdrawMoney.floatValue/100];
        }
    }];
}

#pragma WelfareTableView delegate
-(void)selectIndexPathRow:(NSInteger)row{
    switch (row) {
        case 2:
        {
            WithdrawViewController *vc = [[WithdrawViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3:
        {
            CouponApplyViewController *vc = [[CouponApplyViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 4:
        {
            WithdrawRecordViewController *vc = [[WithdrawRecordViewController alloc]init];
            vc.orderRecord = @"YES";
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}



@end
