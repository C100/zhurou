//
//  ApplyRecordTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyRecordTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *infos;

@end
