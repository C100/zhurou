//
//  LoginVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/30.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "LoginVC.h"
#import "ForgetPasswordVC.h"

@interface LoginVC ()
{
    UITextField *_phoneTextFild;
    UITextField *_passWordTextFild;

}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController.navigationBar.subviews firstObject].hidden = NO;
}

-(void)configUI
{
    
    _phoneTextFild=[Tool textFildWithTitle:@"手机号" color:The_wordsColor fontSize:15 alignment:0];
    _phoneTextFild.borderWidth = 1;
    _phoneTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
       [self.view addSubview:_phoneTextFild];
//    _phoneTextFild.frame = CGRectMake(35, 36, KHScreenW, <#CGFloat height#>)
    _phoneTextFild.keyboardType = UIKeyboardTypePhonePad;

    [_phoneTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_offset(36);
    }];
    
    _passWordTextFild=[Tool textFildWithTitle:@"请输入6-12位数字和字母密码" color:The_wordsColor fontSize:15 alignment:0];
    _passWordTextFild.borderWidth = 1;
    _passWordTextFild.keyboardType = UIKeyboardTypeDefault;
//    _passWordTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;

    [self.view addSubview:_passWordTextFild];
    
    UIButton *eyeBtn = [Tool buttonWithTitle:@"" titleColor:nil font:12 imageName:nil target:self action:@selector(eyeAction:)];
    eyeBtn.size = CGSizeMake(40, 40);
    [eyeBtn setImage:[UIImage imageNamed:@"biyan@2x.png"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"zhengyan@2x.png"] forState:UIControlStateSelected];

    _passWordTextFild.rightViewMode = UITextFieldViewModeAlways;
    _passWordTextFild.rightView =eyeBtn;
    _passWordTextFild.secureTextEntry = YES;

    [_passWordTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_phoneTextFild.mas_bottom).offset(20);
    }];
    
    UIButton *loginBtn = [Tool buttonWithTitle:@"登录" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(loginAction)];
    loginBtn.backgroundColor = The_MainColor;
    [self.view addSubview:loginBtn];
    [loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_passWordTextFild.mas_bottom).offset(100);
    }];
    
    UIButton *forgetBtn = [Tool buttonWithTitle:@"忘记密码?" titleColor:The_wordsColor font:14 imageName:nil target:self action:@selector(forgetAction)];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(5);
    }];
}

#pragma mark buttonAction
-(void)loginAction
{
    [self.view endEditing:YES];
    
    if (![_phoneTextFild.text isValidateMobile]) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"用户名或密码有误"];
        return;
    }
    
    if (_passWordTextFild.text.length < 6  || _passWordTextFild.text.length > 12) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"用户名或密码有误"];
        return;
    }


    NSDictionary *dic = @{@"mobile":_phoneTextFild.text,
        @"password":_passWordTextFild.text,
    };
    
  [HttpRequestManager postLoginRequest:dic viewcontroller:self finishBlock:^(NSDictionary *tempdic) {
      
  }];
}

-(void)forgetAction
{
    [self.view endEditing:YES];
    ForgetPasswordVC *vc = [[ForgetPasswordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)eyeAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    _passWordTextFild.secureTextEntry = !btn.selected;
    
    NSString* text = _passWordTextFild.text;
    _passWordTextFild.text = @"";
    _passWordTextFild.text = text;
}

@end
