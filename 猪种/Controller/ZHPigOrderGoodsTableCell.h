//
//  ZHPigOrderGoodsTableCell.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHPigBuyModel;
@class ZHPigGiftModel;
@interface ZHPigOrderGoodsTableCell : UITableViewCell

- (void)configureWithPigBuyModel:(ZHPigBuyModel *)pigBuyModel;
- (void)configureWithPigGiftModel:(ZHPigGiftModel *)pigGiftModel;

@end
