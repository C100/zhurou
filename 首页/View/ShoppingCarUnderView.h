//
//  ShoppingCarUnderView.h
//  XiJuOBJ
//
//  Created by james on 16/9/10.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarUnderView : UIView

@property(nonatomic,strong) UIButton* allSelectBtn;
@property(nonatomic,strong) UIImageView* allSelectImg;
@property(nonatomic,strong) UILabel* priceLab;
@property(nonatomic,strong) UILabel* orderLab;
@property(nonatomic,strong) UIButton* orderBtn;

@property (nonatomic,strong) UILabel *scaleLabel;

//


-(void)configview2WithPrice:(NSNumber *)price andScalePrice:(NSNumber *)sclaPrice;

/**
 * 创建购物车的带有全选按钮的下面的view
 */

-(void)configview1;

/**
 * @praparam  select  是否全选中
 * @praparam  sum     金钱数
 * @praparam  count   订单数

 */

-(void)updateView1WithSelect:(BOOL)select  money:(CGFloat)sum count:(int)count;








//*****************************************************通用控件*********************


@property(nonatomic,strong) UIButton* btn1;
@property(nonatomic,strong) UIButton* btn2;
@property(nonatomic,strong) UIButton* btn3;
@property(nonatomic,strong) UIButton* btn4;
@property(nonatomic,strong) UIButton* btn5;


@property(nonatomic,strong) UILabel* Lab1;
@property(nonatomic,strong) UILabel* Lab2;
@property(nonatomic,strong) UILabel* Lab3;
@property(nonatomic,strong) UILabel* Lab4;
@property(nonatomic,strong) UILabel* Lab5;




/**
 * 创建产品详情下面只有金额view
 */

-(void)configview2;

/*创建产品详情下面有金额和免运费view*/
-(void)configview3withpriceTitle:(NSString *)title  priceTitle:(NSString *)price btnTitle:(NSString*)BtnTitle;
;

/**
 * 创建产品详情下面只有金额view
 *
 *自定义金额title，和按钮文字
 */

-(void)configview2withpriceTitle:(NSString *)title  priceTitle:(NSString *)price btnTitle:(NSString*)BtnTitle;

/**
 * 产品详情带有客服的view
 */
-(void)configGoodsDetailView:(NSString *)price andSclaPrice:(NSString *)sclaPrice;






@end
