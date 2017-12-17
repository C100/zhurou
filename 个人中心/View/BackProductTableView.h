//
//  BackProductTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/6.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
#import "GoodsModel.h"

@protocol BackProductTableViewDelegate <NSObject>

-(void)chooseCompany;

@end

@interface BackProductTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) GoodsModel *goodsModel;
@property(nonatomic, assign) CGFloat backPrice;
@property(nonatomic, assign) BOOL isNeedLogNum;//是否需要物流单号
@property(nonatomic, weak) id<BackProductTableViewDelegate> backProductTableViewDelegate;

@end
