//
//  ZHPigGiftModel.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigGiftModel.h"
#import "ZHNetworkCommon.h"

@implementation ZHPigGiftModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
            return self;
        }
        _giftPrice = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"goodsSalePrice");
        _giftImage = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"img"));
        _giftName = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"goodsName"));
        _giftId = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"goodsId");
    }
    return self;
}

@end
