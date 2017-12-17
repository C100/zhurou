//
//  AgreementViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AgreementViewController.h"
#import "AgreementView.h"
#import "AddressManagerVC.h"
#import "RegisterVC.h"

@interface AgreementViewController ()

@property(nonatomic, strong) AgreementView *agreementView;

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.topTitle) {
        self.title = self.topTitle;
    }else{
        self.title = @"托管养殖师协议";
        [self initNet];
    }
    
    self.agreementView = [[AgreementView alloc]init];
    [self.view addSubview:self.agreementView];
    [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
//    [self.agreementView.myWebView loadRequest:request];
    [self.agreementView.sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)sureAction{
    if (self.agreementView.chooseButton.selected == YES) {
        if (self.topTitle) {
            RegisterVC *vc = [[RegisterVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES
             ];
        }else{
            AddressManagerVC *vc = [[AddressManagerVC alloc]init];
            [vc setCallback:^(AddressModel *model) {
                
            }];
            vc.source = @"托管养殖";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)initNet{
    [HttpRequestManager getAgreementUrl:nil viewcontroller:self finishBlock:^(NSDictionary *dic) {
        
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        NSString *urlString = [dataDic objectForKey:@"agreement"];
        
        if (urlString) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.agreementView.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
            });
        }
    }];
}

@end

