//
//  BackProductHeadCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/6.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "BackProductModel.h"

@interface BackProductHeadCell : UITableViewCell

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *productLabel;
@property(nonatomic, strong) UILabel *attributeLabel;
@property(nonatomic, strong) UILabel *moneyLabel;
@property(nonatomic, strong) UILabel *numLabel;

@property(nonatomic, strong) GoodsModel *goodsModel;
@property(nonatomic, strong) BackProductModel *backProModel;

@end
