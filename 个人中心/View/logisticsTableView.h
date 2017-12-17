//
//  logisticsTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/1.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface logisticsTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) NSArray *infos;

@end
