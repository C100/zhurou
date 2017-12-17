//
//  OrderDetailModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/28.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"
@interface OrderDetailModel : NSObject

@property(nonatomic,strong) AddressModel *AddressModel;
@property(nonatomic,strong) NSMutableArray *goodsArr;

@property(nonatomic,copy) NSString *goodsPrice;
@property(nonatomic,copy) NSString *transportFare;
@property(nonatomic,copy) NSString *coupons;
@property(nonatomic,copy) NSString *couponsId;
@property(nonatomic,copy) NSString *receiptId;
@property(nonatomic,copy) NSString *timeStr;
@property(nonatomic,copy) NSString *type;


@property(nonatomic,copy) NSString *remark;
@property(nonatomic,copy) NSString *billInfo;
@property(nonatomic,copy) NSString *price;
//@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *carIds;


//优惠码
@property (nonatomic,strong) NSString *code;
//折扣优惠
@property (nonatomic,strong) NSString *discount;

//满减json
@property (nonatomic,strong) NSString *discountJson;

//退换货的状态
@property(nonatomic, strong) NSNumber *refundOrExchangeStatusNum;
@property(nonatomic, strong) NSNumber *statusNum;
//类型
@property(nonatomic, strong) NSNumber *refundOrExchangeTypeNum;




@end
