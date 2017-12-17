//
//  AccountManageTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/29.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInfoModel.h"

@protocol AccountManageTableViewDelegate <NSObject>

-(void)selectIndex:(NSInteger)index;

@end

@interface AccountManageTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSArray *contents;
@property(nonatomic, weak) id<AccountManageTableViewDelegate> accountManageTableViewDelegate;

@property(nonatomic, strong) PersonalInfoModel *personModel;

@end
