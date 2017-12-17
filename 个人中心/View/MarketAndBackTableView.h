//
//  MarketAndBackTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketAndBackTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSString *type;
@property(nonatomic, assign) CGFloat totalMoney;
@property(nonatomic, strong) NSArray *infos;

@end
