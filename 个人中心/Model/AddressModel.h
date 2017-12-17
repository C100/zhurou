//
//  AddressModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *detailAddress;
@property(nonatomic,assign) BOOL  isSelect;
@property(nonatomic,copy) NSString *ID;


@end
