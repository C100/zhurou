//
//  OrderDetail2VC.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/17.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailModel.h"
#import "AllOrdetVC.h"
#import "BackProductModel.h"

@interface OrderDetail2VC : BaseViewController

@property(nonatomic,strong) OrderDetailModel *model;

@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,assign) BOOL ispay;    //支付完成跳转的
@property(nonatomic,strong)  AllOrdetVC* allordervc;


@property(nonatomic, strong) NSString *isBackPro;

@property(nonatomic, strong) BackProductModel *backProModel;

@end
