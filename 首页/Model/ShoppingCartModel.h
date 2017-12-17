//
//  ShoppingCartModel.h
//  XiJuOBJ
//
//  Created by james on 16/9/9.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingGoodsModel.h"
@interface ShoppingCartModel : NSObject

@property(nonatomic,copy) NSString *titleImgUrl;
@property(nonatomic,copy) NSString *titleText;
@property(nonatomic, strong) NSString *originalPrice;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *number;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *colorName;

@property(nonatomic,copy) NSString *goodsId;
@property(nonatomic,copy) NSString *carId;

@property(nonatomic,strong) NSMutableArray *colorArr;
@property(nonatomic,strong) NSMutableArray *typeArr;
@property (nonatomic,strong) NSMutableArray *colorNameArr;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property(nonatomic,strong) ShoppingGoodsModel *selectModel;

@property (nonatomic,strong) NSString *smallUrl;


@property(nonatomic,assign) BOOL isSelect;

@end




