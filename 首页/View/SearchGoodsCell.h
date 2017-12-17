//
//  SearchGoodsCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/19.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchGoodsModel.h"

@interface SearchGoodsCell : UICollectionViewCell

@property(nonatomic,strong) SearchGoodsModel *Model;



@property (nonatomic,strong) UIImageView* headImageView;
@property (nonatomic,strong) UILabel* nameLable;
@property (nonatomic,strong) UILabel* priceLab;
@property (nonatomic,strong) UILabel *initalPriceLab;
@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UIButton* collectionBtn;

@end
