//
//  WithdrawModel.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/7/4.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawModel : NSObject

@property (nonatomic,strong) NSNumber *totalMoney;
@property (nonatomic,strong) NSNumber *status;
@property (nonatomic,strong) NSNumber *createTime;
@property (nonatomic,strong) NSNumber *withdrawId;
@property (nonatomic,strong) NSNumber *withdrawMoney;

//实际到手
@property(nonatomic, strong) NSNumber *realMoney;

//订单记录中  取现时间
@property (nonatomic,strong) NSNumber *withdrawTime;
//提现状态
@property (nonatomic,strong) NSNumber *withdrawStatus;

/*银行卡信息*/
@property (nonatomic,strong) NSString *owner;
@property (nonatomic,strong) NSString *openNumber;
@property (nonatomic,strong) NSString *openBank;
@property (nonatomic,strong) NSString *cellphone;


-(instancetype)initWithInfoDic:(NSDictionary *)infoDic;

@end
