//
//  GoodsDetailCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/10/15.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailModel.h"

@protocol GoodsDetailCellDelegate <NSObject>

-(void)refreshTableView;

@end


@interface GoodsDetailCell : UITableViewCell

@property(nonatomic,strong) UIButton *collectBtn;
@property(nonatomic,strong) UIImageView *titleImg;
@property (nonatomic,strong) UIImageView *sizeimage;
@property(nonatomic, strong) UILabel *Lab1;
@property(nonatomic, strong) UILabel *scaleLabel;
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) UILabel *detailLab;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(GoodsDetailModel *)model index:(NSIndexPath *)index;

@property (nonatomic,strong) GoodsDetailModel *model;
@property (nonatomic,strong) NSIndexPath *indexPath;

@property(nonatomic, weak) id<GoodsDetailCellDelegate> goodsDetailCellDelegate;

@end
