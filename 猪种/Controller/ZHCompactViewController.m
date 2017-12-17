//
//  ZHCompactViewController.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHCompactViewController.h"
#import "AgreementView.h"
#import "ZHPigOrderViewController.h"
#import "ZHPigBuyModel.h"

@interface ZHCompactViewController ()

@property(nonatomic, strong) AgreementView *agreementView;

@end

@implementation ZHCompactViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"电子合同";

    self.agreementView = [[AgreementView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    [self.view addSubview:self.agreementView];

    ZHPigBuyModel *pigBuyModel = [UIApplication appDelegate].pigBuyModel;

    self.URLString = [NSString stringWithFormat:@"%@&A_purchaseQuantity=%@", self.URLString, @(pigBuyModel.buyCount)];
    self.URLString = [self.URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.URLString]];
    [self.agreementView.myWebView loadRequest:request];

    [self.agreementView.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];

    self.agreementView.sureButton.alpha = 1;
    self.agreementView.sureButton.enabled = YES;
    self.agreementView.chooseButton.selected = YES;
}

- (void)sureAction:(id)sender {
    ZHPigOrderViewController *vc = [[UIStoryboard storyboardWithName:@"ZHPig" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(ZHPigOrderViewController.class)];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
