//
//  AccountManageViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/29.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AccountManageViewController.h"
#import "AccountManageTableView.h"
#import "BindingPhoneVC.h"
#import "PerfectCodeViewController.h"

@interface AccountManageViewController ()<AccountManageTableViewDelegate>

@property(nonatomic, strong) AccountManageTableView *accountTableView;

@end

@implementation AccountManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账号管理";
    
    self.accountTableView = [[AccountManageTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.accountTableView.personModel = self.personModel;
    self.accountTableView.accountManageTableViewDelegate = self;
    [self.view addSubview:self.accountTableView];
}

-(void)selectIndex:(NSInteger)index{
    UITableViewCell *cell = [self.accountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    switch (index) {
        case 0:
        {
            if ([cell.detailTextLabel.text isEqualToString:@"未绑定"]) {
                BindingPhoneVC *vc = [[BindingPhoneVC alloc]init];
                vc.callBack = ^(id obj) {
                    cell.detailTextLabel.text = @"已绑定";
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            
            break;
        case 1: {
            if ([cell.detailTextLabel.text isEqualToString:@"待完善"]) {
                PerfectCodeViewController *vc = [[PerfectCodeViewController alloc]init];
                vc.callBack = ^(id obj) {
                    cell.detailTextLabel.text = @"已完善";
                };
                vc.personModel = self.personModel;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        default:
            break;
    }
}


@end
