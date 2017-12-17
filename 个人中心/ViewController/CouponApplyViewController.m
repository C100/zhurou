//
//  CouponApplyViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "CouponApplyViewController.h"
#import "CouponApplyTableView.h"
#import "ApplyRecordViewController.h"
#import "codeModel.h"

@interface CouponApplyViewController ()<CouponApplyTableViewDelegate>

@property (nonatomic,strong) CouponApplyTableView *tableView;

@end

@implementation CouponApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"优惠码申请";
    [self setNaviRightButton];
    
    self.tableView = [[CouponApplyTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.tableView.couponApplyTableViewDelegate = self;
    [self.view addSubview:self.tableView];
    
}

//设置右侧按钮
-(void)setNaviRightButton{
    UIButton *rightButton = [Tool buttonWithTitle:@"申请记录" titleColor:[UIColor whiteColor] font:0 imageName:nil target:self action:@selector(recordAction)];
    rightButton.frame = CGRectMake(KHScreenW-64-10, (64-16)/2, 64, 16);
    rightButton.titleLabel.font = kLightFont(16);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
-(void)recordAction{
    ApplyRecordViewController *vc = [[ApplyRecordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma CouponApplyTableViewDelegate delegate
-(void)applyActionWithName:(NSString *)name andPhoneNum:(NSString *)num andLocation:(NSString *)location andAddress:(NSString *)address{
    if (name.length==0||num.length==0||[location isEqualToString:@"省市选择"]||address.length==0) {
        [LUtils toastview:@"请完善信息"];
        return;
    }
    if ([LUtils isMobile:num] == NO) {
        [LUtils toastview:@"请输入正确的手机号"];
        return;
    }
    
    
    [HttpRequestManager applyForPromotionCodeWithName:name andAddress:location andCommunity:address andCellphone:num andFinishBlock:^(NSDictionary *dataDic) {
        if (dataDic) {
            NSNumber *code = dataDic[@"code"];
            if (code.intValue==kSuccessCode) {
                NSNumber *codeId = dataDic[@"info"];
                if (codeId) {
                    [HttpRequestManager baseCodeIdGetCodeInfo:codeId andFinishBlock:^(codeModel *backModel) {
                        if (backModel) {
                            NSString *code = [NSString stringWithFormat:@"优惠码：%@",backModel.promotionCode];
                            [[MyAlert manage]showBtnAlertWithTitle:@"优惠码" detailTitle:code oneButton:YES confirm:^{
                                //清空所有的填写
                                [self.tableView removeFromSuperview];
                                self.tableView = nil;
                                self.tableView = [[CouponApplyTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
                                self.tableView.couponApplyTableViewDelegate = self;
                                [self.view addSubview:self.tableView];
                            }];
                        }
                    }];
                }
                
            }else if (code.intValue==kHasCode){
                [LUtils toastview:@"该用户已有有效的优惠码"];
            }else if (code.intValue == kNoPhoneNum){
                [LUtils toastview:@"该手机号未被注册"];
            }
        }
    }];
    
    
    
}


@end
