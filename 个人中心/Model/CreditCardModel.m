//
//  CreditCardModel.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/7/1.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "CreditCardModel.h"

@implementation CreditCardModel

-(instancetype)initWithInfoDic:(NSDictionary *)infoDic{
    if (self = [super init]) {
        self.cellphone = infoDic[@"cellphone"];
        self.creditId = infoDic[@"id"];
        self.isDefault = infoDic[@"isDefault"];
        self.openBank = infoDic[@"openBank"];
        self.openNumber = infoDic[@"openNumber"];
        self.owner = infoDic[@"owner"];
    }
    return self;
}

@end
