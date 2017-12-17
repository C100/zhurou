//
//  BackProductInfoViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProductInfoViewController.h"
#import "BackProductInfoTableView.h"

@interface BackProductInfoViewController ()

@property(nonatomic, strong) BackProductInfoTableView *infoTableView;

@end

@implementation BackProductInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退换货信息";
    self.infoTableView = [[BackProductInfoTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.infoTableView.backProModel = self.backProModel;
    [self.view addSubview:self.infoTableView];
    
}


@end
