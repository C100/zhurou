//
//  WelfareTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/15.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WelfareTableViewDelegate <NSObject>

-(void)selectIndexPathRow:(NSInteger)row;

@end

@interface WelfareTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *contents;
@property (nonatomic,weak) id<WelfareTableViewDelegate> welfareTableViewDelegate;
@property (nonatomic,strong) NSString *totalMoney;
@property (nonatomic,strong) NSString *withdrawMoney;

@end
