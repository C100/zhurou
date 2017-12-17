//
//  ChooseCompanyViewController.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/15.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^chooseBlock) (NSString *company,NSString *num);
@interface ChooseCompanyViewController : BaseViewController

@property(nonatomic, strong) chooseBlock callBack;

@end
