//
//  MyFundViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/27.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyFundViewController.h"
#import "MyFundView.h"
#import "WithdrawSureViewController.h"

@interface MyFundViewController ()

@property(nonatomic, strong) MyFundView *myFundView;
@property(nonatomic, strong) PersonalInfoModel *personalModel;

@end

@implementation MyFundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的资金";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    self.myFundView = [[MyFundView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    [self.view addSubview:self.myFundView];
    
    //提现
    [self.myFundView.withdrawButton addTarget:self action:@selector(withdrawAction)];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self requestData];
//}

-(void)requestData{
    [HttpRequestManager postMyInfoRequest:nil viewcontroller:self finishBlock:^(NSDictionary *data) {
        _personalModel =[[PersonalInfoModel alloc]init];
        _personalModel.imgUrl = data[@"headUrl"];
        
        NSArray *com = [_personalModel.imgUrl componentsSeparatedByString:@"http://qzapp.qlogo.cn/qzapp"];
        NSString *imgLastUrl  = @"";
        if (com.count==2) {
            imgLastUrl = [NSString stringWithFormat:@"http://q.qlogo.cn/qqapp%@",com.lastObject];
            _personalModel.imgUrl = imgLastUrl;
        }
        
        _personalModel.useInvitationCode = [data objectForKey:@"useInvitationCode"];
        _personalModel.state = data[@"state"];
        _personalModel.name = data[@"username"];
        _personalModel.phone = data[@"mobile"];
        _personalModel.userCode = data[@"userCode"];
        _personalModel.money = data[@"money"];
        self.myFundView.personalModel = self.personModel;
    }];
}

-(void)withdrawAction{
    WithdrawSureViewController *vc = [[WithdrawSureViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.navigationController.navigationBar.translucent = NO;
//}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

@end
