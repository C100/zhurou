//
//  SettingCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/29.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SettingModel.h"
@interface SettingCell : UITableViewCell

@property(nonatomic,strong) UIButton *huanChun;
@property(nonatomic,strong) UIButton *yijian;
@property(nonatomic,strong) UIButton *xieyi;
@property(nonatomic,strong) UIButton *pingfeng;
@property(nonatomic,strong) UIButton *changePassWord;



@property(nonatomic,strong) SettingModel *model;





-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(SettingModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc;
@end
