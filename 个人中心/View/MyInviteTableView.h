//
//  MyInviteTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInviteHeadView.h"
#import "PersonalInfoModel.h"

@protocol MyInviteTableViewDelegate <NSObject>

-(void)invitationDetailWithInfos:(NSDictionary *)infoDic;

@end

@interface MyInviteTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSDictionary *infoDic;
@property(nonatomic, strong) MyInviteHeadView *headView;
@property(nonatomic, strong) PersonalInfoModel *personModel;
@property(nonatomic, weak) id<MyInviteTableViewDelegate> myInviteTableViewDelegate;

@end
