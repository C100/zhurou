//
//  SettingVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/29.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "SettingVC.h"
#import "SettingCell.h"
#import "SettingModel.h"
#import "LoginVC.h"
#import "LoginAndRegisterVC.h"
#import "ForgetPasswordVC.h"
#import "FeedBackVC2.h"
#import "ChangePassWordVC.h"
#import "BXNavigationController.h"
#import "XiJuIntroduceVC.h"


@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    SettingModel *_model;
    
    
}

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    _model = [[SettingModel alloc]init];
    
    
}

-(void)configUI
{
    self.view.backgroundColor = The_list_backgroundColor;
    self.title = @"设置";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = The_list_backgroundColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //    [self.tableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    

    UIView *loginOutView = [[UIView alloc]init];
    loginOutView.backgroundColor = The_list_backgroundColor;
    loginOutView.height = 130;
    self.tableView.tableFooterView = loginOutView;

    UIButton *loginOutBtn = [Tool buttonWithTitle:@"退出登录" titleColor:[UIColor whiteColor]  font:15 imageName:nil target:self action:@selector(loginOutAction)];
    [loginOutView addSubview:loginOutBtn];
    loginOutBtn.backgroundColor = The_MainColor;
    
    [loginOutBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(50);
        make.right.mas_offset(-50);
        make.top.mas_offset(35);
        make.height.mas_equalTo(40);

    }];
    
    
    
}

#pragma mark buttonAction

-(void)loginOutAction
{
    
    [HttpRequestManager postloginOutRequest:nil viewcontroller:self finishBlock:^(NSDictionary * data) {
    
        
        [[UserManager manage]clearUser];
        //清除登录的userId
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserId];
//        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kUserId];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"token"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        LoginAndRegisterVC *vc1 = [[LoginAndRegisterVC alloc]init];
        vc1.isVistor = NO;
        BXNavigationController *nav1 = [[BXNavigationController alloc]initWithRootViewController:vc1];
        //    [self.window.rootViewController presentViewController:nav1 animated:YES completion:nil];
        
        [self presentViewController:nav1 animated:YES completion:nil];
        

    }];
    
    
  //    [self.navigationController pushViewController:vc animated:YES];
}

-(void)changePassWordAction
{
    
    ChangePassWordVC *vc = [[ChangePassWordVC alloc]init];
//    vc.changPassWord = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)yijianAction
{
    
    FeedBackVC2 *vc = [[FeedBackVC2 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)huancunAction
{
    
    [[MyAlert manage]showBtnAlertWithTitle:@"清除缓存" detailTitle:@"是否清除缓存" confirm:^{
        
        [[SDImageCache sharedImageCache] clearDisk];
        
        [[MyAlert  manage] showNoBtnAlertWithTitle:@"清除缓存" detailTitle:@"清除缓存成功"];
        [self.tableView reloadData];

    }];
    

}
-(void)xiyiAction
{
    XiJuIntroduceVC *vc = [[XiJuIntroduceVC alloc]init];
    vc.isxieyi = YES;
    [self.navigationController pushViewController: vc  animated:YES];

}

-(void)pingfenAction{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/%E5%A3%B9%E7%AD%91e%E5%AE%B6/id1271312169?l=zh&ls=1&mt=8"]];
}

#pragma mark --tableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 5;
  
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellid = @"SettingCell";
    SettingCell *cell  = [[SettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid InspectModel:_model IndexPath:indexPath VC:self];
    [cell.changePassWord addTarget:self action:@selector(changePassWordAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.yijian addTarget:self action:@selector(yijianAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.huanChun addTarget:self action:@selector(huancunAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.xieyi addTarget:self action:@selector(xiyiAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.pingfeng addTarget:self action:@selector(pingfenAction) forControlEvents:UIControlEventTouchUpInside];

    //    HomeModel *model = _tableViewDataArray[indexPath.row];
    //    cell.model = model;
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 3) {
        
           }
    
    
}
//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 0.01;

}

//返回分区的脚的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    return 38;
}


@end
