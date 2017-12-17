//
//  AddressManagerVC.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/24.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"

@interface AddressManagerVC : BaseViewController

@property(nonatomic,assign) BOOL isOrder;
@property(nonatomic,copy) NSString *orderAdressId;
@property(nonatomic, strong) NSString *source;

@property(nonatomic,copy) void(^callback)(AddressModel *);

@property (nonatomic,strong) AddressModel *selectedAddressModel;


@end
