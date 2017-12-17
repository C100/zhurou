//
//  AddCreditViewController.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardModel.h"

typedef void(^myBlock) (id obj);
@interface AddCreditViewController : UIViewController

@property (nonatomic,strong) NSString *navigationTitle;
//点击的银行卡号
@property (nonatomic,strong) CreditCardModel *clickCreditModel;

@property (nonatomic,copy) myBlock myCallBack;

@end

