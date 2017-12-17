//
//  WithdrawRecordViewController.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawModel.h"

@interface WithdrawRecordViewController : UIViewController

@property (nonatomic,strong) NSString *navigationTitle;

@property (nonatomic,strong) NSString *orderRecord;

@property (nonatomic,strong) WithdrawModel *clickModel;

@end
