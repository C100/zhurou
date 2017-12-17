//
//  GoodsDetailModel.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/10/15.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "GoodsDetailModel.h"

@implementation GoodsDetailModel



- (instancetype)init
{
    self = [super init];
    if (self) {
        _goodsArr = [[NSMutableArray alloc]init];
        _canshuArr = [[NSMutableArray alloc]init];
        _commentArr = [[NSMutableArray alloc]init];
        _tuijianArr = [[NSMutableArray alloc]init];

        
    }
    return self;
}

@end
