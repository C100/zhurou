//
//  BackProStatusCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackProductModel.h"

@interface BackProStatusCell : UITableViewCell

@property(nonatomic, strong) UILabel *stateLabel;
@property(nonatomic, strong) UILabel *timeLabel;

@property(nonatomic, strong) BackProductModel *backModel;

@end
