//
//  ApplyRecordCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "codeModel.h"
#import "TCCopyableLabel.h"

@interface ApplyRecordCell : UITableViewCell<TCCopyableLabelDelegate>

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) TCCopyableLabel *bgLabel;

@property (nonatomic,strong) TCCopyableLabel *codeLabel;
@property (nonatomic,strong) UILabel *availableLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) codeModel *model;

@end
