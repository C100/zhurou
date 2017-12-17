//
//  MyPigListModel.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyPigListModel.h"

@implementation MyPigListModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.orderId = dic[@"id"];
        //购买数量
        self.count = dic[@"count"];
        //认购月份
        self.term = dic[@"term"];
        //总月份
        self.saleLimit = dic[@"saleLimit"];
        //当前月份
        self.presentTerm = dic[@"presentTerm"];
        //认购价格
        self.price = dic[@"price"];
        //当前价格
        self.presentPrice = dic[@"presentPrice"];
        //认购总价格
        self.totalPrice = dic[@"totalPrice"];
        //当前总价格
        self.presentTotalPrice = dic[@"presentTotalPrice"];
        self.state = dic[@"state"];
        self.time = dic[@"time"];
        self.contractUrl = dic[@"contractUrl"];
        self.payTime = dic[@"payTime"];
        self.endTime = dic[@"endTime"];
        self.buyContractUrl = dic[@"buyContractUrl"];
        self.goodsName = dic[@"goodsName"];
        self.bugUrl = dic[@"bugUrl"];
        self.normalContractUrl = [dic objectForKey:@"normalContractUrl"];
        self.endPrice = [dic objectForKey:@"endPrice"];
        self.proportion = [dic objectForKey:@"proportion"];
        self.goodsImg = [dic objectForKey:@"goodsImg"];
    }
    return self;
    
}

@end
