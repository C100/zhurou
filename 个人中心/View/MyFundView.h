//
//  MyFundView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/27.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHeadButtonsView.h"
#import "PersonalInfoModel.h"

@interface MyFundView : UIView<UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>

@property(nonatomic, strong) UIButton *withdrawButton;
@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *moneyLabel;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) WHeadButtonsView *headButtonView;
@property (nonatomic) UIPageViewController *pageController;
@property (nonatomic) NSMutableArray *viewControllerArray;
@property(nonatomic, strong) PersonalInfoModel *personalModel;

@property (nonatomic) NSInteger currentPageIndex;

@end
