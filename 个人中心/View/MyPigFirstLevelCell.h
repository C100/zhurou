//
//  MyPigFirstLevelCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPigListModel.h"

@interface MyPigFirstLevelCell : UITableViewCell

@property(nonatomic, strong) UILabel *proLabel;
@property(nonatomic, strong) UIButton *buyButton;
@property(nonatomic, strong) UIButton *consumeButton;
@property(nonatomic, strong) UIButton *leftButton;
@property(nonatomic, strong) UIButton *rightButton;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UIButton *giftedButton;

@property(nonatomic, strong) UILabel *lastLabel;
@property(nonatomic, strong) MyPigListModel *listModel;

@end
