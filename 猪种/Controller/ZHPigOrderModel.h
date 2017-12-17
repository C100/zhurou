//
//  ZHPigOrderModel.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  订单填写页面订单Model
 */
@class ZHPigGiftModel;
@interface ZHPigOrderModel : NSObject

@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *idCard;
@property (nonatomic, strong) ZHPigGiftModel *giftModel;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
