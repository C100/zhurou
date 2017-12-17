//
//  PigGiftedViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "PigGiftedViewController.h"
#import "PigGiftedTableView.h"

@interface PigGiftedViewController ()

@property(nonatomic, strong) PigGiftedTableView *myTableView;

@end

@implementation PigGiftedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"猪种礼包";
    self.myTableView = [[PigGiftedTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    [self.view addSubview:self.myTableView];
}



@end
