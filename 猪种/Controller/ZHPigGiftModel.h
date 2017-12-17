//
//  ZHPigGiftModel.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  猪种礼包Model
 */
@interface ZHPigGiftModel : NSObject

@property (nonatomic, strong) NSNumber *giftPrice;
@property (nonatomic, copy) NSString *giftImage;
@property (nonatomic, strong) NSNumber *giftId;
@property (nonatomic, copy) NSString *giftName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
