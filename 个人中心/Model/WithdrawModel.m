//
//  WithdrawModel.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/7/4.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WithdrawModel.h"

@implementation WithdrawModel

-(instancetype)initWithInfoDic:(NSDictionary *)infoDic{
    if (self = [super init]) {
        self.totalMoney = infoDic[@"totalMoney"];
        self.createTime = infoDic[@"createTime"];
        self.status = infoDic[@"status"];
        self.withdrawId = infoDic[@"id"];
        self.withdrawMoney = infoDic[@"withdrawMoney"];
        self.withdrawTime = infoDic[@"withdrawTime"];
        self.withdrawStatus = infoDic[@"withdrawStatus"];
        self.realMoney = infoDic[@"realMoney"];
    }
    return self;
}

@end
