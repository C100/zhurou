//
//  BackProductApplyViewController.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/6.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailModel.h"
#import "GoodsModel.h"

@interface BackProductApplyViewController : BaseViewController

@property(nonatomic, strong) OrderDetailModel *orderDetailModel;
@property(nonatomic, strong) GoodsModel *goodsModel;

@property(nonatomic, strong) NSNumber *type;
@property(nonatomic, assign) CGFloat backAllPrice;

@end
