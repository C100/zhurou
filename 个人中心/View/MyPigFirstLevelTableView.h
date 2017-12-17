//
//  MyPigFirstLevelTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPigListModel.h"

@protocol MyPigFirstLevelTableViewDelegate <NSObject>

-(void)buyActionWithModel:(MyPigListModel *)model;
-(void)consumeActionWithModel:(MyPigListModel *)model andTitle:(NSString *)title;
-(void)leftButtonActionWithModel:(MyPigListModel *)model andTitle:(NSString *)title;
-(void)rightButtonActionWithModel:(MyPigListModel *)model andTitle:(NSString *)title;
-(void)pigGifted;

- (void)enterOrderDetail;

@end

@interface MyPigFirstLevelTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) id<MyPigFirstLevelTableViewDelegate> myPigFirstLevelTableViewDelegate;

@property(nonatomic, strong) NSArray *myPigs;

@end
