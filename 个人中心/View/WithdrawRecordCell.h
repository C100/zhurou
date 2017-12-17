//
//  WithdrawRecordCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawModel.h"

@interface WithdrawRecordCell : UITableViewCell

@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *statusLabel;

@property (nonatomic,strong) WithdrawModel *model;

@end
