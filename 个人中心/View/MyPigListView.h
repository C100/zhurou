//
//  MyPigListView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHeadButtonsView.h"

@interface MyPigListView : UIView<UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>

@property (nonatomic) WHeadButtonsView *buttonsView;
@property (nonatomic) UIPageViewController *pageController;
@property (nonatomic) NSMutableArray *viewControllerArray;

@property (nonatomic) NSInteger currentPageIndex;

@property(nonatomic, strong) UIImageView *backGroundImageView;

@end
