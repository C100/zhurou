//
//  SettingViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableView.h"
#import "ChangeHeadImageCell.h"
#import "UITools.h"
#import "NameChangeVC.h"
#import "XiJuIntroduceVC.h"
#import "FeedBackVC2.h"
#import "ChangePassWordVC.h"
#import "AccountManageViewController.h"
#import "LoginAndRegisterVC.h"
#import "BXNavigationController.h"
#import "OSSMoreImageUpload.h"
#import "ZHAliyunOSSManager.h"
#import "ZHRealNameAuthViewController.h"

@interface SettingViewController ()<SettingTableViewDelegate>

@property(nonatomic, strong) SettingTableView *settingTableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"设置";
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    self.settingTableView = [[SettingTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.settingTableView.settingTableViewDelegate = self;
    self.settingTableView.model = self.model;
    [self.view addSubview:self.settingTableView];
    
    //    [self prepareData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareData];
}

-(void)logout{
    [HttpRequestManager postloginOutRequest:nil viewcontroller:self finishBlock:^(NSDictionary * data) {
        
        
        [[UserManager manage]clearUser];
        //清除登录的userId
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kUserId];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        LoginAndRegisterVC *vc1 = [[LoginAndRegisterVC alloc]init];
        vc1.isVistor = NO;
        BXNavigationController *nav1 = [[BXNavigationController alloc]initWithRootViewController:vc1];
        //    [self.window.rootViewController presentViewController:nav1 animated:YES completion:nil];
        
        [self presentViewController:nav1 animated:YES completion:nil];
        
    }];
}

-(void)prepareData
{
    
    ChangeHeadImageCell *cell = [self.settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [HttpRequestManager postMyInfoRequest:nil viewcontroller:self finishBlock:^(NSDictionary *data) {
        _model.useInvitationCode = [data objectForKey:@"useInvitationCode"];

        _model.state = data[@"state"];
        _model.imgUrl = data[@"headUrl"];
        _model.name = data[@"username"];
        _model.phone = data[@"mobile"];
        _model.userCode = data[@"userCode"];
        _model.money = data[@"money"];
        [Tool setImgurl:cell.iconImageView imgurl:data[@"headUrl"]];
        if (_model.areaImg) {
            cell.iconImageView.image = _model.areaImg;
        }
        [self.settingTableView reloadData];
    }];
    
}


-(void)selectedIndex:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        //修改头像
        ChangeHeadImageCell *cell = [self.settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [UITools selectImageForEditFrom:self complete:^(UIImage *origionImg, UIImage *editedImage) {
            _model.areaImg = editedImage;
            cell.iconImageView.image = editedImage;
            [OSSMoreImageUpload uploadImages:@[editedImage] isAsync:YES type:@(0) complete:^(NSArray<NSString *> *names, UploadImageState state, NSDictionary *dataDic) {
                
                NSString *downLoad = dataDic[@"download"];
                NSArray *images = [downLoad componentsSeparatedByString:@"/"];
                NSString *nameString = [NSString stringWithFormat:@"%@/%@/%@/%@",images[0],images[1],images[2],names.firstObject];
                [HttpRequestManager postUpdateUserImgRequest:nameString viewcontroller:self finishBlock:^(NSDictionary *data) {
                    if ([data[@"code"] intValue] == 200) {
                        
                        [[MyAlert manage] showNoBtnAlertWithTitle:@"提示" detailTitle:@"保存成功"];
                        //                    [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
                
            }];
        }];
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            //修改昵称
            NameChangeVC *vc = [[NameChangeVC alloc]init];
            vc.name = _model.name;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //账号管理
            AccountManageViewController *vc = [[AccountManageViewController alloc]init];
            vc.personModel = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //实名认证
            ZHRealNameAuthViewController *realNameAuthVC = [[UIStoryboard storyboardWithName:@"ZHPig" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(ZHRealNameAuthViewController.class)];
            [self.navigationController pushViewController:realNameAuthVC animated:YES];
        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            //清除缓存
            [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
                [[MyAlert manage]showBtnAlertWithTitle:@"清除缓存" detailTitle:[NSString stringWithFormat:@"是否清除%.2fM缓存",totalSize/1024.0/1024] confirm:^{
                    
                    [[SDImageCache sharedImageCache] clearDisk];
                    
                    [[MyAlert  manage] showNoBtnAlertWithTitle:@"清除缓存" detailTitle:@"清除缓存成功"];
                    [self.tableView reloadData];
                    
                }];
                
                
            }];
            
            
        }else if (indexPath.row==1){
            //意见反馈
            FeedBackVC2 *vc = [[FeedBackVC2 alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==2){
            //用户协议
            XiJuIntroduceVC *vc = [[XiJuIntroduceVC alloc]init];
            vc.isxieyi = YES;
            [self.navigationController pushViewController: vc  animated:YES];
        }else{
            //修改密码
            ChangePassWordVC *vc = [[ChangePassWordVC alloc]init];
            //    vc.changPassWord = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
