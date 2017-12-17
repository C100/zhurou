//
//  ApplyRecordViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ApplyRecordViewController.h"
#import "ApplyRecordTableView.h"

@interface ApplyRecordViewController ()

@property (nonatomic,strong) ApplyRecordTableView *tableView;

@end

@implementation ApplyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请记录";
    [self prepareData];
    
    self.tableView = [[ApplyRecordTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    [self.view addSubview:self.tableView];
}

-(void)prepareData{
    [HttpRequestManager getAllPromotionCodeInfosWithFinishBlock:^(NSArray *infos) {
        if (infos) {
            self.tableView.infos = infos;
        }
    }];
}


@end
