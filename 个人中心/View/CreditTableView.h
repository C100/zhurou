//
//  CreditTableView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardModel.h"

@protocol CreditTableViewDelegate <NSObject>

-(void)chooseCreditWithCardNum:(CreditCardModel *)model;
-(void)editCreditCardInfoWithModel:(CreditCardModel *)model;
-(void)deleteCreditCardWithModel:(CreditCardModel *)model andSelectedModel:(CreditCardModel *)seleModel;

@end

@interface CreditTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *infos;
@property (nonatomic,assign) NSInteger lastSelectTag;
@property (nonatomic,weak) id<CreditTableViewDelegate> creditTableViewDelegate;
@property (nonatomic,strong) CreditCardModel *selectedCardModel;

@end
