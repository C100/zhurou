//
//  MyInvitionModel.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/5.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInvitionModel : NSObject

//邀请时间
@property(nonatomic, strong) NSString *ctime;
//邀请人头像
@property(nonatomic, strong) NSString *headUrl;
//邀请人id
@property(nonatomic, strong) NSNumber *userId;
//邀请人姓名
@property(nonatomic, strong) NSString *username;

-(instancetype)initWithInfoDic:(NSDictionary *)infoDic;

@end
