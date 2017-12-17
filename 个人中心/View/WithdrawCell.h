//
//  WithdrawCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawModel.h"

@interface WithdrawCell : UITableViewCell

//订单金额
@property (nonatomic,strong) UILabel *orderMoneyLabel;
//订单状态
@property (nonatomic,strong) UILabel *orderStatusLabel;
//订单日期
@property (nonatomic,strong) UILabel *orderDateLabel;
//佣金
@property (nonatomic,strong) UILabel *commisionLabel;
//勾选按钮
@property (nonatomic,strong) UIButton *selectedButton;

@property (nonatomic,assign) BOOL canWithdraw;

//@property (nonatomic,strong) NSArray *infos;
@property (nonatomic,strong) WithdrawModel *model;

@end
