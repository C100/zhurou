//
//  AddressModel.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"";
        self.phone = @"";
        self.address = @"";
        self.detailAddress = @"";
        
        }
    return self;
}

@end
