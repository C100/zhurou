//
//  OtherInvitionTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherInvitionTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSDictionary *infoDic;
@property(nonatomic, strong) NSString *second;

@end
