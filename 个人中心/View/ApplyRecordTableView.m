//
//  ApplyRecordTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ApplyRecordTableView.h"
#import "ApplyRecordCell.h"

@implementation ApplyRecordTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kF5F5F5Color;
        self.tableFooterView = [[UIView alloc]init];
        
        //注册
        [self registerClass:[ApplyRecordCell class] forCellReuseIdentifier:@"ApplyRecordCell"];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.infos.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRecordCell" forIndexPath:indexPath];
    cell.model = self.infos[indexPath.section];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

-(void)setInfos:(NSArray *)infos{
    _infos = infos;
    [self reloadData];
}

@end
