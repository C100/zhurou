//
//  AuthSuccessViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/15.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AuthSuccessViewController.h"

@interface AuthSuccessViewController ()

@end

@implementation AuthSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"认证审核";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    [self.view addSubview:topView];
    topView.backgroundColor = The_MainColor;
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gou"]];
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    UILabel *titleLabel = [Tool labelWithTitle:@"申请成功，待后台管理员审核！" color:k333333Color fontSize:16 alignment:1];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(iconImageView.mas_bottom).mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"NavbackView" highImageName:@"NavbackView" target:self action:@selector(backAction)];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

-(void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
