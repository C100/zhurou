//
//  AuthConditionViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AuthConditionViewController.h"
#import "AuthConditionView.h"
#import "AgreementViewController.h"
#import "AuthConditionModel.h"
#import "ZHRealNameAuthViewController.h"

@interface AuthConditionViewController ()

@property(nonatomic, strong) AuthConditionView *conditionView;

@end

@implementation AuthConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请条件";
    
    self.conditionView = [[AuthConditionView alloc]init];
    [self.conditionView.sureButton addTarget:self action:@selector(conditionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.conditionView];
    [self.conditionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self requestData];
}

-(void)requestData{
    [HttpRequestManager judgeIsHasConditionWithFinishBlock:^(AuthConditionModel *model) {
        if (model) {
            self.conditionView.authModel = model;
        }
    }];
}

-(void)conditionAction{
    if (self.conditionView.authModel.isRealName.intValue==0) {
        //未实名认证
        ZHRealNameAuthViewController *realNameAuthVC = [[UIStoryboard storyboardWithName:@"ZHPig" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(ZHRealNameAuthViewController.class)];
        realNameAuthVC.fromVC = @"AuthConditionViewController";
        [self.navigationController pushViewController:realNameAuthVC animated:YES];
    }else{
        AgreementViewController *vc = [[AgreementViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


@end

