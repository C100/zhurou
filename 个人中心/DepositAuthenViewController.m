//
//  DepositAuthenViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "DepositAuthenViewController.h"
#import "DepositAuthenView.h"
#import "AuthConditionViewController.h"

@interface DepositAuthenViewController ()

@property(nonatomic, strong) DepositAuthenView *authenView;

@end

@implementation DepositAuthenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"托管养殖咨询师";
    [self initNet];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    self.authenView = [[DepositAuthenView alloc]init];
    [self.view addSubview:self.authenView];
    [self.authenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    [self.authenView.authenButton addTarget:self action:@selector(authenAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)authenAction{
    AuthConditionViewController *vc = [[AuthConditionViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initNet{
    
    [HttpRequestManager getIntroductionUrl:nil viewcontroller:self finishBlock:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        
        NSString *urlString = [dataDic objectForKey:@"introduction"];
        
        if (urlString) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.authenView.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
            });
        }
        
    }];
}


@end

