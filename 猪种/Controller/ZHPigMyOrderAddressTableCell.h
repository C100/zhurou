//
//  ZHPigMyOrderAddressTableCell.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHPigMyOrderModel;
@interface ZHPigMyOrderAddressTableCell : UITableViewCell

+ (CGFloat)heightWithMyOrderModel:(ZHPigMyOrderModel *)myOrderModel;

- (void)configureWithMyOrderModel:(ZHPigMyOrderModel *)myOrderModel;

@end
