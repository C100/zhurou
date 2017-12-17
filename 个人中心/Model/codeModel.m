//
//  codeModel.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/7/4.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "codeModel.h"

@implementation codeModel

-(instancetype)initWithInfoDic:(NSDictionary *)infoDic{
    if (self = [super init]) {
        self.address = infoDic[@"address"];
        self.cellphone = infoDic[@"cellphone"];
        self.community = infoDic[@"community"];
        self.endTime = infoDic[@"endTime"];
        self.codeId = infoDic[@"id"];
        self.name = infoDic[@"name"];
        self.promotionCode = infoDic[@"promotionCode"];
        self.startTime = infoDic[@"startTime"];
        self.status = infoDic[@"status"];
        self.userId = infoDic[@"userId"];
    }
    return self;
}

@end
