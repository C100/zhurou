//
//  CreditRecordCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditRecordCell : UITableViewCell

//@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *moneyLabel;

@property(nonatomic, strong) NSDictionary *infoDic;

@end
