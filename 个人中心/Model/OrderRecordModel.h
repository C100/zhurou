//
//  OrderRecordModel.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/7/6.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderRecordModel : NSObject

//优惠码
@property (nonatomic,strong) NSString *promotionCode;
//订单编号
@property (nonatomic,strong) NSString *receiptId;//1000id
//订单时间
@property (nonatomic,strong) NSString *createTime;
//订单地址
@property (nonatomic,strong) NSString *address;
//订单状态
@property (nonatomic,strong) NSString *showStatus;
//订单金额
@property (nonatomic,strong) NSString *price;
//客户姓名
@property (nonatomic,strong) NSString *name;
//客户号码
@property (nonatomic,strong) NSString *mobile;
//预计返利
@property (nonatomic,strong) NSString *totalMoney;
//返利状态
@property (nonatomic,strong) NSString *withdrawStatus;

@end
