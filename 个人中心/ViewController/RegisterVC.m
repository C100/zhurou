//
//  ResignVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "RegisterVC.h"
#import "WritePersonalInfoVC.h"
#import "RegAgreementViewController.h"


@interface RegisterVC ()
{
    UITextField *_phoneTextFild;
    UITextField *_yanzhenTextFild;
    UIButton *_sendBtn;
    UITextField *_passWordTextFild;
}


@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareData];
    [self configUI];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:The_MainColor] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"clearBackground"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//}

#pragma mark intviewcontroller
-(void)prepareData
{
    
}

-(void)configUI
{
    _phoneTextFild = [Tool textFildWithTitle:@"手机号" color:The_wordsColor fontSize:15 alignment:0];
    _phoneTextFild.borderWidth = 1;
    _phoneTextFild.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:_phoneTextFild];
    //    _phoneTextFild.frame = CGRectMake(35, 36, KHScreenW, <#CGFloat height#>)
    
    [_phoneTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_offset(36);
    }];
    
    
    _passWordTextFild=[Tool textFildWithTitle:@"请输入6-12位数字和字母密码" color:The_wordsColor fontSize:15 alignment:0];
    _passWordTextFild.borderWidth = 1;
    _passWordTextFild.keyboardType = UIKeyboardTypeDefault;
    
    [self.view addSubview:_passWordTextFild];
    
    UIButton *eyeBtn = [Tool buttonWithTitle:@"" titleColor:nil font:12 imageName:nil target:self action:@selector(eyeAction:)];
    eyeBtn.size = CGSizeMake(40, 40);
    [eyeBtn setImage:[UIImage imageNamed:@"biyan@2x.png"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"zhengyan@2x.png"] forState:UIControlStateSelected];
    
    _passWordTextFild.rightViewMode = UITextFieldViewModeAlways;
    _passWordTextFild.rightView =eyeBtn;
    _passWordTextFild.secureTextEntry = YES;
    _passWordTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_passWordTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_phoneTextFild.mas_bottom).offset(20);
    }];
    
    
    _yanzhenTextFild=[Tool textFildWithTitle:@"验证码" color:The_wordsColor fontSize:15 alignment:0];
    _yanzhenTextFild.borderWidth = 1;
    _yanzhenTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    _yanzhenTextFild.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_yanzhenTextFild];
    
    [_yanzhenTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35-90);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_passWordTextFild.mas_bottom).offset(20);
    }];
    
    _sendBtn = [Tool buttonWithTitle:@"发送" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(sendAction)];
    _sendBtn.backgroundColor = The_MainColor;
    [self.view addSubview:_sendBtn];
    [_sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yanzhenTextFild.mas_right).offset(10);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_passWordTextFild.mas_bottom).offset(20);
    }];
    
    UIButton *agreementButton = [[UIButton alloc]init];
    [agreementButton setTitle:@"我已阅读并同意此份协议" forState:UIControlStateNormal];
    [self.view addSubview:agreementButton];
    [agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(_yanzhenTextFild.mas_bottom).offset(65);
    }];
    [agreementButton setImage:[UIImage imageNamed:@"勾"] forState:UIControlStateNormal];
    [agreementButton setTitleColor:k555555Color forState:UIControlStateNormal];
    agreementButton.titleLabel.font = kFont(14);
    [agreementButton addTarget:self action:@selector(agreementAction) forControlEvents:UIControlEventTouchUpInside];
    agreementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    agreementButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    
    UIButton *loginBtn = [Tool buttonWithTitle:@"注册" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(nextAction)];
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
-(void)agreementAction{
    RegAgreementViewController *vc = [[RegAgreementViewController alloc]init];
    vc.topTitle = @"用户注册协议";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)nextAction
{
    
    
    
    //    WritePersonalInfoVC *vc = [[WritePersonalInfoVC alloc]init];
    //    vc.phone = _phoneTextFild.text;
    //    [self.navigationController pushViewController:vc animated:YES];
    [self.view endEditing:YES];
    
    if (![_phoneTextFild.text isValidateMobile]) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请输入正确的手机号码！"];
        return;
    }
    
    if (_passWordTextFild.text.length < 6 || _passWordTextFild.text.length > 12) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请输入6-12位数字和字母密码！"];
        return;
    }
    
    int i = [self checkIsHaveNumAndLetter:_passWordTextFild.text];
    if (i!=3) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请输入6-12位数字和字母密码！"];
        return;
    }
    
    
    if (_yanzhenTextFild.text.length == 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"验证码无效"];
        return;
        
    }
    
    NSDictionary *dic = @{@"mobile":_phoneTextFild.text,
                          @"password":_passWordTextFild.text,
                          @"registCode":_yanzhenTextFild.text,
                          };
    [HttpRequestManager postRegisterRequest:dic viewcontroller:self finishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 200) {
            
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"注册成功！"];
            
            WritePersonalInfoVC *vc = [[WritePersonalInfoVC alloc]init];
            vc.phone = _phoneTextFild.text;
            [self.navigationController pushViewController:vc animated:YES];
            [[UserManager manage] loginSave:dic[@"mobile"] password:dic[@"password"]];
            
            
            
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
        NSDictionary *dic = @{@"mobile":_phoneTextFild.text,
                              };
        
        
        
        
        [HttpRequestManager postGetCodeRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            
            if ([data[@"code"] intValue] == 200) {
                [[Tool tools] startTime:_sendBtn];
                
                [[MyAlert manage]showNoBtnAlertWithTitle:@"提醒" detailTitle:@"验证码发送成功！"];
                
            }
            
            
        }];
    }
}


-(void)eyeAction:(UIButton *)btn
{
    
    btn.selected = !btn.selected;
    
    _passWordTextFild.secureTextEntry = !btn.selected;
    
    NSString* text = _passWordTextFild.text;
    _passWordTextFild.text = @"";
    _passWordTextFild.text = text;
    
    
}


//直接调用这个方法就行
-(int)checkIsHaveNumAndLetter:(NSString*)password{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, password.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    if (tNumMatchCount == password.length) {
        //全部符合数字，表示沒有英文
        return 1;
    } else if (tLetterMatchCount == password.length) {
        //全部符合英文，表示沒有数字
        return 2;
    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return 3;
    } else {
        return 4;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
    
}

@end

