//
//  AddressCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddressModel.h"

@interface AddressCell : UITableViewCell


@property(nonatomic,strong) UIImageView *selectImgView;

@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UILabel *detailAddressLab;
@property(nonatomic,strong) UILabel *phoneLab;
//@property(nonatomic,strong) UILabel *numberLab;
@property(nonatomic,strong) UIButton *editButton;
@property(nonatomic,strong) UIButton *deletButton;
@property(nonatomic,strong) UILabel *moRenAdressLab;


@property(nonatomic,strong) AddressModel *model;




@end
