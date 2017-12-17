//
//  OrderModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/27.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"


@interface OrderModel : NSObject


@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *timeint;

@property(nonatomic,copy) NSString *addressId;
@property(nonatomic,copy) NSString *ID;

@property(nonatomic,copy) NSString *type;
@property(nonatomic,strong) NSMutableArray *goodsArr;
@property(nonatomic,strong) NSMutableDictionary *payDic;
@property(nonatomic, strong) NSString *companyNo;
@property(nonatomic, strong) NSString *waybillNumber;

- (NSComparisonResult)compareParkInfo:(OrderModel *)parkinfo;


@end







