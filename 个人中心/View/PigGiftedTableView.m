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

- (void)setPigListModel:(MyPigListModel *)pigListModel{
    _pigListModel = pigListModel;
    [self reloadData];
}

- (void)setGoodsDetailModel:(GoodsDetailModel *)goodsDetailModel{
    _goodsDetailModel = goodsDetailModel;
    [self reloadData];
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BackProductHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackProductHeadCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.pigListModel) {
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.pigListModel.goodsImg] placeholderImage:[UIImage imageNamed:@"wutu@2x.png"]];
        cell.productLabel.text = self.pigListModel.goodsName;
    }
    if (self.goodsDetailModel) {
        cell.attributeLabel.text = self.goodsDetailModel.detailTitle;
        cell.moneyLabel.text = self.goodsDetailModel.price;
        cell.numLabel.text = @"x1";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _SelectCallBack(nil);
}

@end
