//
//  ZHPigInfoModel.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  猪种信息Model
 */
@interface ZHPigInfoModel : NSObject

@property (nonatomic, strong) NSNumber *pigId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong) NSNumber *presentTerm;// 当前期数
@property (nonatomic, copy) NSString *pigIntroduce;
@property (nonatomic, strong) NSNumber *presentCount;// 剩余数量
@property (nonatomic, strong) NSNumber *presentPrice;
@property (nonatomic, strong) NSNumber *batch;// 批次
@property (nonatomic, copy) NSString *pigImage;
@property (nonatomic, copy) NSString *priceDetail;
@property (nonatomic, copy) NSArray *bannerImages;
@property (nonatomic, copy) NSString *priceImage;// 市场价变动图
@property (nonatomic, copy) NSString *warehouseImage;// 市仓图
@property (nonatomic, copy) NSString *contractURLString;// 合同地址
@property (nonatomic, strong) NSNumber *giftId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
