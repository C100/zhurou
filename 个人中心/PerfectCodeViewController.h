//
//  PerfectCodeViewController.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/5.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BaseViewController.h"
#import "PersonalInfoModel.h"

typedef void(^perfectBlock) (id obj);
@interface PerfectCodeViewController : BaseViewController

@property(nonatomic, strong) PersonalInfoModel *personModel;
@property(nonatomic, strong) perfectBlock callBack;

@end
