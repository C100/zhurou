//
//  PerfectCodeViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/5.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "PerfectCodeViewController.h"


@interface PerfectCodeViewController ()

@property(nonatomic, strong) UITextField *codeTextField;

@end

@implementation PerfectCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"邀请码填写";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(perfectCode)];
    [self configUI];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

-(void)perfectCode{
    if (self.codeTextField.text.length==0) {
        [LUtils toastview:@"请输入邀请码"];
    }else{
        [HttpRequestManager postMyInvitionCodeWithUserName:self.personModel.name andCode:self.codeTextField.text andFinishBlock:^(NSDictionary *dataDic) {
            NSNumber *num = dataDic[@"code"];
            if (num.intValue==246) {
                [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"无效的邀请码"];
                return ;
            }
            if (num.intValue==200) {
                _callBack(@"");
            }
        }];
    }
}

-(void)configUI{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, 44)];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [Tool labelWithTitle:@"邀请码" color:k666666Color fontSize:16 alignment:0];
    [bgView addSubview:titleLabel];
    [titleLabel sizeToFit];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(titleLabel.bounds.size.width, 20));
    }];
    
    self.codeTextField = [[UITextField alloc]init];
    self.codeTextField.placeholder = @"请输入邀请码";
    self.codeTextField.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(titleLabel.mas_right);
    }];
    
    
    UILabel *noteLabel = [Tool labelWithTitle:@"确认后不可修改" color:The_MainColor fontSize:12 alignment:0];
    [self.view addSubview:noteLabel];
    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
    }];
}

@end
