//
//  ZHPigOrderModel.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigOrderModel.h"
#import "ZHNetworkCommon.h"
#import "ZHPigGiftModel.h"

@implementation ZHPigOrderModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
            return self;
        }
        _realName = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"realName"));
        _idCard = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"idCard"));
        NSDictionary *giftDict = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"goodsInfo");
        if (giftDict) {
            _giftModel = [[ZHPigGiftModel alloc] initWithDictionary:giftDict];
        } else {
            _giftModel = nil;
        }
    }
    return self;
}

@end
