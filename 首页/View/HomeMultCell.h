//
//  HomeMultCell.h
//  XiJuOBJ
//
//  Created by james on 16/9/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeMultCell : UITableViewCell


@property(nonatomic,strong) HomeModel* model;



@property(nonatomic,strong) UIImageView* titleImgView;
@property(nonatomic,strong) UILabel* titleLab;
@property(nonatomic,strong) UILabel* detailTitleLab;
@property(nonatomic,strong) UILabel* priceLab;


@end


