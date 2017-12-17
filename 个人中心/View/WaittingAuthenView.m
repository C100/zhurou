//
//  WaittingAuthenView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "WaittingAuthenView.h"

@implementation WaittingAuthenView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *titleLabel = [Tool labelWithTitle:@"申请成功，待后台管理员审核！" color:k333333Color fontSize:14 alignment:1];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    return self;
}

@end
