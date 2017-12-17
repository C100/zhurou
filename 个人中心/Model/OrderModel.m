//
//  OrderModel.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/27.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _goodsArr = [[NSMutableArray alloc]init];
    }
    return self;
}


- (NSComparisonResult)compareParkInfo:(OrderModel *)parkinfo{
    // 升序
    NSComparisonResult result = [[NSNumber numberWithInteger:[self.time integerValue]] compare:[NSNumber numberWithInteger:[parkinfo.time integerValue]]];
    if (result == NSOrderedSame) {
        // 可以按照其他属性进行排序
    }
    return result;
}

@end
