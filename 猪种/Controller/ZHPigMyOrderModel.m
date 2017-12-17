//
//  ZHPigMyOrderModel.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigMyOrderModel.h"
#import "ZHNetworkCommon.h"
#import "ZHPigGiftModel.h"
#import "AddressModel.h"
#import "ZHPigBuyModel.h"

@implementation ZHPigMyOrderModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
            return self;
        }
        _realName = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"realName"));
        _idCard = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"idCard"));
        _orderId = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"id");
        _orderNumber = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"orderNumber"));
        NSNumber *overTime = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"overTime");
        _overTime = [overTime longValue] * 0.001;// 获取到的时间戳是毫秒单位，转为秒
        _totalPrice = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"totalPrice");
        _invoice = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"invoice"));
        NSDictionary *giftDict = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"goodsInfo");
        if (giftDict) {
            _giftModel = [[ZHPigGiftModel alloc] initWithDictionary:giftDict];
        } else {
            _giftModel = nil;
        }

        ZHPigBuyModel *buyModel = [[ZHPigBuyModel alloc] init];
        buyModel.pigBreed = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"pigTitle"));
        buyModel.pigIntroduce = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"pigSubtitle"));
        buyModel.buyCount = [DICT_ATTRIBUTE_FOR_KEY(dictionary, @"count") integerValue];
        buyModel.pigImage = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"pigImg"));
        NSNumber *price = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"price");
        buyModel.pigPrice = [price doubleValue];
        _buyModel = buyModel;

        NSDictionary *addressDict = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"address");
        if (addressDict) {
            _addressModel = [[AddressModel alloc] init];
            _addressModel.title = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"orderName");
            _addressModel.phone = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"phone");
            _addressModel.detailAddress = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"address");
        }
    }
    return self;
}

@end
