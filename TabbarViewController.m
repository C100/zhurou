//
//  TabbarViewController.m
//  XiJuOBJ
//
//  Created by james on 16/9/6.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "TabbarViewController.h"
#import "HomeViewController.h"
#import "ChooseViewController.h"
#import "FindViewController.h"
//#import "CreateViewController.h"
#import "ShoppingCartVC.h"
#import "SearchGoodsVC.h"
#import "ShoppingCarBtn.h"
#import "PersonalCenterVC.h"
#import "SettingVC.h"
#import "NoticeCenterVC2.h"
#import "PigViewController.h"

#define BtnTag 1001
#define ScreenSize  ([UIScreen mainScreen].bounds.size)
@interface TabbarViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,UITabBarDelegate>

@property (nonatomic, strong)  NSArray *btnArr;
@property(nonatomic,strong) NSMutableArray *viewControllerArray;
@property (nonatomic, strong)UIPageViewController *pageController;
@property(nonatomic, strong) NSNumber *isAppInReviewNum;

@end

@implementation TabbarViewController
/**
 *  只需要修改的第一处
 */
- (NSArray *)btnArr{
    if (!_btnArr) {
        if (self.isAppInReviewNum.intValue==1) {//审核
//            _btnArr =  @[@"创意",@"商城",@"购物车",@"我的"];
            _btnArr =  @[@"商城",@"购物车",@"我的"];

        }else{
            _btnArr =  @[@"猪种",@"商城",@"购物车",@"我的"];

//            _btnArr =  @[@"猪种",@"创意",@"商城",@"购物车",@"我的"];
        }
        
    }
    return _btnArr;
}

/**
 *  只需要修改的第二处
 */
- (NSMutableArray *)viewControllerArray{
    if (!_viewControllerArray) {
        
        _viewControllerArray = [[NSMutableArray alloc]init];
        PigViewController *pigvc = [[UIStoryboard storyboardWithName:@"ZHPig" bundle:nil] instantiateInitialViewController];
//        CreateViewController *TController2 = [[CreateViewController alloc]init];
        HomeViewController *FController = [[HomeViewController alloc]init];
        ShoppingCartVC *shoppingVC = [[ShoppingCartVC alloc]init];
        PersonalCenterVC *personalVC = [[PersonalCenterVC alloc]init];
        if (self.isAppInReviewNum.intValue==1) {
            [_viewControllerArray addObjectsFromArray:@[FController,shoppingVC,personalVC]];

//            [_viewControllerArray addObjectsFromArray:@[TController2,FController,shoppingVC,personalVC]];
        }else{
            [_viewControllerArray addObjectsFromArray:@[pigvc,FController,shoppingVC,personalVC]];

//            [_viewControllerArray addObjectsFromArray:@[pigvc,TController2,FController,shoppingVC,personalVC]];
        }
        
    }
    return _viewControllerArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.isAppInReviewNum = [[NSUserDefaults standardUserDefaults]objectForKey:@"isAppInReviewNum"];
    //    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, KHScreenH-44, KHScreenW, 1)];
    //    [self.view addSubview:lineView];
    //    lineView.backgroundColor = [UIColor redColor];
    
    [self initMainController];
    //    [self setupPageViewController];
    
    [self setTabBarView];
    
    self.tabBarController.tabBar.delegate = self;
}

- (UIPageViewController *)pageController{
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.view.frame = CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 49);
        _pageController.delegate = self;
        _pageController.dataSource = self;
        [_pageController setViewControllers:@[[self.viewControllerArray objectAtIndex:_currentPageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
    }
    return _pageController;
}

//初始化导航控制器
-(void)initMainController{
    
    //    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    //    effectview.frame = CGRectMake(0, 0,KHScreenH -  64 - 40 , 60);
    //    [self.view addSubview:effectview];
    if (self.isAppInReviewNum.intValue==1) {
        
        
        self.navigationItem.title = @"商城";
        [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
        self.navigationController.navigationBar.translucent = NO;
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        
//        self.navigationItem.title = @"创意";
//        [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
//        self.automaticallyAdjustsScrollViewInsets = YES;
//        self.navigationController.navigationBar.translucent = NO;
//        self.navigationItem.leftBarButtonItem = nil;
//        self.navigationItem.rightBarButtonItem = nil;

    }else{
        self.navigationItem.title = @"猪种";
        [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
        self.navigationController.navigationBar.translucent = NO;
        self.navigationItem.leftBarButtonItem = nil;
        UIBarButtonItem *rightbarbuttion = [UIBarButtonItem itemWithImageName:@"lianxikefu" highImageName:@"lianxikefu" target:self action:@selector(contactCustomerService)];
        self.navigationItem.rightBarButtonItem = rightbarbuttion;
    }

    self.view.backgroundColor = [UIColor whiteColor];
    
    //    导航栏设置
    //    UIImageView *titleImg = [[UIImageView alloc]init];
    //    titleImg.frame = CGRectMake(0, 10, 138/3, 20);
    //    titleImg.image =[UIImage imageNamed:@"LOGO-red"];
    //    titleImg.contentMode = UIViewContentModeScaleAspectFit;
    //    self.navigationItem.titleView = titleImg;
    
    //    UIBarButtonItem *leftbarbuttion = [UIBarButtonItem itemWithImageName:@"搜索" highImageName:@"搜索" target:self action:@selector(chooseAction)];
    //    self.navigationItem.leftBarButtonItem = leftbarbuttion;
    
    //    UIBarButtonItem *rightbarbuttion1 = [UIBarButtonItem itemWithImageName:@"gerenzhongxin@2x.png" highImageName:@"gerenzhongxin@2x.png" target:self action:@selector(personalAction)];
    
    
    
    //    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    negativeSpacer.width = 20;
    
    
    
    //    UIBarButtonItem *rightbarbuttion2 = [UIBarButtonItem itemWithImageName:@"gouwuche@2x.png" highImageName:@"gouwuche@2x.png" target:self action:@selector(ShoppingCartAction)];
    
    //    ShoppingCarBtn *shoppingCarBtn = [[ShoppingCarBtn alloc]init];
    //    shoppingCarBtn.frame = CGRectMake(0, 0, 20, 20);
    //    [shoppingCarBtn addTarget:self action:@selector(ShoppingCartAction) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *rightbarbuttion2 = [[UIBarButtonItem alloc] initWithCustomView:shoppingCarBtn];
    
    
    //    self.navigationItem.rightBarButtonItems = @[negativeSpacer];
    
    
    //    UILabel *theLine = [[UILabel alloc]init];
    //    for (int i = 0; i < self.btnArr.count; i ++) {
    //        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        CGSize  size = [self.btnArr[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"ZHSRXT--GBK1-0" size:20]}];
    ////        btn.titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:16];
    //
    //        [btn setTitle:self.btnArr[i] forState:UIControlStateNormal];
    //        [btn setTitleColor:The_TitleColor forState:UIControlStateNormal];
    //        [btn setTitleColor:The_MainColor forState:UIControlStateSelected];
    ////        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    //        btn.titleLabel.font = [UIFont fontWithName:The_titleFont size:16];
    //
    //
    //        btn.frame = CGRectMake(0 + i*KHScreenW/self.btnArr.count, KHScreenH -  64 - 49, KHScreenW/self.btnArr.count, 49);
    //
    //        btn.tag = BtnTag + i;
    //        if (i == _currentPageIndex) {
    //            btn.selected = YES;
    //
    //            theLine .frame = CGRectMake(btn.frame.origin.x + ((btn.frame.size.width)/2 - (size.width- 10)/2), KHScreenH - 64 - 49,size.width-10, 2);
    //            theLine.tag = 2000;
    //        }
    //        [btn addTarget:self action:@selector(changeControllerClick:) forControlEvents:UIControlEventTouchUpInside];
    //        [self.view addSubview:btn];
    //    }
    //
    //    theLine.backgroundColor = The_MainColor;
    //    [self.view addSubview:theLine];
    //
    //    UIView *horiLineView = [[UIView alloc]initWithFrame:CGRectMake(0, KHScreenH - 64 - 49, KHScreenW, 1)];
    //    horiLineView.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
    //    [self.view addSubview:horiLineView];
    
}

- (void)contactCustomerService {
    [[Tool tools] showkefuViewController:self];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [tabBar.items indexOfObject:item];
    if (self.isAppInReviewNum.intValue==1) {
        index+=1;
    }
    switch (index) {
        case 0:
        {
            self.navigationItem.title = @"猪种";
            [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
            self.automaticallyAdjustsScrollViewInsets = YES;
            self.navigationController.navigationBar.translucent = NO;
            self.navigationItem.leftBarButtonItem = nil;
            UIBarButtonItem *rightbarbuttion = [UIBarButtonItem itemWithImageName:@"lianxikefu" highImageName:@"lianxikefu" target:self action:@selector(contactCustomerService)];
            self.navigationItem.rightBarButtonItem = rightbarbuttion;
        }
            break;
            
//        case 1:
//            self.navigationItem.title = @"创意";
//            [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
//            self.automaticallyAdjustsScrollViewInsets = YES;
//            self.navigationController.navigationBar.translucent = NO;
//            self.navigationItem.leftBarButtonItem = nil;
//            self.navigationItem.rightBarButtonItem = nil;
//            break;
            
        case 2-1:
        {
            self.navigationItem.title = @"商城";
            [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
            self.automaticallyAdjustsScrollViewInsets = YES;
            self.navigationController.navigationBar.translucent = NO;
            UIBarButtonItem *leftbarbuttion = [UIBarButtonItem itemWithImageName:@"搜索" highImageName:@"搜索" target:self action:@selector(chooseAction)];
            self.navigationItem.leftBarButtonItem = leftbarbuttion;
            self.navigationItem.rightBarButtonItem = nil;
        }
            break;
        case 3-1:
            self.navigationItem.title = @"购物车";
            [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
            self.automaticallyAdjustsScrollViewInsets = YES;
            self.navigationController.navigationBar.translucent = NO;
            self.navigationItem.leftBarButtonItem = nil;
            self.navigationItem.rightBarButtonItem = nil;
            break;
        case 4-1:
        {
            self.navigationItem.title = @"我的";
            [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
            self.automaticallyAdjustsScrollViewInsets = YES;
            self.navigationController.navigationBar.translucent = NO;
            self.navigationItem.leftBarButtonItem = nil;
            self.navigationController.navigationBar.shadowImage = [UIImage new];
            UIBarButtonItem *rightbarbuttion = [UIBarButtonItem itemWithImageName:@"铃铛@2x.png" highImageName:@"铃铛@2x.png" target:self action:@selector(infoAction)];
            self.navigationItem.rightBarButtonItem = rightbarbuttion;
        }
            break;
        default:
            break;
    }
}


#pragma mark naviationButtonAction

-(void)infoAction{
    NoticeCenterVC2 *vc = [[NoticeCenterVC2 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    SettingVC *vc = [[SettingVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}

/**
 * 查找按钮
 */

-(void)chooseAction
{
    
    SearchGoodsVC *vc = [[SearchGoodsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    //    SearchGoodsVC *nextView=[[SearchGoodsVC alloc] init];
    //    [UIView  beginAnimations:nil context:NULL];
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //    [UIView setAnimationDuration:0.75];
    //    [self.navigationController pushViewController:nextView animated:NO];
    //    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
    //    [UIView commitAnimations];
}

/**
 * 个人中心
 */
-(void)personalAction
{
    
    PersonalCenterVC *vc = [[PersonalCenterVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    //    UIImageView *imageview=[[UIImageView alloc] init];
    //    [imageview sd_setImageWithURL:<#(NSURL *)#> completed:<#^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)completedBlock#>]
    
}

/**
 * 购物车
 */
-(void)ShoppingCartAction
{
    ShoppingCartVC *vc = [[ShoppingCartVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

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
    if (self.isAppInReviewNum.intValue==1) {
        _currentPageIndex += 1;
    }
    
    if (_currentPageIndex==4-1) {
        UIBarButtonItem *rightbarbuttion2 = [UIBarButtonItem itemWithImageName:@"shezhi@2x.png" highImageName:@"shezhi@2x.png" target:self action:@selector(settingAction)];
        self.navigationItem.rightBarButtonItems = @[rightbarbuttion2];
        self.navigationItem.title = @"我的";
    }else{
        self.navigationItem.rightBarButtonItems = @[];
    }
    switch (_currentPageIndex) {
        case 0:
            self.navigationItem.title = @"猪种";
            break;
//        case 1:
//            self.navigationItem.title = @"创意";
//            break;
        case 2-1:
            self.navigationItem.title = @"商城";
            break;
        case 3-1:
            self.navigationItem.title = @"购物车";
            break;
        default:
            break;
    }
    
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
        line .frame = CGRectMake(btn.frame.origin.x + ((btn.frame.size.width)/2 - (size.width- 10)/2), KHScreenH - 64 - 49,size.width-10, 2);
        
        //        line.frame = CGRectMake(btn.frame.origin.x, 64 - 2, btn.frame.size.width, 2);
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
        line .frame = CGRectMake(btn.frame.origin.x + ((btn.frame.size.width)/2 - (size.width- 10)/2), KHScreenH - 64 - 49,size.width-10, 2);
        
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

-(void)settingAction{
    [self.navigationController pushViewController:[SettingVC new] animated:YES];
}

-(void)setTabBarView{
    
    self.tabBar.tintColor = The_MainColor;
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    PigViewController *pvc = [[UIStoryboard storyboardWithName:@"ZHPig" bundle:nil] instantiateInitialViewController];
    HomeViewController *hvc = [[HomeViewController alloc]init];
//    CreateViewController *bvc = [[CreateViewController alloc]init];
    ShoppingCartVC *svc = [[ShoppingCartVC alloc]init];
    PersonalCenterVC *evc = [[PersonalCenterVC alloc]init];
    
    
    pvc.title = @"猪种";
    [pvc.tabBarItem setImage:[UIImage imageNamed:@"猪种未选中"]];
    [pvc.tabBarItem setSelectedImage:[UIImage imageNamed:@"猪种"]];
    hvc.title = @"商城";
    [hvc.tabBarItem setImage:[UIImage imageNamed:@"首页"]];
    [hvc.tabBarItem setSelectedImage:[UIImage imageNamed:@"首页点击效果"]];
//    bvc.title = @"创意";
//    [bvc.tabBarItem setImage:[UIImage imageNamed:@"创意未点击效果"]];
//    [bvc.tabBarItem setSelectedImage:[UIImage imageNamed:@"创意选定状态"]];
    svc.title = @"购物车";
    [svc.tabBarItem setImage:[UIImage imageNamed:@"购物车未选定状态"]];
    [svc.tabBarItem setSelectedImage:[UIImage imageNamed:@"购物车选定状态"]];
    evc.title = @"我的";
    [evc.tabBarItem setImage:[UIImage imageNamed:@"我的未点击状态"]];
    [evc.tabBarItem setSelectedImage:[UIImage imageNamed:@"我的选中状态"]];
    
    if (self.isAppInReviewNum.intValue==1) {
//        self.viewControllers = @[bvc,hvc,svc,evc];
        self.viewControllers = @[hvc,svc,evc];

    }else{
        self.viewControllers = @[pvc,hvc,svc,evc];

//        self.viewControllers = @[pvc,bvc,hvc,svc,evc];
    }
    
}

@end

