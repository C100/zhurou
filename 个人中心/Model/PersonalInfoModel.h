//
//  PersonalInfoModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/24.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalInfoModel : NSObject

@property(nonatomic,copy) NSString *imgUrl;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *address;
@property(nonatomic,strong) UIImage *areaImg;
@property(nonatomic,assign) BOOL haveNotice;
@property(nonatomic, strong) NSNumber *money;
@property(nonatomic, strong) NSString *userCode;
@property(nonatomic, strong) NSNumber *state;//null/0未认证   1已认证

//新加的
//我使用的别人的邀请码
@property (nonatomic, strong) NSString *useInvitationCode;

@end
