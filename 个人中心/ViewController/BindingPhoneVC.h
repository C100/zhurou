//
//  BindingPhoneVC.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/12/2.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^bindPhoneBlock) (id obj);
@interface BindingPhoneVC : BaseViewController

@property(nonatomic, strong) bindPhoneBlock callBack;

@end
