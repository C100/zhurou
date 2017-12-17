//
//  GoodsDetailVC.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodsDetailVC : BaseViewController

@property(nonatomic,copy) NSString *goodsID;
@property(nonatomic,strong) GoodsDetailModel *dataModel;


@property(nonatomic,copy) void (^moreCommentcallback)();


@end
