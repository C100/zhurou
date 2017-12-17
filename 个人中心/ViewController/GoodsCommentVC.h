//
//  GoodsCommentVC.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/22.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@interface GoodsCommentVC : BaseViewController


@property(nonatomic,strong) OrderModel *orderModel;

@property(nonatomic,strong) NSMutableArray *pinglunListArr;


@property(nonatomic,copy) void (^callback)();
@end
