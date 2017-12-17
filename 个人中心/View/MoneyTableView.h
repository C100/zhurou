//
//  MoneyTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSArray *infos;
@property(nonatomic, assign) CGFloat totalMoney;
@property(nonatomic, strong) NSString *type;

@end
