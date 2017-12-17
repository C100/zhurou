//
//  creatAddressVC.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"
#import "AddressManagerVC.h"
@interface creatAddressVC : BaseViewController

@property(nonatomic,strong)   AddressModel *model;

@property(nonatomic,assign)   BOOL isEdit;

@property(nonatomic,copy)   void (^callback)(AddressModel*model);
;


@property(nonatomic,strong)   AddressManagerVC *addressVc;
@property(nonatomic,assign)   BOOL OrderAddressEdit;      //订单地址编辑

@end
