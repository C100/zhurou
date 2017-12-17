//
//  ShoppingCartCell.h
//  XiJuOBJ
//
//  Created by james on 16/9/9.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"

@interface ShoppingCartCell : UITableViewCell

@property(nonatomic,strong) UIImageView *titleImgView;
@property(nonatomic,strong) UIImageView *selectImgView;
@property(nonatomic,strong) UIButton *selectBtn;

@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UILabel *priceLab;
@property(nonatomic,strong) UILabel *typeLab;
@property(nonatomic,strong) UILabel *numberLab;
@property(nonatomic,strong) UIButton *editButton;
@property(nonatomic,strong) UIButton *deletButton;


@property(nonatomic,strong) ShoppingCartModel *model;


@end
