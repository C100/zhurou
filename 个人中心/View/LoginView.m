//
//  LoginView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/30.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

-(instancetype)init{
    self=[super init];
    if (self) {
        self.contents = @[@"请输入您的手机号",@"请输入6-16位数字和字母密码"];
        self.images = @[@"输入手机号码",@"输入短信验证码"];
        for (int i = 0; i<2; i++) {
            UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.images[i]]];
            [self addSubview:iconImageView];
            [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(16);
                make.size.mas_equalTo(CGSizeMake(18, 18));
                if (i==0) {
                    make.top.mas_equalTo(8);
                }else{
                    make.top.mas_equalTo(70);
                }
            }];
            UITextField *myTextField = [[UITextField alloc]init];
            myTextField.tag = 100+i;
            myTextField.placeholder = self.contents[i];
            [self addSubview:myTextField];
            [myTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(iconImageView.mas_right).mas_equalTo(12);
                make.right.mas_equalTo(-50);
                if (i==0) {
                    make.top.mas_equalTo(5);
                }else{
                    make.top.mas_equalTo(66);
                }
                make.height.mas_equalTo(30);
            }];
            
            
            [self setTextFieldStyle:myTextField];
        }
        
        self.loginButton = [[UIButton alloc]init];
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.loginButton setBackgroundColor:The_MainColor];
        self.loginButton.layer.cornerRadius = 4;
        self.loginButton.titleLabel.font = kFont(18);
        [self addSubview:self.loginButton];
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-16);
            make.height.mas_equalTo(48);
            make.top.mas_equalTo(self.lastView.mas_bottom).mas_equalTo(25);
        }];
        
        self.registerButton = [[UIButton alloc]init];
        [self.registerButton setTitle:@"新用户注册" forState:UIControlStateNormal];
        [self.registerButton setTitleColor:The_MainColor forState:UIControlStateNormal];
        self.registerButton.titleLabel.font = kFont(16);
        [self addSubview:self.registerButton];
        [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(23);
            make.height.mas_equalTo(16);
            make.top.mas_equalTo(self.loginButton.mas_bottom).mas_equalTo(20);
        }];
        
        self.forgetButton = [[UIButton alloc]init];
        [self.forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [self.forgetButton setTitleColor:The_MainColor forState:UIControlStateNormal];
        self.forgetButton.titleLabel.font = kFont(16);
        [self addSubview:self.forgetButton];
        [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-23);
            make.height.mas_equalTo(16);
            make.top.mas_equalTo(self.loginButton.mas_bottom).mas_equalTo(20);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)setTextFieldStyle:(UITextField *)sender{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kD8D8D8Color;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sender.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
    }];

    sender.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:sender.placeholder attributes:@{NSFontAttributeName:kFont(16),NSForegroundColorAttributeName:kAEAEAEColor}];

    if (sender.tag==101) {
        sender.secureTextEntry = YES;
        self.eyeButton = [[UIButton alloc]init];
        [self.eyeButton setImage:[UIImage imageNamed:@"noPwd"] forState:UIControlStateNormal];
        [self.eyeButton setImage:[UIImage imageNamed:@"seePwd"] forState:UIControlStateSelected];
        [self addSubview:self.eyeButton];
        self.eyeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(lineView.mas_top).mas_equalTo(-3);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];

        self.lastView = lineView;
    }

}

@end
