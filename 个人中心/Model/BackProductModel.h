//
//  BackProductModel.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"

@interface BackProductModel : NSObject

@property(nonatomic, strong) NSNumber *backId;
@property(nonatomic, strong) NSNumber *goodId;
@property(nonatomic, strong) NSString *ctime;
@property(nonatomic, strong) NSNumber *money;
@property(nonatomic, strong) GoodsModel *goodsModel;
@property(nonatomic, strong) NSNumber *receiptId;//退货订单
@property(nonatomic, strong) NSString *refundReason;//退货原因
@property(nonatomic, strong) NSNumber *status;
@property(nonatomic, strong) NSNumber *type;
@property(nonatomic, strong) NSString *waybillNumber;//物流号

@end
