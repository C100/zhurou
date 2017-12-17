//
//  LCYPreBuyProtocalViewController.m
//  XiJuOBJ
//
//  Created by 刘岑颖 on 2017/12/16.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "LCYPreBuyProtocalViewController.h"
#import "AgreementView.h"
#import "LCYPreSureViewController.h"

@interface LCYPreBuyProtocalViewController ()

@property(nonatomic, strong) AgreementView *agreementView;

@end

@implementation LCYPreBuyProtocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"电子合同";
    
    self.agreementView = [[AgreementView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    [self.view addSubview:self.agreementView];
    
    self.URLString = [self.URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.URLString]];
    [self.agreementView.myWebView loadRequest:request];
    
    [self.agreementView.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sureAction:(id)sender {
    LCYPreSureViewController *vc = [[LCYPreSureViewController alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
