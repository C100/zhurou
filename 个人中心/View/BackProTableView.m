//
//  BackProTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProTableView.h"
#import "BackProductHeadCell.h"
#import "BackProMoneyCell.h"
#import "BackProStatusCell.h"

@implementation BackProTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
        
        //注册
        [self registerClass:[BackProMoneyCell class] forCellReuseIdentifier:@"BackProMoneyCell"];
        [self registerClass:[BackProStatusCell class] forCellReuseIdentifier:@"BackProStatusCell"];
        [self registerClass:[BackProductHeadCell class] forCellReuseIdentifier:@"BackProductHeadCell"];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 60;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.backPros.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BackProductModel *model = self.backPros[indexPath.section];
    if (indexPath.row == 0) {
        BackProStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackProStatusCell" forIndexPath:indexPath];
        cell.backModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else if (indexPath.row == 1){
        BackProductHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackProductHeadCell" forIndexPath:indexPath];
        cell.backProModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        BackProMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackProMoneyCell" forIndexPath:indexPath];
        cell.backProModel = model;
        cell.seeLoButton.tag = 100+indexPath.section;
        cell.receiveButton.tag = 10000+indexPath.section;
        [cell.seeLoButton addTarget:self action:@selector(seeLoAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.receiveButton addTarget:self action:@selector(receiveAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BackProductModel *model = self.backPros[indexPath.section];
    [self.backProTableViewDelegate clickToDetailWithBackProductModel:model];
}

-(void)seeLoAction:(UIButton *)sender{
    [self.backProTableViewDelegate logisticsWithBackProductModel:self.backPros[sender.tag-100]];
}

-(void)receiveAction:(UIButton *)sender{
    [self.backProTableViewDelegate receiveOrBuyAgainWithTitle:sender.titleLabel.text andBackProductModel:self.backPros[sender.tag-10000]];
}

-(void)setBackPros:(NSArray *)backPros{
    _backPros = backPros;
    [self reloadData];
}

@end
