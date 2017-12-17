//
//  WithdrawView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WithdrawView.h"
#import "WithdrawCell.h"

@implementation WithdrawView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUnderView];
        [self setupTableView];
        self.selectedOrders = [NSMutableArray array];
    }
    return self;
}

-(void)setupUnderView{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [LUtils colorHex:@"#cccccc"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(-49);
    }];
    
    self.underView = [[ShoppingCarUnderView alloc]init];
    self.underView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.underView];
    
    [self.underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    [self.underView configview2withpriceTitle:@"合计：" priceTitle:[[NSString alloc]initWithFormat:@"%0.2f",0.00] btnTitle:@"下一步"];
    [_underView.btn1 addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setupTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.underView.mas_top).mas_equalTo(-1);
    }];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //注册
    [self.tableView registerClass:[WithdrawCell class] forCellReuseIdentifier:@"WithdrawCell"];
}

#pragma mark UITableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infos.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WithdrawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WithdrawCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.infos[indexPath.row];
    cell.selectedButton.tag = 100+indexPath.row;
    [cell.selectedButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79;
}

-(void)setInfos:(NSArray *)infos{
    _infos = infos;
    [self.tableView reloadData];
}

-(void)selectAction:(UIButton *)sender{
    sender.selected = !sender.selected;
//    NSArray *infos = self.infos[sender.tag-100];
    WithdrawModel *model = self.infos[sender.tag-100];
    NSString *money = model.withdrawMoney.stringValue;
    if (sender.selected) {
        self.seleceMoney += money.floatValue/100;
        [self.selectedOrders addObject:model];
    }else{
        self.seleceMoney -= money.floatValue/100;
        [self.selectedOrders removeObject:model];
    }
    
    
    NSString *priceStr = [[NSString alloc]initWithFormat:@"合计：￥%0.2f ",self.seleceMoney];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:priceStr];
    self.underView.Lab1.font = [UIFont fontWithName:The_titleFont size:15];
    self.underView.Lab1.textColor = The_TitlePayColor;
    //设置：在0-3个单位长度内的内容显示成红色
    [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0, 3)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(3, 1)];
    //[str addAttribute:NSFontAttributeName value:[UIFont fontWithName:The_titleFont size:13] range:NSMakeRange(priceStr.length-4, 4)];
    
    
    self.underView.Lab1.attributedText =str;
    
}
-(void)confirmAction{
    if (self.seleceMoney == 0.00) {
        [LUtils toastview:@"提现金额太少，无法提现"];
        return;
    }
    
    [self.withdrawViewDelegate withdrawMoneyWithSelectedModels:self.selectedOrders andTotalMoney:self.seleceMoney];
}

@end
