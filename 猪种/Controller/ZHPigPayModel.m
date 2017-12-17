//
//  ZHPigPayModel.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigPayModel.h"
#import "ZHNetworkCommon.h"

@implementation ZHPigPayModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
            return self;
        }
        _payCharge = TO_SAFE_STR(DICT_ATTRIBUTE_FOR_KEY(dictionary, @"chargeJson"));;
        _orderId = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"orderId");;
        NSNumber *time = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"time");
        NSInteger timeInterval = [time longLongValue] * 0.001;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSDateFormatter *dateFormatter =  [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateString = [dateFormatter stringFromDate:date];
        _startTime = dateString;
        NSNumber *totalPrice = DICT_ATTRIBUTE_FOR_KEY(dictionary, @"totalPrice");
        NSString *totalPriceString = [NSString stringWithFormat:@"%@", totalPrice];
        _totalPrice = totalPriceString;
    }
    return self;
}

@end
