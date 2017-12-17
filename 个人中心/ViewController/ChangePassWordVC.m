//
//  ChangePassWordVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/4.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "ChangePassWordVC.h"

@interface ChangePassWordVC ()<UITextFieldDelegate>
{

    UITextField *_oldPasswordTextFild;
    UITextField *_newPasswordTextFild;
    UITextField *_newPasswordTextFild2;

    UIButton *_sendBtn;
    UIButton *_loginBtn;
    

}
@end

@implementation ChangePassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)changeTextField:(UITextField *)sender{
    if ([sender isEqual:_oldPasswordTextFild]) {
        if (sender.text.length>0&&_newPasswordTextFild.text.length>0&&_newPasswordTextFild2.text.length>0) {
            _loginBtn.alpha = 1.0;
        }else{
            _loginBtn.alpha = .5;
        }
    }else if ([sender isEqual:_newPasswordTextFild]){
        if (![sender.text isEqualToString:@""]&&![_oldPasswordTextFild.text isEqualToString:@""]&&_newPasswordTextFild2.text.length>0) {
            _loginBtn.alpha = 1.0;
        }else{
            _loginBtn.alpha = .5;
        }
    }else{
        if (![sender.text isEqualToString:@""]&&![_oldPasswordTextFild.text isEqualToString:@""]&&_newPasswordTextFild.text.length>0) {
            _loginBtn.alpha = 1.0;
        }else{
            _loginBtn.alpha = .5;
        }
    }
}


-(void)prepareData
{
    
}

-(void)configUI
{
    self.title = @"修改密码";
    
    _oldPasswordTextFild=[Tool textFildWithTitle:@"请输入原密码" color:The_wordsColor fontSize:15 alignment:0];
    _oldPasswordTextFild.borderWidth = 1;
//    _oldPasswordTextFild.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_oldPasswordTextFild];
    [_oldPasswordTextFild addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
    
    [_oldPasswordTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_offset(36);
    }];
    
    UIButton *eyeBtn = [Tool buttonWithTitle:@"" titleColor:nil font:12 imageName:nil target:self action:@selector(eyeAction:)];
    eyeBtn.selected = NO;
    eyeBtn.size = CGSizeMake(40, 40);
    [eyeBtn setImage:[UIImage imageNamed:@"biyan@2x.png"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"zhengyan@2x.png"] forState:UIControlStateSelected];
    
    _oldPasswordTextFild.rightViewMode = UITextFieldViewModeAlways;
    _oldPasswordTextFild.rightView =eyeBtn;
    _oldPasswordTextFild.secureTextEntry = YES;
    _oldPasswordTextFild.delegate = self;
    
    

    _newPasswordTextFild=[Tool textFildWithTitle:@"6-12位数字和字母的新密码" color:The_wordsColor fontSize:15 alignment:0];
    _newPasswordTextFild.borderWidth = 1;
//    _newPasswordTextFild.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_newPasswordTextFild];
    _newPasswordTextFild.delegate = self;
    [_newPasswordTextFild addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
    
    [_newPasswordTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_oldPasswordTextFild.mas_bottom).offset(20);
    }];

    
    UIButton *eyeBtn1 = [Tool buttonWithTitle:@"" titleColor:nil font:12 imageName:nil target:self action:@selector(eyeAction1:)];
    eyeBtn1.selected = NO;
    eyeBtn1.size = CGSizeMake(40, 40);
    [eyeBtn1 setImage:[UIImage imageNamed:@"biyan@2x.png"] forState:UIControlStateNormal];
    [eyeBtn1 setImage:[UIImage imageNamed:@"zhengyan@2x.png"] forState:UIControlStateSelected];
    
    _newPasswordTextFild.rightViewMode = UITextFieldViewModeAlways;
    _newPasswordTextFild.rightView =eyeBtn1;
    _newPasswordTextFild.secureTextEntry = YES;
    
    _newPasswordTextFild2=[Tool textFildWithTitle:@"再次输入6-12位数字和字母的新密码" color:The_wordsColor fontSize:15 alignment:0];
    
    _newPasswordTextFild2.borderWidth = 1;
//    _newPasswordTextFild2.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_newPasswordTextFild2];
    [_newPasswordTextFild2 addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
    [_newPasswordTextFild2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_newPasswordTextFild.mas_bottom).offset(20);
    }];
    _newPasswordTextFild2.delegate = self;

    
    UIButton *eyeBtn2 = [Tool buttonWithTitle:@"" titleColor:nil font:12 imageName:nil target:self action:@selector(eyeAction2:)];
    eyeBtn2.selected = NO;
    eyeBtn2.size = CGSizeMake(40, 40);
    [eyeBtn2 setImage:[UIImage imageNamed:@"biyan@2x.png"] forState:UIControlStateNormal];
    [eyeBtn2 setImage:[UIImage imageNamed:@"zhengyan@2x.png"] forState:UIControlStateSelected];
    
    _newPasswordTextFild2.rightViewMode = UITextFieldViewModeAlways;
    _newPasswordTextFild2.rightView =eyeBtn2;
    _newPasswordTextFild2.secureTextEntry = YES;
    
    
    UIButton *loginBtn = [Tool buttonWithTitle:@"完成" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(finshAction)];
    loginBtn.backgroundColor = The_MainColor;
    _loginBtn = loginBtn;
    _loginBtn.alpha = .5;
    [self.view addSubview:loginBtn];
    [loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_newPasswordTextFild2.mas_bottom).offset(100);
    }];
}

#pragma mark buttonAction

-(void)eyeAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    _oldPasswordTextFild.secureTextEntry = !sender.selected;
    
    NSString* text = _oldPasswordTextFild.text;
    _oldPasswordTextFild.text = @"";
    _oldPasswordTextFild.text = text;
}
-(void)eyeAction1:(UIButton *)sender{
    sender.selected = !sender.selected;
     _newPasswordTextFild.secureTextEntry = !sender.selected;
    
    NSString* text = _newPasswordTextFild.text;
    _newPasswordTextFild.text = @"";
    _newPasswordTextFild.text = text;
}
-(void)eyeAction2:(UIButton *)sender{
    sender.selected = !sender.selected;
    _newPasswordTextFild2.secureTextEntry = !sender.selected;
    
    NSString* text = _newPasswordTextFild2.text;
    _newPasswordTextFild2.text = @"";
    _newPasswordTextFild2.text = text;
}

-(void)finshAction
{
    
    [self.view endEditing:YES];
    if (_oldPasswordTextFild.text.length==0||_newPasswordTextFild.text.length==0||_newPasswordTextFild2.text.length==0) {
        return;
    }

    if (_oldPasswordTextFild.text.length < 6 || _oldPasswordTextFild.text.length > 12) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"原密码格式有误！"];
        return;
    }
    
    if (_newPasswordTextFild.text.length < 6 || _newPasswordTextFild.text.length > 12||[self checkIsHaveNumAndLetter:_newPasswordTextFild.text]!=3) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"新密码格式有误！"];
        return;
    }
    
    if ([_oldPasswordTextFild.text isEqualToString:_newPasswordTextFild2.text]) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"原密码不能与新密码相同！"];
        return;
    }
    

    if (![_newPasswordTextFild.text isEqualToString:_newPasswordTextFild2.text]) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"新密码输入不一致！"];
        return;
    }
    
    NSDictionary *dic = @{@"oldPassword":_oldPasswordTextFild.text,
                          @"newPassword":_newPasswordTextFild2.text,
                          };
    
   [HttpRequestManager postChangePasswordRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
       
   }];
    
}


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
