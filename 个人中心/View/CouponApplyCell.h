//
//  CouponApplyCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCreditTextField.h"

@interface CouponApplyCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) AddCreditTextField *myTextField;
@property (nonatomic,strong) UILabel *chooseLabel;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic,strong) NSString *placeholder;

@end
