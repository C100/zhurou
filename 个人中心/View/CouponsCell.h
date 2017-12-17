//
//  CouponsCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/22.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponsModel.h"

@interface CouponsCell : UITableViewCell

@property(nonatomic,copy) CouponsModel *model;

@property(nonatomic,strong) UIImageView *CouponsImageView;
@property(nonatomic,strong) UIImageView *selectImageView;

@property(nonatomic,strong) UILabel *priceLab;
@property(nonatomic,strong) UILabel *priceDetailLab;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UILabel *typeLab;
@property(nonatomic,strong) UILabel *timeLab;

@property(nonatomic,strong) UIView *expireView;
@property(nonatomic,strong) UIImageView *expireIconView;
//@property(nonatomic,strong) UIView *expireView;

@end
