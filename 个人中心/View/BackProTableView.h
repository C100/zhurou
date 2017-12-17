//
//  BackProTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackProductModel.h"

@protocol BackProTableViewDelegate <NSObject>

-(void)clickToDetailWithBackProductModel:(BackProductModel *)model;
-(void)logisticsWithBackProductModel:(BackProductModel *)model;
-(void)receiveOrBuyAgainWithTitle:(NSString *)title andBackProductModel:(BackProductModel *)model;

@end

@interface BackProTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) id<BackProTableViewDelegate> backProTableViewDelegate;
@property(nonatomic, strong) NSArray *backPros;

@end
