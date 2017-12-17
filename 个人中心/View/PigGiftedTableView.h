//
//  PigGiftedTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPigListModel.h"

@interface PigGiftedTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) void(^SelectCallBack)(id obj);

@property (nonatomic, strong) MyPigListModel *pigListModel;

@property (nonatomic, strong) GoodsDetailModel *goodsDetailModel;

@end
