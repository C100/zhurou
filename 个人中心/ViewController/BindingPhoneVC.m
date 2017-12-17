//
//  BindingPhoneVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/12/2.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "BindingPhoneVC.h"

@interface BindingPhoneVC ()
{
    UITextField *_phoneTextFild;
    UITextField *_yanzhenTextFild;
    UIButton *_sendBtn;
    UITextField *_passWordTextFild;

}

@end

@implementation BindingPhoneVC

-(void)dealloc{
    NSLog(@"");
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"绑定手机";
    self.view.backgroundColor  = [UIColor whiteColor];
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
    
    
    
    _passWordTextFild=[Tool textFildWithTitle:@"请输入6-12位数字和字母密码" color:The_wordsColor fontSize:15 alignment:0];
    _passWordTextFild.borderWidth = 1;
    _passWordTextFild.keyboardType = UIKeyboardTypeASCIICapable;
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

    
    
    _yanzhenTextFild=[Tool textFildWithTitle:@"验证码" color:The_wordsColor fontSize:15 alignment:0];
    _yanzhenTextFild.borderWidth = 1;
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
    
    UIButton *loginBtn = [Tool buttonWithTitle:@"完成" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(nextAction)];
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
    
    
    
    //    WritePersonalInfoVC *vc = [[WritePersonalInfoVC alloc]init];
    //    vc.phone = _phoneTextFild.text;
    //    [self.navigationController pushViewController:vc animated:YES];
    [self.view endEditing:YES];
    
    if (![_phoneTextFild.text isValidateMobile]) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请输入正确的手机号码！"];
        return;
    }
    
    if (_passWordTextFild.text.length < 6 || _passWordTextFild.text.length > 12) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请输入6-12位数字或字母密码！"];
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
            
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"手机绑定成功！"];
            
            [[UserManager manage] loginSave:dic[@"mobile"] password:dic[@"password"]];
//            _callBack(@"");
//            [self.navigationController popViewControllerAnimated:YES];
            [self popFirstVC:self];
            //            [[UserManager manage] loginSave:pragrmDic[@"mobile"] password:pragrmDic[@"password"]];
            
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"shoppingCarChange" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
        }
        
    }];
    
}

-(void)popFirstVC:(UIViewController *)VC
{
    UIViewController *firstVC =   VC.navigationController.viewControllers[0];
    [firstVC dismissViewControllerAnimated:NO completion:^{

        UINavigationController *nav = (UINavigationController *)[[UIApplication appDelegate] window].rootViewController;
        [nav popToRootViewControllerAnimated:YES];
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




@end
