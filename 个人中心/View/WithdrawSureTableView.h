//
//  WithdrawTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WithdrawSureTableViewDelegate <NSObject>

-(void)chooseCredit;
-(void)withdrawActionWithCreditNum:(NSString *)creditNum;

@end

@interface WithdrawSureTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) CGFloat withdrawMoney;
@property (nonatomic,weak) id<WithdrawSureTableViewDelegate> withdrawSureTableViewDelegate;

@property(nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic,strong) NSString *defaultCreditNum;

@end
