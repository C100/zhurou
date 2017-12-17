//
//  OrderDetailCell2.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/18.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
#import "CommonCellView.h"

@protocol OrderDetailCell2Delegate <NSObject>

-(void)applyForWithTag:(NSInteger)tag andTitle:(NSString *)title;

@end

@interface OrderDetailCell2 : UITableViewCell

@property(nonatomic,strong) UIButton *couponsBtn;
@property(nonatomic,strong) UIButton *billInfoBtn;
@property(nonatomic,strong) UIButton *remarkBtn;
@property(nonatomic, strong)UILabel *singleProductMoneyLabel;
@property(nonatomic, strong) UIButton *detailBackButton;
@property(nonatomic, strong) UIButton *backInfoButton;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(OrderDetailModel *)model IndexPath:(NSIndexPath *)indexPath;

@property(nonatomic, weak) id<OrderDetailCell2Delegate> orderDetailCell2Delegate;
@property(nonatomic, strong) CommonCellView *commonCellView;


@end
