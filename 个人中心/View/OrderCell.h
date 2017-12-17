//
//  OrderCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/27.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderCell : UITableViewCell



@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UILabel *TypeLab;

@property(nonatomic,strong) UIButton *delectBtn;
@property(nonatomic,strong) UIButton *payBtn;
@property(nonatomic,strong) UIButton *confirmBtn;
@property(nonatomic,strong) UIButton *buyAgainBtn;
@property(nonatomic,strong) UIButton *reviewBtn;
//查看物流
@property(nonatomic, strong) UIButton *logisticsButton;

@property(nonatomic,strong) OrderModel *model;





-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(OrderModel *)model IndexPath:(NSIndexPath *)indexPath;

@end
