//
//  ZHPigPayModel.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  猪种支付Model
 */
@interface ZHPigPayModel : NSObject

@property (nonatomic, strong) NSNumber *orderId;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *totalPrice;
@property (nonatomic, copy) NSString *payCharge;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
