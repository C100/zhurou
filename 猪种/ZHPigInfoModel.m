//
//  ZHPigInfoModel.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigInfoModel.h"
#import "ZHNetworkCommon.h"

@implementation ZHPigInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
            return self;
        }
        _pigId = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"id");
        _title = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"title"));
        _subtitle = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"subtitle"));
        _presentTerm = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"presentTerm");
        _batch = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"batch");
        _pigIntroduce = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"pigIntroduce"));
        _presentCount = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"presentCount");
        _presentPrice = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"presentPrice");
        _pigImage = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"pigImg"));
        _priceDetail = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"info"));
        _bannerImages = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"orderImg");
        _priceImage = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"priceChangeImg"));
        _warehouseImage = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"cityWarehouse"));
        _contractURLString = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"contractUrl"));
        _giftId = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"goodsId");
    }
    return self;
}

@end
