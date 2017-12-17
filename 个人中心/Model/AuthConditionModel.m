//
//  AuthConditionModel.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/15.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AuthConditionModel.h"

@implementation AuthConditionModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.directNu = dic[@"directNu"];
        //间推人数
        self.indirectNu = dic[@"indirectNu"];
        //自身购买猪种总额
        self.expenditureSelf = dic[@"expenditureSelf"];
        //下级购买猪种总额
        self.expenditureSub = dic[@"expenditureSub"];
        //自身购买猪种总额底线（单位“万”）
        self.expenditureSubLimit = dic[@"expenditureSubLimit"];
        //下级购买猪种总额底线（单位“万”）
        self.expenditureSelfLimit = dic[@"expenditureSelfLimit"];
        //直推下线人数底线（单位“人”）
        self.directNuLimit = dic[@"directNuLimit"];
        self.isRealName = dic[@"isRealName"];
    }
    return self;
}

@end
