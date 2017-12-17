//
//  MyCreditLimitViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyCreditLimitViewController.h"
#import "MyCreditLimitTableView.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefreshFooter.h"

@interface MyCreditLimitViewController ()<MyCreditLimitTableViewDelegate>

@property(nonatomic, strong) MyCreditLimitTableView *myTableView;
@property(nonatomic, assign) NSInteger index;

@end

@implementation MyCreditLimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    self.title = @"我的信用额度余额";
    
    [self requestData];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    self.myTableView = [[MyCreditLimitTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.myTableView.myCreditLimitTableViewDelegate = self;
    //    self.myTableView.records = @[@"",@""];
    [self.view addSubview:self.myTableView];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.myTableView.mj_header = header;
    
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getMyMoneyRecord];
    }];
}

-(void)requestData{
    self.index = 0;
    [HttpRequestManager getMyCreditInfoWithFinishBlock:^(NSDictionary *data) {
        if (data) {
            self.myTableView.creditInfoDic = data;
        }
        [self.myTableView.mj_header endRefreshing];
    }];
    [HttpRequestManager getMyMonryRecordWithPageNum:@(1) andFinishBlock:^(NSDictionary *data) {
        if (data) {
            self.myTableView.records = data[@"recordList"];
        }
        [self.myTableView.mj_header endRefreshing];
    }];
    
}

-(void)getMyMoneyRecord{
    self.index++;
    [HttpRequestManager getMyMonryRecordWithPageNum:@(self.index) andFinishBlock:^(NSDictionary *data) {
        if (data) {
            NSMutableArray *arr = [self.myTableView.records mutableCopy];
            [arr addObjectsFromArray:data[@"recordList"]];
            self.myTableView.records = arr;
        }
        [self.myTableView.mj_footer endRefreshing];
    }];
}

-(void)deposit{
    [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"您的可托管额度为0"];
}


@end

