//
//  WithdrawView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCarUnderView.h"

@protocol WithdrawViewDelegate <NSObject>

-(void)withdrawMoneyWithSelectedModels:(NSMutableArray *)selectedOrders andTotalMoney:(CGFloat)money;

@end

@interface WithdrawView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ShoppingCarUnderView *underView;

@property (nonatomic,strong) NSArray *infos;
@property (nonatomic,assign) CGFloat seleceMoney;

@property (nonatomic,weak) id<WithdrawViewDelegate> withdrawViewDelegate;

//选择的订单的内容
@property (nonatomic,strong) NSMutableArray *selectedOrders;

@end
