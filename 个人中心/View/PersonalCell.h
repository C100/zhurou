//
//  PersonalCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/24.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInfoModel.h"

@interface PersonalCell : UITableViewCell


@property(nonatomic,strong) UIButton *nameBtn;

@property(nonatomic,strong) UILabel *phone;
@property(nonatomic,strong) UIButton *phoneBtn;

@property(nonatomic,strong) UIButton *addressBtn;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(PersonalInfoModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc;

@end
