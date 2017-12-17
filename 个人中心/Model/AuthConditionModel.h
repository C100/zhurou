//
//  AuthConditionModel.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/15.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthConditionModel : NSObject

//直推线下人数
@property(nonatomic, strong) NSNumber *directNu;
//间推人数
@property(nonatomic, strong) NSNumber *indirectNu;
//自身购买猪种总额
@property(nonatomic, strong) NSNumber *expenditureSelf;
//下级购买猪种总额
@property(nonatomic, strong) NSNumber *expenditureSub;
//自身购买猪种总额底线（单位“万”）
@property(nonatomic, strong) NSNumber *expenditureSubLimit;
//下级购买猪种总额底线（单位“万”）
@property(nonatomic, strong) NSNumber *expenditureSelfLimit;
//直推下线人数底线（单位“人”）
@property(nonatomic, strong) NSNumber *directNuLimit;

//是否实名认证过
@property(nonatomic, strong) NSNumber *isRealName;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
