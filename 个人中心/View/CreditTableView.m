//
//  CreditTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "CreditTableView.h"
#import "CreditCell.h"
#import "IQUIView+Hierarchy.h"
#import "AddCreditViewController.h"
#import "CreditCardModel.h"

@implementation CreditTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate =self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc]init];
        self.lastSelectTag = -1;
        self.backgroundColor = kF5F5F5Color;
        
        //注册
        [self registerClass:[CreditCell class] forCellReuseIdentifier:@"CreditCell"];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infos.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CreditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreditCell" forIndexPath:indexPath];
    cell.selectButton.tag = 100+indexPath.row;
    cell.selectButton.hidden = YES;
    //[cell.selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
//    cell.selectedCardNum = self.selectedCardNum;
    cell.model = self.infos[indexPath.row];
    
    //若已有选中的银行卡
//    if ([cell.cardNumLabel.text isEqualToString:self.selectedCardNum]) {
//        cell.selectButton.selected = YES;
//        self.lastSelectTag = indexPath.row;
//    }else{
//        cell.selectButton.selected = NO;
//    }
//    if (self.infos.count==1) {
//        cell.selectButton.selected = YES;
//        cell.selectButton.hidden = NO;
////        [[NSUserDefaults standardUserDefaults]setObject:[cell.cardNumLabel.text substringFromIndex:2] forKey:@"creditCard"];
////        [[NSUserDefaults standardUserDefaults]synchronize];
//    }else{
        //选中的银行卡
        if (cell.model.creditId.intValue==self.selectedCardModel.creditId.intValue) {
            cell.selectButton.hidden = NO;
            cell.selectButton.selected = YES;
        }
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //DSLog(@"点击了删除");
        [self deleteCreditCardWithIndexPath:indexPath];
    }];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //DSLog(@"点击了编辑");
//        AddCreditViewController *vc = [[AddCreditViewController alloc]init];
//        CreditCell *cell = [self cellForRowAtIndexPath:indexPath];
//        vc.clickCreditCardNum = [cell.cardNumLabel.text substringFromIndex:2];
//        vc.navigationTitle = @"编辑银行卡";
//        [[self viewController].navigationController pushViewController:vc animated:YES];
        CreditCardModel *model = self.infos[indexPath.row];
        [self.creditTableViewDelegate editCreditCardInfoWithModel:model];
    }];
    editAction.backgroundColor = [UIColor grayColor];
    return @[deleteAction, editAction];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    CreditCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelectTag inSection:0]];
    //选中了某张银行卡
    CreditCardModel *model = self.infos[indexPath.row];
    [self.creditTableViewDelegate chooseCreditWithCardNum:model];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
}

#pragma mark method
//删除银行卡操作
-(void)deleteCreditCardWithIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否删除该银行卡？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CreditCardModel *model = self.infos[indexPath.row];
//        NSArray *infos = self.infos[indexPath.row];
//        NSString *selectedCredit = [[NSUserDefaults standardUserDefaults]objectForKey:@"creditCard"];
//        if ([infos.lastObject isEqualToString:selectedCredit]) {//删除的是默认银行卡
//            if (self.infos.count>1) {
//                NSArray *firstArr = self.infos.firstObject;
//                [[NSUserDefaults standardUserDefaults]setObject:firstArr.lastObject forKey:@"creditCard"];
//            }
//            
//        }else if ([infos.lastObject isEqualToString:[self.selectedCardNum substringFromIndex:2]]){//删除的是选中的卡
//            //默认选中默认银行卡
//            
//        }
        
        
        
        [self.infos removeObjectAtIndex:indexPath.row];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [self reloadData];
//        NSString *cardNum = self.selectedCardModel.openNumber;
        [self.creditTableViewDelegate deleteCreditCardWithModel:model andSelectedModel:self.selectedCardModel];
        
        
    }];
    UIAlertAction *a3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:a1];
    [alert addAction:a3];
    
    [[self viewController] presentViewController:alert animated:YES completion:nil];
}

-(void)selectAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    NSInteger tag = sender.tag-100;
    if (tag != self.lastSelectTag) {
        CreditCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelectTag inSection:0]];
        cell.selectButton.selected = NO;
        
    }
    if (sender.selected == NO) {
        [self.creditTableViewDelegate chooseCreditWithCardNum:nil];
    }else{
        NSArray *infos = self.infos[tag];
        [self.creditTableViewDelegate chooseCreditWithCardNum:infos.lastObject];
    }
    self.lastSelectTag = tag;
}

#pragma life cicle
-(void)setInfos:(NSMutableArray *)infos{
    _infos = infos;
    [self reloadData];
}

@end
