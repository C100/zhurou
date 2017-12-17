//
//  CreditCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardModel.h"

@interface CreditCell : UITableViewCell

@property (nonatomic,strong) UIButton *selectButton;
//开户行
@property (nonatomic,strong) UILabel *bankLabel;
//卡号
@property (nonatomic,strong) UILabel *cardNumLabel;

@property (nonatomic,strong) CreditCardModel *model;

//选中的银行卡
@property (nonatomic,strong) NSString *selectedCardNum;

@end
