//
//  AllOrdetVC.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "BaseViewController.h"

@interface AllOrdetVC : BaseViewController

@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic,strong) NSMutableArray *tableViewDataArray;

@property(nonatomic,copy) void(^callback)();


@end
