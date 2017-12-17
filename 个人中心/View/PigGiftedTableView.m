//
//  PigGiftedTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "PigGiftedTableView.h"
#import "BackProductHeadCell.h"

@implementation PigGiftedTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        //注册
        self.tableFooterView = [[UIView alloc]init];
        [self registerClass:[BackProductHeadCell class] forCellReuseIdentifier:@"BackProductHeadCell"];
        
        self.estimatedRowHeight = 60;
    }
    return self;
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BackProductHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackProductHeadCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

@end
