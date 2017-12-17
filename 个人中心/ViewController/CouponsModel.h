//
//  CouponsModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/22.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponsModel : NSObject

@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *detailPrice;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *time;            //显示的时间
@property(nonatomic,copy) NSString *StartTime;
@property(nonatomic,copy) NSString *EndTime;
@property(nonatomic,copy) NSString *LimitPrice;
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *voucherStatus;


@property(nonatomic,assign) BOOL isSelect;
@property(nonatomic,assign) BOOL UnCanUser;



@end
