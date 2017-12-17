//
//  AddCreditViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AddCreditViewController.h"
#import "AddCreditTableView.h"
#import "AddCreditSuccessViewController.h"
#import "CreditViewController.h"

@interface AddCreditViewController ()<AddCreditTableViewDelegate>

@property (nonatomic,strong) AddCreditTableView *tableView;

@end

@implementation AddCreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationTitle) {
        self.title = self.navigationTitle;
    }else{
        self.title = @"添加银行卡";
    }
    
    self.tableView = [[AddCreditTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.tableView.clickCreditModel = self.clickCreditModel;
    self.tableView.addCreditTableViewDelegate = self;
    [self.view addSubview:self.tableView];
    
}

#pragma mark AddCreditTableViewDelegate
-(void)addCreditActionWithName:(NSString *)name andCreditNum:(NSString *)creditNum andBank:(NSString *)bank andPhoneNum:(NSString *)phoneNum andIsDefault:(NSNumber *)isDefalut andModel:(CreditCardModel *)model{
    BOOL creditNumRight = [LUtils checkCardNo:creditNum];
    if (creditNumRight==NO) {
        [LUtils toastview:@"请输入正确的银行卡号"];
        return;
    }
    
    BOOL phoneNumRight = [LUtils isMobile:phoneNum];
    if (phoneNumRight == NO) {
        [LUtils toastview:@"请输入正确的手机号"];
        return;
    }
    if (model) {
        //修改
        [HttpRequestManager changeCreditCardInfoWithCreditId:model.creditId andOwner:name andOpenNumber:creditNum andOpenBank:bank andCellphone:phoneNum andIsDefault:isDefalut andFinishBlock:^(NSDictionary *dataDic) {
            if (dataDic) {
                NSNumber *code = dataDic[@"code"];
                if (code.intValue==kSuccessCode) {
                    CreditViewController *vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
                    vc.refresh = @"YES";
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }];
    }else{
        //添加成功
        [HttpRequestManager addCreditCardWithOwner:name andOpenNumber:creditNum andOpenBank:bank andCellphone:phoneNum andIsDefault:isDefalut andFinishBlock:^(NSDictionary *dataDic) {
            if (dataDic) {
                NSNumber *code = dataDic[@"code"];
                if (code.intValue==kSuccessCode) {
                    _myCallBack(@"refresh");
                    AddCreditSuccessViewController *vc = [[AddCreditSuccessViewController alloc]init];
                    //        if (creditNum.length>=4) {
                    //            creditNum = [creditNum substringFromIndex:creditNum.length-4];
                    //        }
                    //        vc.addCreditInfos = @[bank,creditNum];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            
        }];
    }
    

    
}


@end
