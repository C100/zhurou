//
//  MyCreditLimitTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCreditLimitTableViewDelegate <NSObject>

-(void)deposit;

@end

@interface MyCreditLimitTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSArray *records;
@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, weak) id<MyCreditLimitTableViewDelegate> myCreditLimitTableViewDelegate;
@property(nonatomic, strong) NSDictionary *creditInfoDic;

@end
