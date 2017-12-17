//
//  ShoppingCartModel.m
//  XiJuOBJ
//
//  Created by james on 16/9/9.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _colorArr = [[NSMutableArray alloc]init];
        _typeArr = [[NSMutableArray alloc]init];
        _modelArr = [[NSMutableArray alloc]init];
        _selectModel = [[ShoppingGoodsModel alloc]init];
    }
    return self;
}

@end
