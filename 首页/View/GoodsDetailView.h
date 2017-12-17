//
//  ShoppingCarDetailView.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/12.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"
#import "GoodsModel.h"

@interface GoodsDetailView : UIView

@property(nonatomic,strong) NSString *shoppingCarEdit;

@property(nonatomic,strong) ShoppingCartModel *Model;

@property(nonatomic,strong) GoodsModel *selectModel;


@property(nonatomic,strong) UIButton *requestBtn;


//yes加入购物车，NO购买
@property(nonatomic,assign) BOOL isAddShoppingCare;
//@property(nonatomic,assign) BOOL isEditShoppingCare;
@property(nonatomic,copy) NSString *carId;


-(void)configUI;

-(void)showGoodsView:(GoodsDetailView *)view;

@end
