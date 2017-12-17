//
//  AddCreditTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AddCreditTableView.h"
#import "AddCreditCell.h"

@implementation AddCreditTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kF5F5F5Color;
        self.tableFooterView = [[UIView alloc]init];
        //注册
        [self registerClass:[AddCreditCell class] forCellReuseIdentifier:@"AddCreditCell"];
        self.placeholders = @[@[@"持卡人",@"请输入持卡人姓名"],@[@"卡户号",@"请输入开户号"],@[@"卡户行",@"请输入开户行"],@[@"手机号",@"请输入手机号"]];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return 1;
    }
    return self.placeholders.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddCreditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddCreditCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.infos = self.placeholders[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectButton.hidden = YES;
        cell.infoTextField.hidden = NO;
        if (self.infos) {
            cell.infoTextField.text = self.infos[indexPath.row];
        }
    }else{
        cell.infoLabel.text = @"默认银行卡";
        cell.selectButton.hidden = NO;
        cell.infoTextField.hidden = YES;
        [cell.selectButton addTarget:self action:@selector(isSetDefaultCreditCard:) forControlEvents:UIControlEventTouchUpInside];
        //点击的银行卡是否和存储的默认银行卡相同
        if (self.clickCreditModel.isDefault.intValue==1) {
            cell.selectButton.selected = YES;
            self.isDefault = @"default";
        }else{
            cell.selectButton.selected = NO;
            self.isDefault = @"NO";
        }
    }
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    return 343;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==1) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, 343)];
        bgView.backgroundColor = [UIColor clearColor];
        UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake((KHScreenW-280)/2, 343-40, 280, 40)];
        [bgView addSubview:submitButton];
        [submitButton setTitle:@"提交" forState:UIControlStateNormal];
        submitButton.backgroundColor = The_MainColor;
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitButton.titleLabel.font = kLightFont(14);
        [submitButton addTarget:self action:@selector(addCreditAction) forControlEvents:UIControlEventTouchUpInside];
        
        return bgView;
    }else{
        return nil;
    }
    
}

//是否选择默认银行卡
-(void)isSetDefaultCreditCard:(UIButton *)sender{
    sender.selected = YES;
    self.isDefault = @"default";
}

-(void)addCreditAction{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<self.placeholders.count; i++) {
        AddCreditCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.infoTextField.text.length==0) {//有没填的
            [LUtils toastview:@"请完善资料"];
            break;
        }else{
            [arr addObject:cell.infoTextField.text];
        }
    }
    if (arr.count == self.placeholders.count) {
        NSNumber *isDefaultNum = @(0);//不是默认
        if (self.isDefault&&[self.isDefault isEqualToString:@"default"]) {
            isDefaultNum = @(1);
        }
        [self.addCreditTableViewDelegate addCreditActionWithName:arr[0] andCreditNum:arr[1] andBank:arr[2] andPhoneNum:arr[3] andIsDefault:isDefaultNum andModel:self.clickCreditModel];
        
    }
}

-(void)setClickCreditModel:(CreditCardModel *)clickCreditModel{
    _clickCreditModel = clickCreditModel;
    if (clickCreditModel) {
        self.infos = @[clickCreditModel.owner,clickCreditModel.openNumber,clickCreditModel.openBank,clickCreditModel.cellphone];
        [self reloadData];
    }
    
}

@end
