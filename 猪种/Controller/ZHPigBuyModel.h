//
//  ZHPigBuyModel.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  认购的猪种Model
 */
@class ZHPigInfoModel;
@interface ZHPigBuyModel : NSObject

@property (nonatomic, strong) NSNumber *pigId;
@property (nonatomic, strong) NSNumber *batch;
@property (nonatomic, strong) NSNumber *term;
@property (nonatomic, copy) NSString *pigImage;
@property (nonatomic, copy) NSString *pigBreed;
@property (nonatomic, copy) NSString *pigIntroduce;
@property (nonatomic, strong) NSNumber *giftId;
@property (nonatomic, assign) double pigPrice;
@property (nonatomic, assign) NSInteger buyCount;

- (instancetype)initWithPigInfoModel:(ZHPigInfoModel *)pigInfoModel;

@end
