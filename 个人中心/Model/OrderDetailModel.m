//
//  OrderDetailModel.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/28.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _goodsArr = [[NSMutableArray alloc]init];
        
        _billInfo = @"";
        _remark = @"";
        _couponsId = @"";
        _timeStr = @"";
        _carIds = @"";
    }
    return self;
}

@end
