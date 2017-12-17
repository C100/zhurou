//
//  MyInviteHeadView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInfoModel.h"

@interface MyInviteHeadView : UIView

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *instructionLabel;
@property(nonatomic, strong) UIImageView *codeImageView;
@property(nonatomic, strong) UILabel *codeLabel;

@property(nonatomic, strong) NSString *code;
@property(nonatomic, strong) PersonalInfoModel *personModel;

@end
