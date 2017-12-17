//
//  MyInviteViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyInviteViewController.h"
#import "MyInviteTableView.h"
#import "MyInvitionModel.h"
#import "OtherInvitionDetailViewController.h"

@interface MyInviteViewController ()<MyInviteTableViewDelegate>

@property(nonatomic, strong) MyInviteTableView *mytableView;

@end

@implementation MyInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的邀请";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    self.mytableView = [[MyInviteTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.mytableView.myInviteTableViewDelegate = self;
    self.mytableView.personModel = self.personModel;
    [self.view addSubview:self.mytableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self requestData];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar.subviews firstObject].hidden = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = YES;
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.navigationController.navigationBar.translucent = NO;
//}

-(void)requestData{
    [HttpRequestManager getMyInvititionsWithFinishBlock:^(NSDictionary *dataDic) {
        if (dataDic) {
            self.mytableView.infoDic = dataDic;
        }
    }];
}

-(void)shareAction{
    
}

-(void)invitationDetailWithInfos:(NSDictionary *)infoDic{
    OtherInvitionDetailViewController *vc = [[OtherInvitionDetailViewController alloc]init];
    vc.infoDic = infoDic;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
