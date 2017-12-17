//
//  BackProductInfoTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackProductModel.h"

@interface BackProductInfoTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, assign) BOOL isShowLogNum;
@property(nonatomic, strong) NSArray *infos;
@property(nonatomic, strong) BackProductModel *backProModel;

@end
