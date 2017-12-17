//
//  MyInvitionModel.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/5.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyInvitionModel.h"

@implementation MyInvitionModel

-(instancetype)initWithInfoDic:(NSDictionary *)infoDic{
    if (self = [super init]) {
        self.ctime = infoDic[@"ctime"];
        self.headUrl = infoDic[@"headUrl"];
        self.userId = infoDic[@"userId"];
        self.username = infoDic[@"userName"];

    }
    return self;
}

@end
