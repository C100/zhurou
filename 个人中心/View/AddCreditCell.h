//
//  AddCreditCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCreditTextField.h"

@interface AddCreditCell : UITableViewCell

//信息
@property (nonatomic,strong) UILabel *infoLabel;
//输入框
@property (nonatomic,strong) AddCreditTextField *infoTextField;

@property (nonatomic,strong) NSArray *infos;
@property (nonatomic,strong) UILabel *placeholderLabel;

@property (nonatomic,strong) UIButton *selectButton;

@end
