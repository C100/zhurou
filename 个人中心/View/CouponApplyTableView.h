//
//  CouponApplyTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationPickerView.h"

@protocol CouponApplyTableViewDelegate <NSObject>

-(void)applyActionWithName:(NSString *)name andPhoneNum:(NSString *)num andLocation:(NSString *)location andAddress:(NSString *)address;

@end

@interface CouponApplyTableView : UITableView<UITableViewDataSource,UITableViewDelegate,LocationPickerViewDelegate>

@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *placeholders;
@property (nonatomic,strong) LocationPickerView *pickView;
@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) NSString *selectedPro;
@property (nonatomic,strong) NSString *selectedCity;

@property (nonatomic,weak) id<CouponApplyTableViewDelegate> couponApplyTableViewDelegate;

@end
