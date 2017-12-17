//
//  MyPigListModel.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPigListModel : NSObject

@property(nonatomic, strong) NSNumber *orderId;
//购买数量
@property(nonatomic, strong) NSNumber *count;
//认购月份
@property(nonatomic, strong) NSNumber *term;
//总月份
@property(nonatomic, strong) NSNumber *saleLimit;
//当前月份
@property(nonatomic, strong) NSNumber *presentTerm;
//认购价格
@property(nonatomic, strong) NSNumber *price;
//当前价格
@property(nonatomic, strong) NSNumber *presentPrice;
//认购总价格
@property(nonatomic, strong) NSNumber *totalPrice;
//当前总价格
@property(nonatomic, strong) NSNumber *presentTotalPrice;
@property(nonatomic, strong) NSNumber *time;//下单时间
@property(nonatomic, strong) NSNumber *payTime;//支付时间
@property(nonatomic, strong) NSNumber *endTime;//猪种结束时间
@property(nonatomic, strong) NSString *buyContractUrl;
@property(nonatomic, strong) NSNumber *state;
@property(nonatomic, strong) NSString *goodsName;

//购买凭证
@property(nonatomic, strong) NSString *contractUrl;

//添加的字段
@property (nonatomic, strong) NSString *bugUrl;
@property (nonatomic, strong) NSString *normalContractUrl;
@property (nonatomic, strong) NSString *endPrice;

@property (nonatomic, strong) NSNumber *proportion;//到期交割比例

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
