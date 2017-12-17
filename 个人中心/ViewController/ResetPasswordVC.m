//
//  ResetPasswordVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/30.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "ResetPasswordVC.h"
#import "LoginVC.h"

@interface ResetPasswordVC ()
{
    UITextField *_passWordTextFild;
}

@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
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
    _passWordTextFild=[Tool textFildWithTitle:@"请输入6-12位数字和字母新密码" color:The_wordsColor fontSize:14 alignment:0];
    _passWordTextFild.borderWidth = 1;
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
        make.top.mas_offset(36);
    }];
    
    UIButton *loginBtn = [Tool buttonWithTitle:@"完成" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(finshAction)];
    loginBtn.backgroundColor = The_MainColor;
    [self.view addSubview:loginBtn];
    [loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_passWordTextFild.mas_bottom).offset(160);
    }];
}

#pragma mark buttonAction

-(void)eyeAction:(UIButton *)btn
{
    
    btn.selected = !btn.selected;
    
    _passWordTextFild.secureTextEntry = !btn.selected;
    NSString* text = _passWordTextFild.text;
    _passWordTextFild.text = @"";
    _passWordTextFild.text = text;

}

-(void)finshAction
{
    
    
    [self.view endEditing:YES];
    
    if (_passWordTextFild.text.length < 6 || _passWordTextFild.text.length > 12) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"密码格式有误！"];
        return;
    }

    int i = [self checkIsHaveNumAndLetter:_passWordTextFild.text];
    if (i!=3) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请输入6-12位数字和字母密码！"];
        return;
    }
    
    
    NSDictionary *dic = @{@"password":_passWordTextFild.text,
                          @"mobile":_phone,
                          @"registCode":_code,
                          @"forgetSign":self.forgetSign
                          };
    __weak __typeof(self)weakSelf = self;
    [HttpRequestManager postForgetPassWordRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
        if (data) {
            //返回登录界面
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.navigationController pushViewController:[LoginVC new] animated:YES];
            });
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"shoppingCarChange" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }
    }];
    
    
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
