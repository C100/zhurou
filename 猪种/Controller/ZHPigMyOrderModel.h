//
//  ZHPigMyOrderModel.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  未完成订单页面订单Model
 */
@class ZHPigGiftModel;
@class AddressModel;
@class ZHPigBuyModel;
@interface ZHPigMyOrderModel : NSObject

@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *idCard;
@property (nonatomic, strong) NSNumber *orderId;
@property (nonatomic, copy) NSString *orderNumber;// 订单编号
@property (nonatomic, copy) NSString *invoice;
@property (nonatomic, strong) NSNumber *totalPrice;
@property (nonatomic, assign) long overTime;
@property (nonatomic, strong) ZHPigGiftModel *giftModel;
@property (nonatomic, strong) AddressModel *addressModel;
@property (nonatomic, strong) ZHPigBuyModel *buyModel;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
