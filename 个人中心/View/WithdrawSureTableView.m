//
//  WithdrawTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WithdrawSureTableView.h"

@implementation WithdrawSureTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kF5F5F5Color;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.font = kFont(14);
        cell.textLabel.textColor = k888888Color;
        cell.detailTextLabel.font = kFont(14);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
        cell.textLabel.text = @"提现佣金";
        cell.detailTextLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.moneyTextField = [[UITextField alloc]init];
        [cell addSubview:self.moneyTextField];
        [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(cell.textLabel.mas_right).mas_equalTo(0);
        }];
        self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.moneyTextField.textAlignment = NSTextAlignmentRight;
        self.moneyTextField.textColor = k888888Color;
        self.moneyTextField.font = kFont(14);
        self.moneyTextField.placeholder = @"请输入提现佣金";
    }else{
        cell.textLabel.text = @"银行卡";
        cell.detailTextLabel.textColor = k888888Color;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //NSString *selectedCreditCard = [[NSUserDefaults standardUserDefaults]objectForKey:@"creditCard"];
        if (self.defaultCreditNum) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"尾号%@",self.defaultCreditNum];
        }else{
            cell.detailTextLabel.text = @"未设置";
        }
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [self.withdrawSureTableViewDelegate chooseCredit];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 320;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, 320)];
        bgView.backgroundColor = [UIColor clearColor];
        
        UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake((KHScreenW-280)/2, 40, 280, 40)];
        [bgView addSubview:sureButton];
        sureButton.backgroundColor = The_MainColor;
        [sureButton setTitle:@"发起提现" forState:UIControlStateNormal];
        sureButton.titleLabel.font = kLightFont(14);
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        return bgView;
    }
    return nil;
}

-(void)sureAction{
    UITableViewCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [self.withdrawSureTableViewDelegate withdrawActionWithCreditNum:cell.detailTextLabel.text];
}

-(void)setDefaultCreditNum:(NSString *)defaultCreditNum{
    _defaultCreditNum = defaultCreditNum;
    [self reloadData];
}

@end
