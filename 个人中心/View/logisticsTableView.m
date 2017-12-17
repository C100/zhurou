//
//  logisticsTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/1.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "logisticsTableView.h"
#import "logisticsInfoCell.h"
#import "dispatchStateCell.h"
#import "dispatchInfoCell.h"

@implementation logisticsTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.tableFooterView = [[UIView alloc]init];
        
        //注册
        [self registerClass:[logisticsInfoCell class] forCellReuseIdentifier:@"logisticsInfoCell"];
        [self registerClass:[dispatchStateCell class] forCellReuseIdentifier:@"dispatchStateCell"];
        [self registerClass:[dispatchInfoCell class] forCellReuseIdentifier:@"dispatchInfoCell"];
        
        self.estimatedRowHeight = 60;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    int count = 0;
    for (NSArray *infos in self.infos) {
        count+=infos.count;
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        logisticsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logisticsInfoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        dispatchStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dispatchStateCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableArray *allInfos = [NSMutableArray array];
        for (NSArray *infos in self.infos) {
            [allInfos addObjectsFromArray:infos];
        }
        cell.infos = allInfos[indexPath.row];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 6;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [Tool getColorFromHex:@"#f4f4f4"];
}

-(void)setInfos:(NSArray *)infos{
    _infos = infos;
    [self reloadData];
}

@end
