//
//  dispatchStateCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/1.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dispatchStateCell : UITableViewCell

@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *stateLabel;
@property(nonatomic, strong) UILabel *instructionLabel;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *corLabel;
@property(nonatomic, strong) UIView *lineView;

@property(nonatomic, strong) NSArray *infos;

@end
