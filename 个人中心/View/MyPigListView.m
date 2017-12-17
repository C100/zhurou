//
//  MyPigListView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyPigListView.h"
#import "UIView+ViewController.h"
#import "FirstLevelViewController.h"

@implementation MyPigListView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self backGroundImageView];
        [self buttonsView];
        [self viewControllerArray];
        
        [self pageController];
        
        
        
        [self syncScrollView];
        
        self.currentPageIndex = 0;
        
        __weak __typeof(self)weakSelf = self;
        [self.buttonsView setHeadButtonsCallBack:^(NSInteger i) {
            CGFloat d = self.currentPageIndex - i;
            if (d < 0) {
                [weakSelf.pageController setViewControllers:@[[weakSelf.viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
                }];
            }else{
                [weakSelf.pageController setViewControllers:@[[weakSelf.viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
                }];
            }
            weakSelf.currentPageIndex = i;
        }];
        
        
    }
    return self;
}

#pragma mark method

#pragma mark - LazyLoading -----------
-(UIImageView *)backGroundImageView{
    if (_backGroundImageView==nil) {
        _backGroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Rectangle 3 Copy"]];
        [self addSubview:_backGroundImageView];
        [_backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(195);
        }];
    }
    return _backGroundImageView;
}

- (WHeadButtonsView *)buttonsView{
    if (_buttonsView == nil) {
        
        _buttonsView = [[WHeadButtonsView alloc] initWithTitlesArray:@[@"一级市场",@"二级变售市场"] with:YES];
        [self addSubview:_buttonsView];
        [_buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(64);
            make.height.mas_equalTo(48);
        }];
        _buttonsView.backgroundColor = The_MainColor;
        _buttonsView.bottomView.hidden = YES;
    }
    return _buttonsView;
}

- (UIPageViewController *)pageController{
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.delegate = self;
        _pageController.dataSource = self;
        [_pageController setViewControllers:@[[self.viewControllerArray objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        [self addSubview:_pageController.view];
        [[self.superview viewController] addChildViewController:_pageController];
        [_pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(8);
            make.right.mas_equalTo(-8);
            make.top.mas_equalTo(self.buttonsView.mas_bottom).mas_equalTo(18);
        }];
    }
    return _pageController;
}

- (NSMutableArray *)viewControllerArray{
    if (!_viewControllerArray) {
        _viewControllerArray = [[NSMutableArray alloc]init];
        FirstLevelViewController *vc = [[FirstLevelViewController alloc]init];
        UIViewController *vc2 = [[UIViewController alloc]init];
        [_viewControllerArray addObject:vc];
        [_viewControllerArray addObject:vc2];
    }
    return _viewControllerArray;
}

#pragma mark - Method -------------

-(NSInteger)indexOfController:(UIViewController *)viewController
{
    for (int i = 0; i<[_viewControllerArray count]; i++) {
        if (viewController == [_viewControllerArray objectAtIndex:i])
        {
            return i;
        }
    }
    return NSNotFound;
}

-(void)syncScrollView{
    for (UIView *view in self.pageController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *pageScrollView = (UIScrollView *)view;
            pageScrollView.delegate = self;
            pageScrollView.scrollsToTop = YES;
        }
    }
}

-(void)updateCurrentPageIndex:(NSInteger)index{
    
    self. currentPageIndex = index;
    for (UIButton *button in self.buttonsView.buttonsArray) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    UIButton *button = self.buttonsView.buttonsArray[index];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat width = KHScreenW/self.buttonsView.titlesArray.count;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = CGRectMake((width-20)/2+width*index, 40, 20, 3);
        self.buttonsView.lineView.frame = frame;
    }];
}

-(void)setCurrentPageIndex:(NSInteger)currentPageIndex{
    _currentPageIndex = currentPageIndex;
    for (UIButton *button in self.buttonsView.buttonsArray) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    UIButton *button = self.buttonsView.buttonsArray[self.currentPageIndex];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat width = KHScreenW/self.buttonsView.titlesArray.count;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = CGRectMake((width-20)/2+width*self.currentPageIndex, 40, 20, 3);
        self.buttonsView.lineView.frame = frame;
    }];
    
    if (self.currentPageIndex >= 2) {
        [self.pageController setViewControllers:@[[self.viewControllerArray objectAtIndex:self.currentPageIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }else{
        [self.pageController setViewControllers:@[[self.viewControllerArray objectAtIndex:self.currentPageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    
    self.buttonsView.lastButtonTag = self.currentPageIndex;
}

#pragma mark --------Scroll协议-------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (UIButton *button in self.buttonsView.buttonsArray) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    UIButton *button = self.buttonsView.buttonsArray[self.currentPageIndex];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat width = KHScreenW/self.buttonsView.titlesArray.count;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = CGRectMake((width-20)/2+width*self.currentPageIndex, 40, 20, 3);
        self.buttonsView.lineView.frame = frame;
    }];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    
    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }
    
    index--;
    return [_viewControllerArray objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    index++;
    
    if (index == [_viewControllerArray count]) {
        return nil;
    }
    return [_viewControllerArray objectAtIndex:index];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        _currentPageIndex = [self indexOfController:[pageViewController.viewControllers lastObject]];
        [self updateCurrentPageIndex:_currentPageIndex];
        NSLog(@"当前界面是界面=== %ld",_currentPageIndex);
    }
}


@end
