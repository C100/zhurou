//
//  SpecCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/8.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecModel.h"

@interface SpecCell : UICollectionViewCell


@property (nonatomic,strong) SpecModel *model;

@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UILabel *detailTitleLab;



@end
