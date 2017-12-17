//
//  ZHPigOrderAddressTableCell.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHPigOrderAddressTableCell : UITableViewCell

+ (CGFloat)heightWithAddressModel:(AddressModel *)addressModel;

- (void)configureWithAddressModel:(AddressModel *)addressModel;

@end
