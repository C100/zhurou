//
//  AddCreditTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardModel.h"

@protocol AddCreditTableViewDelegate <NSObject>

-(void)addCreditActionWithName:(NSString *)name andCreditNum:(NSString *)creditNum andBank:(NSString *)bank andPhoneNum:(NSString *)phoneNum andIsDefault:(NSNumber *)isDefalut andModel:(CreditCardModel *)model;

@end

@interface AddCreditTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *placeholders;
@property (nonatomic,weak) id<AddCreditTableViewDelegate> addCreditTableViewDelegate;

@property (nonatomic,strong) CreditCardModel *clickCreditModel;

//是否选择为默认银行卡
@property (nonatomic,strong) NSString *isDefault;

//银行卡的详细信息
@property (nonatomic,strong) NSArray *infos;

@end
