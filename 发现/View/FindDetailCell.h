//
//  FindDetailCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/10/18.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindDetailModel.h"


@interface FindDetailCell : UITableViewCell



@property (nonatomic,strong) UILabel* priceLab;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *salePriceLab;
@property (nonatomic,strong) UIView *lineView;

@property(nonatomic,copy) void  (^CollectCallback)(NSInteger );
@property(nonatomic,copy) void  (^shoppingCarCallback)(NSInteger );


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(FindDetailModel *)model index:(NSIndexPath *)index uiviewcontroller:(UIViewController *)vc;


@end
