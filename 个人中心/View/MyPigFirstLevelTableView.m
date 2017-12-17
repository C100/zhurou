//
//  MyPigFirstLevelTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyPigFirstLevelTableView.h"
#import "MyPigFirstLevelCell.h"

@implementation MyPigFirstLevelTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc]init];
        self.estimatedRowHeight = 60;
        
        [self registerClass:[MyPigFirstLevelCell class] forCellReuseIdentifier:@"MyPigFirstLevelCell"];
        
        self.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.myPigs.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPigFirstLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPigFirstLevelCell" forIndexPath:indexPath];
    cell.listModel = self.myPigs[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.buyButton.tag = 100+indexPath.row;
    [cell.consumeButton addTarget:self action:@selector(consumeAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.consumeButton.tag = 200+indexPath.row;
    [cell.leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.leftButton.tag = 300+indexPath.row;
    [cell.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.rightButton.tag = 400+indexPath.row;
    [cell.giftedButton addTarget:self action:@selector(giftedAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.giftedButton.tag = 500+indexPath.row;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyPigListModel *listModel = self.myPigs[indexPath.section];
    if ([listModel.state integerValue] == 6) {
        if ([self.myPigFirstLevelTableViewDelegate respondsToSelector:@selector(enterOrderDetail)]) {
            [self.myPigFirstLevelTableViewDelegate enterOrderDetail];
        }
    }
}

-(void)buyAction:(UIButton *)sender{
   MyPigListModel *listModel = self.myPigs[sender.tag-100];
    [self.myPigFirstLevelTableViewDelegate buyActionWithModel:listModel];
}
-(void)consumeAction:(UIButton *)sender{
    MyPigListModel *listModel = self.myPigs[sender.tag-200];
    [self.myPigFirstLevelTableViewDelegate consumeActionWithModel:listModel andTitle:sender.titleLabel.text];
}
-(void)leftButtonAction:(UIButton *)sender{
    MyPigListModel *listModel = self.myPigs[sender.tag-300];
    [self.myPigFirstLevelTableViewDelegate leftButtonActionWithModel:listModel andTitle:sender.titleLabel.text];
}
-(void)rightButtonAction:(UIButton *)sender{
    MyPigListModel *listModel = self.myPigs[sender.tag-400];
    [self.myPigFirstLevelTableViewDelegate rightButtonActionWithModel:listModel andTitle:sender.titleLabel.text];
}

-(void)giftedAction:(UIButton *)sender{
    [self.myPigFirstLevelTableViewDelegate pigGifted];
}

-(void)setMyPigs:(NSArray *)myPigs{
    _myPigs = myPigs;
    [self reloadData];
}

@end
