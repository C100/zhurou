//
//  WithdrawSureViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WithdrawSureViewController.h"
#import "WithdrawSureTableView.h"
#import "CreditViewController.h"
#import "WithdrawCell.h"
#import "WelfareViewController.h"
#import "CreditCardModel.h"
#import "CreditCardModel.h"

@interface WithdrawSureViewController ()<WithdrawSureTableViewDelegate>

@property (nonatomic,strong) WithdrawSureTableView *tableView;
@property (nonatomic,strong) CreditCardModel *model;
@property (nonatomic,strong) CreditCardModel *defaultModel;

@end

@implementation WithdrawSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现确认";
    self.tableView = [[WithdrawSureTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.tableView.withdrawSureTableViewDelegate = self;
    self.tableView.withdrawMoney = self.withdrawMoney;
    [self.view addSubview:self.tableView];
    [self prepareData];
}
-(void)prepareData{
    //是否有默认银行卡
    [HttpRequestManager postCreditCardsWithFinishBlock:^(NSMutableArray *datas) {
        if (datas) {
            if (datas.count>0) {
                self.defaultModel = datas.firstObject;
                if (self.defaultModel.openNumber.length>4) {
                    self.tableView.defaultCreditNum = [self.defaultModel.openNumber substringFromIndex:self.defaultModel.openNumber.length-4];
                }else{
                    self.tableView.defaultCreditNum = self.defaultModel.openNumber;
                }
                
            }
        }
    }];
}

-(void)chooseCredit{
    __weak __block WithdrawSureViewController *weakSelf = self;
    CreditViewController *vc = [[CreditViewController alloc]init];
    vc.callBack = ^(id obj) {
        WithdrawCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        if (obj) {
            self.model = obj;
            NSString *cardNum = [self.model.openNumber substringFromIndex:self.model.openNumber.length-4];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"尾号%@",cardNum];
        }else{
            cell.detailTextLabel.text = @"未设置";
        }
        
        
    };
    WithdrawCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (self.model) {
        vc.cardNum = cell.detailTextLabel.text;
        vc.model = self.model;
    }else if (self.defaultModel) {
//        vc.cardNum = cell.detailTextLabel.text;
        vc.model = self.defaultModel;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)withdrawActionWithCreditNum:(NSString *)creditNum{
    if ([creditNum isEqualToString:@"未设置"]||creditNum == nil) {
        [LUtils toastview:@"请选择银行卡"];
        return;
    }
    
    NSString *money = [NSString stringWithFormat:@"%.1f",self.withdrawMoney*100];
    int withMoney = money.intValue;
    CreditCardModel *selectModel = nil;
    if (self.model) {
        selectModel = self.model;
    }else if (self.defaultModel){
        selectModel = self.defaultModel;
    }
    [HttpRequestManager withdrawWithReceiptIdList:self.receiptIdLists andBankCardId:selectModel.creditId andTotalMoney:@(withMoney) andFinishBlock:^(NSDictionary *dataDic) {
        if (dataDic) {
            NSNumber *codeNum = dataDic[@"code"];
            if (codeNum.intValue==kSuccessCode) {
                [LUtils toastview:@"提现成功!"];
                UIViewController *vc = self.navigationController.viewControllers[1];
                [self.navigationController popToViewController:vc animated:YES];
            }else if (codeNum.intValue==251){
                [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"提现次数过多"];
            }else if (codeNum.intValue==253){
                [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"提现金额不足"];
            }
        }
        

    }];
}


@end
