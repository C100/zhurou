//
//  ZHRealNameAuthViewController.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHRealNameAuthViewController.h"
#import "ZHScreenAdaptation.h"
#import "ZHCompactViewController.h"
#import "ZHPigNetwork.h"
#import <Lottie/Lottie.h>
#import "MBProgressHUD.h"
#import "AgreementViewController.h"

@interface ZHRealNameAuthViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *labelTop;
@property (nonatomic, weak) IBOutlet UILabel *labelBottom;

@property (nonatomic, weak) IBOutlet UILabel *labelName;
@property (nonatomic, weak) IBOutlet UILabel *labelIDCard;

@property (nonatomic, weak) IBOutlet UITextField *textFieldName;
@property (nonatomic, weak) IBOutlet UITextField *textFieldIDCard;

@property (nonatomic, weak) IBOutlet UIButton *buttonComplete;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonCompleteHeightConstraint;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *viewNameTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *viewNameHeightConstraint;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *viewNameLineLeftConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *viewIDCardLineLeftConstraint;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textFieldNameLeftConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textFieldIDCardLeftConstraint;

@end

@implementation ZHRealNameAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"实名认证";

    [self screenAdaptation];

    //设置导航栏的按钮
    UIBarButtonItem *backButton = [UIBarButtonItem itemWithImageName:@"NavbackView" highImageName:@"NavbackView" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)screenAdaptation {
    self.buttonCompleteHeightConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:50];
    self.viewNameTopConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:47];
    self.viewNameHeightConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:50];
    self.viewIDCardLineLeftConstraint.constant = self.viewNameLineLeftConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:120];
    self.textFieldNameLeftConstraint.constant = self.textFieldIDCardLeftConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:24];
    if ([ZHScreenAdaptation deviceHas4InchScreen]) {
        self.viewIDCardLineLeftConstraint.constant = self.viewNameLineLeftConstraint.constant = 105;
        self.textFieldNameLeftConstraint.constant = self.textFieldIDCardLeftConstraint.constant = 15;
    }

    self.buttonComplete.titleLabel.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:18]];
    self.labelTop.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]];
    self.labelBottom.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:12]];
    self.labelName.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:18]];
    self.labelIDCard.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:18]];
    self.textFieldName.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:18]];
    self.textFieldIDCard.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:18]];
}

- (IBAction)completeButtonClick:(id)sender {

    if (self.textFieldName.text.length <= 0 || self.textFieldIDCard.text.length <= 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请输入完整的信息"];
        return;
    }

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [[[ZHPigNetwork alloc] init] realNameAuthWithName:self.textFieldName.text IDCard:self.textFieldIDCard.text callback:^(BOOL status, NSString *message, id obj, NSString *code) {
        [hud hideAnimated:YES];
        if (status) {
            if ([self.fromVC isEqualToString:@"AuthConditionViewController"]) {
                AgreementViewController *vc = [[AgreementViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                ZHCompactViewController *compactVC = [[ZHCompactViewController alloc] init];
                compactVC.URLString = obj;
                [self.navigationController pushViewController:compactVC animated:YES];
            }
        } else {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:message];
        }
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (range.location >= 18) {
//        return NO;
//    }
    return YES;
}

@end
