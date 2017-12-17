//
//  HomeCell.h
//  XiJuOBJ
//
//  Created by james on 16/9/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"


@interface HomeSingleCell : UITableViewCell



@property(nonatomic,strong) UIImageView* titleImgView;
@property(nonatomic,strong) UILabel* titleLab;
@property(nonatomic,strong) UILabel* priceLab;
@property(nonatomic,strong) UILabel* detailTitleLab;

@property(nonatomic,strong) UIButton* moreButton;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(HomeModel *)model index:(NSIndexPath *)index uiviewcontroller:(UIViewController *)vc;

@end
