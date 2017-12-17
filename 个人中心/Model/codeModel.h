//
//  codeModel.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/7/4.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface codeModel : NSObject

//地址
@property (nonatomic,strong) NSString *address;
//电话
@property (nonatomic,strong) NSString *cellphone;
//小区
@property (nonatomic,strong) NSString *community;
//优惠码创建时间
@property (nonatomic,strong) NSNumber *ctime;
//优惠码失效时间
@property (nonatomic,strong) NSNumber *endTime;
//优惠码id
@property (nonatomic,strong) NSNumber *codeId;
//名字
@property (nonatomic,strong) NSString *name;
//优惠码
@property (nonatomic,strong) NSString *promotionCode;
//优惠码生效时间
@property (nonatomic,strong) NSNumber *startTime;
//优惠码状态，1是未使用，2是已使用，3是过期
@property (nonatomic,strong) NSNumber *status;
//用户id
@property (nonatomic,strong) NSNumber *userId;

-(instancetype)initWithInfoDic:(NSDictionary *)infoDic;


@end
