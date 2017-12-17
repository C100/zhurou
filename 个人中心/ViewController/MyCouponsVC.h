//
//  MyCouponsVC.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/22.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "BaseViewController.h"
#import "CouponsModel.h"
@interface MyCouponsVC : BaseViewController

@property(nonatomic,assign) BOOL isShopping;
@property(nonatomic,copy) void (^couponsCallBack)(CouponsModel *);
@property(nonatomic,assign) CGFloat orderPrice;


@end
