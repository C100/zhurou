//
//  MyPigViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyPigViewController.h"
#import "MyPigListView.h"
#import "AgreementViewController.h"
#import "PigGiftedViewController.h"
#import "RegAgreementViewController.h"
#import "LCYPreBuyProtocalViewController.h"
#import "MyPigListModel.h"
#import "ZHPigMyOrderViewController.h"

@interface MyPigViewController ()

@property(nonatomic, strong) MyPigListView *listView;

@end

@implementation MyPigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的猪种";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"购买凭证" style:UIBarButtonItemStylePlain target:self action:@selector(buyApplication)];
    self.listView = [[MyPigListView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, KHScreenH)];
    [self.view addSubview:self.listView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buyAction:) name:@"购买凭证" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(giftedAction) name:@"猪种礼包" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(preButtonAction:) name:@"提前交割" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payAction) name:@"付款" object:nil];

    //设置导航栏的按钮
    UIBarButtonItem *backButton = [UIBarButtonItem itemWithImageName:@"NavbackView" highImageName:@"NavbackView" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
//            cell.textLabel.font = [UIFont fontWithName:The_titleFont size:15];
    
    UIBarButtonItem *rightBarButton = [UIBarButtonItem itemWithName:@"猪种介绍" font:14 target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)rightBarButtonAction{
    
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//-(void)buyApplication{
//    
//}

- (void)payAction {
    ZHPigMyOrderViewController *myOrderViewController = [[UIStoryboard storyboardWithName:@"ZHPig" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(ZHPigMyOrderViewController.class)];
    myOrderViewController.isPushedFromMyPig = YES;
    [self.navigationController pushViewController:myOrderViewController animated:YES];
}

-(void)buyAction:(NSNotification *)noti{
    NSArray *arr = noti.object;
    
    //购买凭证
    RegAgreementViewController *vc = [[RegAgreementViewController alloc]init];
    vc.topTitle = arr.firstObject;
    vc.url = arr.lastObject;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)giftedAction{
    PigGiftedViewController *vc = [[PigGiftedViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)preButtonAction:(NSNotification *)noti{
    NSArray *arr = noti.object;
    MyPigListModel *model = (MyPigListModel *)arr.firstObject;
    //购买凭证
    LCYPreBuyProtocalViewController *vc = [[LCYPreBuyProtocalViewController alloc] init];
    vc.URLString = model.contractUrl;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
