//
//  SettingTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/29.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInfoModel.h"

@protocol SettingTableViewDelegate <NSObject>

-(void)selectedIndex:(NSIndexPath *)indexPath;
-(void)logout;

@end

@interface SettingTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSArray *contents;
@property(nonatomic, strong) PersonalInfoModel *model;
@property(nonatomic, weak) id<SettingTableViewDelegate> settingTableViewDelegate;
@property(nonatomic, strong) UIButton *logoutButton;

@end
