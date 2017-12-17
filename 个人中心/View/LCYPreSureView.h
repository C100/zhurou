//
//  LCYPreSureView.h
//  XiJuOBJ
//
//  Created by 刘岑颖 on 2017/12/16.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCYWarningView.h"
#import "LCYNormalCell.h"

@interface LCYPreSureView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LCYWarningView *warningView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) NSArray *dataArray;

@end
