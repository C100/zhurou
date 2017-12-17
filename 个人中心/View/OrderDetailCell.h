//
//  OrderDetailCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/28.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@interface OrderDetailCell : UITableViewCell



//@property(nonatomic,strong) UITextField *remarkTextFild;

@property(nonatomic,strong) UIButton *couponsBtn;
@property(nonatomic,strong) UIButton *billInfoBtn;
@property(nonatomic,strong) UIButton *remarkBtn;
@property (nonatomic,strong) UIButton *codeButton;
@property(nonatomic, strong) UILabel *singleProductMoneyLabel;
@property(nonatomic, strong) UIButton *detailBackButton;
@property(nonatomic, strong) UIButton *backInfoButton;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(OrderDetailModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc;



@end
