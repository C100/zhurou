//
//  OtherInvitionDetailViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "OtherInvitionDetailViewController.h"
#import "OtherInvitionTableView.h"

@interface OtherInvitionDetailViewController ()

@property(nonatomic, strong) OtherInvitionTableView *myTableView;

@end

@implementation OtherInvitionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的邀请";
    self.myTableView = [[OtherInvitionTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.myTableView.second = @"";
    self.myTableView.infoDic = self.infoDic;
    [self.view addSubview:self.myTableView];
}



@end
