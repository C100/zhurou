//
//  BackProMoneyCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackProductModel.h"

@interface BackProMoneyCell : UITableViewCell

@property(nonatomic, strong) UILabel *moneyLabel;
@property(nonatomic, strong) UIButton *seeLoButton;
@property(nonatomic, strong) UIButton *receiveButton;

@property(nonatomic, strong) BackProductModel *backProModel;

@end
