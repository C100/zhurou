//
//  ZHPigBuyModel.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigBuyModel.h"
#import "ZHPigInfoModel.h"

@implementation ZHPigBuyModel

- (instancetype)initWithPigInfoModel:(ZHPigInfoModel *)pigInfoModel {
    if (self = [super init]) {
        if (!pigInfoModel) {
            return self;
        }
        _pigId = pigInfoModel.pigId;
        _batch = pigInfoModel.batch;
        _term = pigInfoModel.presentTerm;
        _pigBreed = pigInfoModel.title;
        _pigIntroduce = pigInfoModel.subtitle;
        _pigImage = pigInfoModel.pigImage;
        _pigPrice = [pigInfoModel.presentPrice doubleValue];
        _buyCount = 1;
        _giftId = pigInfoModel.giftId;
    }
    return self;
}

@end
