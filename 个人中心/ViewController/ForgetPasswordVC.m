//
//  ForgetPasswordVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/30.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "ResetPasswordVC.h"

@interface ForgetPasswordVC ()
{
    UITextField *_phoneTextFild;
    UITextField *_yanzhenTextFild;
    UIButton *_sendBtn;
}

@end

@implementation ForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_changPassWord) {
        self.title = @"修改密码";

    }else
    {
        self.title = @"忘记密码";

    }
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    
}

-(void)configUI
{
    _phoneTextFild=[Tool textFildWithTitle:@"手机号" color:The_wordsColor fontSize:15 alignment:0];
    _phoneTextFild.borderWidth = 1;
    _phoneTextFild.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_phoneTextFild];
    //    _phoneTextFild.frame = CGRectMake(35, 36, KHScreenW, <#CGFloat height#>)
    
    [_phoneTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_offset(36);
    }];
    
  
    
    _yanzhenTextFild=[Tool textFildWithTitle:@"验证码" color:The_wordsColor fontSize:15 alignment:0];
    _yanzhenTextFild.borderWidth = 1;
    [self.view addSubview:_yanzhenTextFild];
    
    [_yanzhenTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35-90);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_phoneTextFild.mas_bottom).offset(20);
    }];
    
    _sendBtn = [Tool buttonWithTitle:@"发送" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(sendAction)];
    _sendBtn.backgroundColor = The_MainColor;
    [self.view addSubview:_sendBtn];
    [_sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yanzhenTextFild.mas_right).offset(10);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_phoneTextFild.mas_bottom).offset(20);
    }];
    
    UIButton *loginBtn = [Tool buttonWithTitle:@"下一步" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(nextAction)];
    loginBtn.backgroundColor = The_MainColor;
    [self.view addSubview:loginBtn];
    [loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_yanzhenTextFild.mas_bottom).offset(100);
    }];
    
   }

#pragma mark buttonAction

-(void)nextAction
{
    
    [self.view endEditing:YES];

    if (![_phoneTextFild.text isValidateMobile]) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请输入正确的手机号码！"];
        return;
    }
    
    
    if (_yanzhenTextFild.text.length == 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"验证码不能为空"];
        return;
    }
    NSDictionary *dic = @{@"mobile":_phoneTextFild.text,
                          @"registCode":_yanzhenTextFild.text,
                          };
    
    [HttpRequestManager postValidateForgetCodeRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
        if ([data[@"code"] integerValue] == 200) {
            ResetPasswordVC *vc = [[ResetPasswordVC alloc]init];
            vc.forgetSign = data[@"forgetSign"];
            vc.phone = _phoneTextFild.text;
            vc.code = _yanzhenTextFild.text;
            [self.navigationController pushViewController:vc animated:YES];

        }
    }];
    
    
   
}

-(void)sendAction
{
    [self.view endEditing:YES];

    
    if (![_phoneTextFild.text isValidateMobile]) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请输入正确的手机号码！"];
        return;

    }else
    {
        [[Tool tools] startTime:_sendBtn];
        NSDictionary *dic = @{@"mobile":_phoneTextFild.text,
                              };
        

        [HttpRequestManager postGetForgetCodeRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            
            
        }];
    }
    
    
}



@end
