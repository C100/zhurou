//
//  LoginAndResignVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "LoginAndRegisterVC.h"
#import "LoginVC.h"
#import "RegisterVC.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import "LoginView.h"
#import "ForgetPasswordVC.h"
#import "WritePersonalInfoVC.h"
#import "BindingPhoneVC.h"
#import "AgreementViewController.h"

@interface LoginAndRegisterVC ()

@property(nonatomic, strong) LoginView *loginView;

@end

@implementation LoginAndRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    self.navigationController.
    //    self.navigationController.navigationBarHidden = NO;
    //    //隐藏导航栏的背景色 背景透明
    [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIImageView *lineImageView = [Tool findHairlineImageViewUnder:self.navigationController.navigationBar];
    lineImageView.hidden = NO;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.isVistor == YES) {
        [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBarHidden = NO;
        //隐藏导航栏的背景色 背景透明
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar.subviews firstObject].hidden = YES;
    
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar.subviews firstObject].hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    UIImageView *lineImageView = [Tool findHairlineImageViewUnder:self.navigationController.navigationBar];
    lineImageView.hidden = YES;
}


#pragma mark intviewcontroller
-(void)prepareData
{
    
    
    
    
}

-(void)configUI
{
    
    //    self.navigationController.navigationBarHidden = YES;
    
    UIImageView *titleImgView = [[UIImageView alloc]init];
    titleImgView.image = [UIImage imageNamed:@"logopig"];
    titleImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:titleImgView];
    WS(ws)
    
    [titleImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 94));
        //        make.top.mas_offset(ScaleY(100));
        
        make.top.mas_equalTo(19);
        
        make.centerX.mas_equalTo(ws.view);
    }];
    
    
//    if (self.isVistor == YES) {
    
        UIImage *image = [[UIImage imageNamed:@"Group 3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
//    }
    
    
    /**
     * 底部按钮
     */
    // 第三方登录暂时隐藏
    /*
    CGFloat spaceWidth = (KHScreenW - 44 * 2)/3;
    UIButton *lastView = nil;
    NSArray *imgArr = @[@"qq (1)",@"微信"];
    for (int i = 0; i < imgArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        // btn.backgroundColor = [UIColor redColor];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *btnImg = [UIImage imageNamed: [[NSString alloc] initWithFormat:@"%@", imgArr[i]]];
        [btn setImage:btnImg forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn mas_updateConstraints:^(MASConstraintMaker *make) {
            //            if (i == 0) {
            //                make.left.mas_offset(50);
            //
            //            }else
            //            {
            //                make.left.mas_equalTo(lastView.mas_right).offset(spaceWidth);
            //            }
            make.left.mas_equalTo(spaceWidth*(i+1)+44*i);
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.bottom.mas_offset(ScaleY(-35));
        }];
        lastView = btn;
    }
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = The_line_Color_grary;
    [self.view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(50);
        make.right.mas_offset(-50);
        make.bottom.mas_equalTo(lastView.mas_top).offset(-25);
        make.height.mas_equalTo(1);
    }];
    
    
    UILabel *thirdLab = [Tool labelWithTitle:@"第三方登录" color:The_wordsColor fontSize:13 alignment:1];
    thirdLab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:thirdLab];
    
    [thirdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
        make.center.mas_equalTo(line);
        
    }];
     */
    
    self.loginView = [[LoginView alloc]init];
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(titleImgView.mas_bottom).mas_equalTo(ScaleY(83));
    }];
    
    [self.loginView.loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.eyeButton addTarget:self action:@selector(eyeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.forgetButton addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark buttonAction
-(void)forgetAction
{
    
    [self.view endEditing:YES];
    ForgetPasswordVC *vc = [[ForgetPasswordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)eyeAction
{
    UITextField *pwdTextField = [self.loginView viewWithTag:101];
    self.loginView.eyeButton.selected = !self.loginView.eyeButton.selected;
    
    pwdTextField.secureTextEntry = !self.loginView.eyeButton.selected;
    
    NSString* text = pwdTextField.text;
    pwdTextField.text = @"";
    pwdTextField.text = text;
    
}

-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 * 注册
 */
-(void)registerAction
{
//    AgreementViewController *vc = [[AgreementViewController alloc]init];
//    vc.topTitle = @"用户注册协议";
//    [self.navigationController pushViewController:vc animated:YES];
    RegisterVC *vc = [[RegisterVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 * 登录
 */
-(void)loginAction
{
    
    [self.view endEditing:YES];
    
    
    UITextField *phoneTextField = [self.loginView viewWithTag:100];
    UITextField *pwdTextField = [self.loginView viewWithTag:101];
    if (![phoneTextField.text isValidateMobile]) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"用户名或密码有误"];
        return;
    }
    
    if (pwdTextField.text.length < 6  || pwdTextField.text.length > 12) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"用户名或密码有误"];
        return;
    }
    
    
    NSDictionary *dic = @{@"mobile":phoneTextField.text,
                          @"password":pwdTextField.text,
                          };
    
    [HttpRequestManager postLoginRequest:dic viewcontroller:self finishBlock:^(NSDictionary *tempdic) {
        
    }];
}


-(void)btnAction:(UIButton *)btn
{
    
    NSUInteger userInfo = 999;
    
    switch (btn.tag) {
        case 101:
        {
            NSLog(@"微信");
            userInfo = SSDKPlatformTypeWechat;
            
        }
            break;
            
        case 100:
        {
            NSLog(@"qq");
            userInfo = SSDKPlatformTypeQQ;
        }
            break;
            
        default:
            break;
    }
    
    [ShareSDK getUserInfo:userInfo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         
         if (state == SSDKResponseStateSuccess){
             //             /front/regByUid.do?uid=&headUrl=&nickname=?
             if (!user.icon) {
                 user.icon = @"";
             }
             if (!user.nickname) {
                 user.nickname = @"";
             }
             
             //             NSLog(@"%@",user);
             NSString *headUrl = @"";
             if (userInfo == SSDKPlatformTypeQQ) {
                 if (user.rawData) {
                     if (user.rawData[@"figureurl_qq_2"]) {
                         headUrl = user.rawData[@"figureurl_qq_2"];
                     }
                 }
             }else{
                 if (user.icon) {
                     headUrl = user.icon;
                 }
             }
             
             
             NSDictionary *dic = @{@"uid":user.uid,
                                   @"headUrl":headUrl,
                                   @"nickname":user.nickname,
                                   };
             
             [HttpRequestManager postThirdLoginRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
                 
                 if ([data[@"code"] intValue] == 200) {
                     [[UserManager manage] thirdLoginSave:user.uid];
                     
//                     NSDictionary *infoDic = data[@"phone"];
                     if (!data[@"phone"]) {
                         //跳转到手机绑定
                         [self.navigationController pushViewController:[BindingPhoneVC new] animated:YES];
                     }
                     
                 }
                 
             }];
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
    
}





@end

