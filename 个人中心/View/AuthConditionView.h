//
//  AuthConditionTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthConditionModel.h"

@interface AuthConditionView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UIButton *sureButton;
@property(nonatomic, strong) UITableView *myTableView;
@property(nonatomic, strong) NSArray *contents;

@property(nonatomic, strong) AuthConditionModel *authModel;
@property(nonatomic, strong) NSMutableArray *conditions;

@end
