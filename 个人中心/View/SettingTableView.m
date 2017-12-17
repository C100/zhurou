//
//  SettingTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/29.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "SettingTableView.h"
#import "ChangeHeadImageCell.h"
#import "LoginAndRegisterVC.h"
#import "BXNavigationController.h"

@implementation SettingTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.tableFooterView = [[UIView alloc]init];
        self.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];;
        
        
        //注册
        [self registerClass:[ChangeHeadImageCell class] forCellReuseIdentifier:@"ChangeHeadImageCell"];
        
        self.contents = @[@[],@[@"昵称",@"账号管理",@"实名认证"],@[@"清除缓存",@"意见反馈",@"用户协议",@"修改密码"]];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.contents.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        NSNumber *isAppInReviewNum = [[NSUserDefaults standardUserDefaults]objectForKey:@"isAppInReviewNum"];
        if (isAppInReviewNum.intValue==1) {
            return 2;
        }
        return 3;
    }else {
        return 4;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        ChangeHeadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChangeHeadImageCell" forIndexPath:indexPath];
        [Tool setTouxiangImgurl:cell.iconImageView imgurl:_model.imgUrl];
        if (_model.areaImg) {
            cell.iconImageView.image = _model.areaImg;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
            cell.textLabel.textColor = k4D4D4DColor;
            cell.textLabel.font = kFont(15);
            cell.detailTextLabel.textColor = kADADADColor;
            cell.detailTextLabel.font = kFont(15);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *arr = self.contents[indexPath.section];
        cell.textLabel.text = arr[indexPath.row];
        if (indexPath.section==1&&indexPath.row==0) {
            cell.detailTextLabel.text = self.model.name;
        }else if (indexPath.section==1&&indexPath.row==2) {
            if (self.model.state.intValue==1) {
                cell.detailTextLabel.text = @"已认证";
            }else{
                cell.detailTextLabel.text = @"未认证";
            }
            
        }else{
            cell.detailTextLabel.text = @"";
        }
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 72;
    }
    
    return 46;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, 65)];
        bgView.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
        self.logoutButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, KHScreenW, 45)];
        [bgView addSubview:self.logoutButton];
        self.logoutButton.backgroundColor = [UIColor whiteColor];
        [self.logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [self.logoutButton setTitleColor:k888888Color forState:UIControlStateNormal];
        self.logoutButton.titleLabel.font = kFont(15);
        [self.logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        
        return bgView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section!=2) {
        return 0;
    }
    return 65;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!getUserId) {
        MyAlert *alert = [MyAlert manage];
        [alert showBtnAlertWithTitle:@"提醒" detailTitle:@"您还未登录是否登录？" button1Title:@"取消" button2Title:@"确定" confirm:^{
            LoginAndRegisterVC *vc1 = [[LoginAndRegisterVC alloc]init];
            vc1.isVistor = YES;
            BXNavigationController *nav1 = [[BXNavigationController alloc]initWithRootViewController:vc1];
            [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:nav1 animated:YES completion:nil];
        }];
        return;
    }
    
    
    if (indexPath.section==1&&indexPath.row==2) {
        if (self.model.state.intValue==1) {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"您已认证"];
        }else{
            [self.settingTableViewDelegate selectedIndex:indexPath];
        }
    }else{
        [self.settingTableViewDelegate selectedIndex:indexPath];
    }
}

-(void)setModel:(PersonalInfoModel *)model{
    _model = model;
    [self reloadData];
}

-(void)logout{
    [self.settingTableViewDelegate logout];
}

@end
