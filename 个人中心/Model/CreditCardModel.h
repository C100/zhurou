//
//  CreditCardModel.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/7/1.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditCardModel : NSObject

//银行卡id
@property (nonatomic,strong) NSNumber *creditId;
//持有人
@property (nonatomic,strong) NSString *owner;
//开户号
@property (nonatomic,strong) NSString *openNumber;
//开户银行
@property (nonatomic,strong) NSString *openBank;
//手机号
@property (nonatomic,strong) NSString *cellphone;
//是否是默认
@property (nonatomic,strong) NSNumber *isDefault;

-(instancetype)initWithInfoDic:(NSDictionary *)infoDic;

@end
