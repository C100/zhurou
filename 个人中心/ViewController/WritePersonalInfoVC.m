//
//  WritePersonalInfoVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "WritePersonalInfoVC.h"
#import "UITools.h"
#import "HSLimitText.h"
#import "OSSMoreImageUpload.h"

@interface WritePersonalInfoVC ()<HSLimitTextDelegate>
{
    UIButton *_titleBtn;
    HSLimitText *_nameTextFild;
    UILabel *_numLab;
    UITextField *_codeTextField;
}

@end

@implementation WritePersonalInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善信息";
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    [self configUI];
}

#pragma mark intviewcontroller
-(void)prepareData
{
    _titleBtn = [[UIButton alloc]init];
//    _titleBtn.imageView.cornerRadius = 50;
    [_titleBtn setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    [_titleBtn addTarget:self action:@selector(touxiangAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_titleBtn];
//    _titleBtn.imageView.clipsToBounds = YES;
    [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_offset(40);
    }];
    
    UILabel *touxiangLab = [Tool labelWithTitle:@"点击图片上传头像" color:The_placeholder_Color_grary fontSize:13 alignment:1];
    [self.view addSubview:touxiangLab];
    [touxiangLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(_titleBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
    }];
    
    UIImageView *nameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"输入昵称"]];
    [self.view addSubview:nameImageView];
    [nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.top.mas_equalTo(touxiangLab.mas_bottom).mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    _nameTextFild=[self textFildWithTitle:@"请输入昵称" color:The_wordsColor fontSize:15 alignment:0];
//    _nameTextFild.borderWidth = 1;
    _nameTextFild.textField.text = _phone;
    _nameTextFild.maxLength = 11;
    [self.view addSubview:_nameTextFild];
    _nameTextFild.delegate = self;


    _numLab = [Tool labelWithTitle:@"0/11" color:The_TitleColor fontSize:15 alignment:1];
    _numLab.size = CGSizeMake(40, 40);
    _nameTextFild.textField.rightView=_numLab;
    _nameTextFild.textField.rightViewMode = UITextFieldViewModeAlways;
    _numLab.text = [NSString stringWithFormat:@"%d/%d",(int)_phone.length,11];
    
    
    [_nameTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameImageView.mas_right).mas_equalTo(12);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(touxiangLab.mas_bottom).mas_equalTo(13);
    }];

    //    _phoneTextFild.frame = CGRectMake(35, 36, KHScreenW, 40)
    
    UIView *linView = [[UIView alloc]init];
    [self.view addSubview:linView];
    linView.backgroundColor = kD8D8D8Color;
    [linView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.right.mas_equalTo(-17);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(_nameTextFild.mas_bottom).mas_equalTo(5);
    }];
    

    UIImageView *codeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"输入邀请码"]];
    [self.view addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.top.mas_equalTo(linView.mas_bottom).mas_equalTo(32);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    _codeTextField = [[UITextField alloc]init];

    _codeTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入邀请码" attributes:@{NSFontAttributeName:kFont(16),NSForegroundColorAttributeName:kAEAEAEColor}];
    [self.view addSubview:_codeTextField];
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(linView.mas_bottom).mas_equalTo(27);
        make.right.mas_equalTo(-100);
        make.left.mas_equalTo(codeImageView.mas_right).mas_equalTo(12);
        make.height.mas_equalTo(30);
    }];

    UIView *linView2 = [[UIView alloc]init];
    [self.view addSubview:linView2];
    linView2.backgroundColor = kD8D8D8Color;
    [linView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.right.mas_equalTo(-17);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(_codeTextField.mas_bottom).mas_equalTo(10);
    }];
    
    
    
    UIButton *loginBtn = [Tool buttonWithTitle:@"确认" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(finshAction)];
    loginBtn.backgroundColor = The_MainColor;
    [self.view addSubview:loginBtn];
    [loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(linView2.mas_bottom).offset(60);
    }];
    
    
   UIBarButtonItem *leftBar = [Tool BarButtonItemWithName:@"" font:12 target:self action:nil];
    UIBarButtonItem *rightBar = [Tool BarButtonItemWithName:@"跳过" font:15 target:self action:@selector(tiaoguo)];

    self.navigationItem.leftBarButtonItems = @[leftBar];
    self.navigationItem.rightBarButtonItems = @[rightBar];


}

-(void)tiaoguo
{
    [self.view endEditing:YES];

    UIViewController *firstVC =   self.navigationController.viewControllers[0];
    [firstVC dismissViewControllerAnimated:YES completion:nil];
}

-(void)configUI
{
    
}

-(void)finshAction
{
    [self.view endEditing:YES];

    
    if (_nameTextFild.textField.text == 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"昵称不能为空！"];
        return;
    }
    
    BXLog(@"");
    BXLog(@"%@",_nameTextFild.textField.text);
    
    NSMutableDictionary *dicCode = [[NSMutableDictionary alloc]init];
    if (_codeTextField.text.length>0) {
        [dicCode setObject:_codeTextField.text forKey:@"userCode"];
    }
    
    [HttpRequestManager postMyInvitionCodeWithUserName:_nameTextFild.textField.text andCode:nil andFinishBlock:^(NSDictionary *dictt) {
        NSNumber *num = dictt[@"code"];

        if (num.intValue != 200) {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"用户名修改失败"];
            return ;
        }
        
        [HttpRequestManager postUpdateUserNameRequest:dicCode viewcontroller:self finishBlock:^(NSDictionary *data) {
            
            NSNumber *num = [data objectForKey:@"code"];
            if (num.intValue == 246) {
                [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"无效的邀请码"];
                return ;
            }
            
            [OSSMoreImageUpload uploadImages:@[_titleBtn.imageView.image] isAsync:YES type:@(2) complete:^(NSArray<NSString *> *names, UploadImageState state, NSDictionary *dataDic) {
                
                NSString *downLoad = dataDic[@"download"];
                NSArray *images = [downLoad componentsSeparatedByString:@"/"];
                NSString *nameString = [NSString stringWithFormat:@"%@/%@/%@/%@",images[0],images[1],images[2],names.firstObject];
                [HttpRequestManager postUpdateUserImgRequest:nameString viewcontroller:self finishBlock:^(NSDictionary *data) {
                    if ([data[@"code"] intValue] == 200) {
                        UIViewController *firstVC =   self.navigationController.viewControllers[0];
                        [firstVC dismissViewControllerAnimated:YES completion:nil];
                    }
                }];
                
            }];
            
        }];
        
        
    }];
    
    
    
}

-(void)touxiangAction
{
    
    [self.view endEditing:YES];

    [UITools selectImageFrom:self complete:^(UIImage *img) {
        [_titleBtn setImage:img forState:UIControlStateNormal];
        
    }];
    
}


#pragma mark buttonAction
-(HSLimitText *)textFildWithTitle:(NSString *)placeholder color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment
{
    HSLimitText *textFild = [[HSLimitText alloc] init];
    UIView *leftView = [[UIView alloc]init];
    leftView.width = 10;
    textFild.textField.leftViewMode = UITextFieldViewModeAlways;
    textFild.textField.leftView =leftView;
    
    textFild.placeholder = placeholder;
    textFild.textField.textColor = color;
    textFild.textField.font = [UIFont fontWithName:The_titleFont size:fontSize];
    textFild.borderColor = The_line_Color_grary;
    textFild.borderWidth = 0;
    //    label.font = [UIFont systemFontOfSize:fontSize];
    if (alignment) {
        textFild.textField.textAlignment = alignment;
    }
    [textFild sizeToFit];
    
    return textFild;
    
}

- (void)limitTextLimitInput:(HSLimitText *)textLimitInput text:(NSString *)text
{
       _numLab.text = [NSString stringWithFormat:@"%d/%d",(int)text.length,11];
       
}


@end
