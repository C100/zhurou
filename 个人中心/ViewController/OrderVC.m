//
//  OrderVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "OrderVC.h"

#import "AllOrdetVC.h"
#import "WaitPayVC.h"
#import "AlreadyPayVC.h"
#import "WaitEvaluateVC.h"
#import "FinishOrderVC.h"
#define BtnTag 1001
#define ScreenSize  ([UIScreen mainScreen].bounds.size)
@interface OrderVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)  NSArray *btnArr;
@property(nonatomic,strong) NSMutableArray *viewControllerArray;
@property (nonatomic, strong)UIPageViewController *pageController;
@property (nonatomic, assign)NSInteger currentPageIndex;
@end

@implementation OrderVC
/**
 *  只需要修改的第一处
 */
- (NSArray *)btnArr{
    if (!_btnArr) {
        _btnArr =  @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    }
    return _btnArr;
}

/**
 *  只需要修改的第二处
 */
- (NSMutableArray *)viewControllerArray{
    if (!_viewControllerArray) {
        
        _viewControllerArray = [[NSMutableArray alloc]init];
        AllOrdetVC *FController = [[AllOrdetVC alloc]init];
        [FController setCallback:^{//全部
            [self updateData];
        }];
        WaitPayVC *SController = [[WaitPayVC alloc]init];
        [SController setCallback:^{//待付款
            [self updateData];
        }];
        AlreadyPayVC *TController = [[AlreadyPayVC alloc]init];
        [TController setCallback:^{//待发货
            [self updateData];
        }];
        WaitEvaluateVC *TController2 = [[WaitEvaluateVC alloc]init];
        [TController2 setCallback:^{//待收货
            [self updateData];
        }];
        FinishOrderVC *TController3 = [[FinishOrderVC alloc]init];
        [TController3 setCallback:^{//待评价
            [self updateData];
        }];

        [_viewControllerArray addObjectsFromArray:@[FController,SController,TController,TController2,TController3]];
    }
    return _viewControllerArray;
}

-(void)viewDidLoad
{
    [self initMainController];
    [self setupPageViewController];
    
    [self updateData];
    [self updateCurrentPageIndex:self.type];
}

-(void)updateData
{
    [HttpRequestManager postOrderGetAllRequest:nil viewcontroller:self finishBlock:^(NSDictionary *data) {
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"orderAllReloadData" object:data userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
 
}

- (UIPageViewController *)pageController{
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.view.frame = CGRectMake(0, 41, ScreenSize.width, ScreenSize.height - 41);
        _pageController.delegate = self;
        _pageController.dataSource = self;
        [_pageController setViewControllers:@[[self.viewControllerArray objectAtIndex:_type]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
    }
    return _pageController;
}

//初始化导航控制器
-(void)initMainController{
    
    
    self.title = @"我的订单";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *theLine = [[UILabel alloc]init];
    for (int i = 0; i < self.btnArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize  size = [self.btnArr[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"ZHSRXT--GBK1-0" size:20]}];
        
        //        btn.titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:16];
        
        [btn setTitle:self.btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:The_TitleColor forState:UIControlStateNormal];
        [btn setTitleColor:The_MainColor forState:UIControlStateSelected];
        //        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        btn.titleLabel.font = [UIFont fontWithName:The_titleFont size:16];
        
        
        btn.frame = CGRectMake(0 + i*KHScreenW/self.btnArr.count,  0 , KHScreenW/self.btnArr.count, 40);
        
        btn.tag = BtnTag + i;
        if (i == _currentPageIndex) {
            btn.selected = YES;
            
            theLine .frame = CGRectMake(btn.frame.origin.x + ((btn.frame.size.width)/2 - (size.width)/2),40,size.width, 1);
            theLine.tag = 2000;
        }
        [btn addTarget:self action:@selector(changeControllerClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    theLine.backgroundColor = The_MainColor;
    [self.view addSubview:theLine];
    
    
}


#pragma mark naviationButtonAction



-(void)setupPageViewController{
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self syncScrollView];
}
-(void)syncScrollView{
    for (UIView *view in self.pageController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *pageScrollView = (UIScrollView *)view;
            pageScrollView.delegate = self;
            pageScrollView.scrollsToTop=NO;
        }
    }
}
-(void)changeControllerClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tempIndex = _currentPageIndex;
    __weak typeof (self) weakSelf = self;
    NSInteger nowTemp = btn.tag - BtnTag;
    if (nowTemp > tempIndex) {
        for (int i = (int)tempIndex + 1; i <= nowTemp; i ++) {
            [_pageController setViewControllers:@[[self.viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
                if (finished) {
                    [weakSelf updateCurrentPageIndex:i];
                }
            }];
        }
    }else if (nowTemp < tempIndex){
        for (int i = (int)tempIndex ; i >= nowTemp; i--) {
            [_pageController setViewControllers:@[[self.viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:^(BOOL finished) {
                if (finished) {
                    [weakSelf updateCurrentPageIndex:i];
                }
            }];
        }
    }
}

-(void)updateCurrentPageIndex:(NSInteger)newIndex
{
    _currentPageIndex = newIndex;
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:BtnTag+_currentPageIndex];
    for (int i = 0 ; i < self.btnArr.count; i ++) {
        UIButton *otherBtn = (UIButton *)[self.view viewWithTag:BtnTag + i];
        if (btn.tag == otherBtn.tag) {
            otherBtn.selected = YES;
        }else{
            otherBtn.selected = NO;
        }
    }
    
    CGSize  size = [self.btnArr[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:20]}];
    
    
    NSInteger X = _currentPageIndex;
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:X+BtnTag];
    [UIView animateWithDuration:0.2 animations:^{
        UIView *line = (UIView *)[self.view viewWithTag:2000];
        CGRect sizeRect = line.frame;
        sizeRect.origin.x = btn2.frame.origin.x;
        line .frame = CGRectMake(btn.frame.origin.x + ((btn.frame.size.width)/2 - (size.width)/2), 40,size.width, 1);
    }];

    
}
#pragma mark --------Scroll协议-------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGSize  size = [self.btnArr[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:20]}];
    
    
    NSInteger X = _currentPageIndex;
    UIButton *btn = (UIButton *)[self.view viewWithTag:X+BtnTag];
    [UIView animateWithDuration:0.2 animations:^{
        UIView *line = (UIView *)[self.view viewWithTag:2000];
        CGRect sizeRect = line.frame;
        sizeRect.origin.x = btn.frame.origin.x;
        line .frame = CGRectMake(btn.frame.origin.x + ((btn.frame.size.width)/2 - (size.width)/2), 40,size.width, 1);
        
        //        line.frame = CGRectMake(btn.frame.origin.x, 64 - 2, btn.frame.size.width, 2);
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


@end
