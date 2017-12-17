//
//  WithdrawRecordTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawModel.h"

@protocol WithdrawRecordTableViewDelegate <NSObject>

-(void)browseWithdrawRecordDetailWithModel:(WithdrawModel *)model;

@end

@interface WithdrawRecordTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *records;
@property (nonatomic,weak) id<WithdrawRecordTableViewDelegate> withdrawRecordTableViewDelegate;

@end
