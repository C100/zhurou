//
//  AddCreditSuccessViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AddCreditSuccessViewController.h"
#import "AddCreditSuccessView.h"
#import "CreditViewController.h"

@interface AddCreditSuccessViewController ()

@property (nonatomic,strong) AddCreditSuccessView *successView;

@end

@implementation AddCreditSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加银行卡";
    [self setNaviRightButton];
    
    self.successView = [[AddCreditSuccessView alloc]init];
    self.view.backgroundColor = kF5F5F5Color;
    [self.view addSubview:self.successView];
    [self.successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
    }];
}

//设置右侧按钮
-(void)setNaviRightButton{
    UIButton *rightButton = [Tool buttonWithTitle:@"完成" titleColor:[LUtils colorHex:@"#98BBE3"] font:0 imageName:nil target:self action:@selector(finishAction)];
    rightButton.frame = CGRectMake(KHScreenW-32-10, (64-16)/2, 32, 16);
    rightButton.titleLabel.font = kLightFont(16);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

-(void)finishAction{
    for (UIViewController *existVC in self.navigationController.viewControllers) {
        if ([existVC isKindOfClass:[CreditViewController class]]) {
            CreditViewController *vc = (CreditViewController *)existVC;
            vc.cardNum = nil;
            //vc.addCreditInfos = self.addCreditInfos;
            [self.navigationController popToViewController:vc animated:YES];
            
        }
    }
}

@end
