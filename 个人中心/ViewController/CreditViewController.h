//
//  CreditViewController.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardModel.h"

typedef void(^myBlock) (id obj);
@interface CreditViewController : UIViewController

@property (nonatomic,copy) myBlock callBack;
@property (nonatomic,strong) NSString *cardNum;
@property (nonatomic,strong) CreditCardModel *model;

@property (nonatomic,strong) NSArray *addCreditInfos;
@property (nonatomic,strong) NSString *refresh;

@end
