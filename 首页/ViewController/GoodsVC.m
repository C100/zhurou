//
//  GoodsVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "GoodsVC.h"
#import "GoodsDetailVC.h"
#import "SpecVC.h"
#import "RecommendVC.h"
#import "CommentVC.h"
#import "CommentModel.h"
#import "ShoppingCartVC.h"
#import "ShoppingCarBtn.h"
#import "LoginAndRegisterVC.h"
#import "BXNavigationController.h"

#define BtnTag 1001
#define ScreenSize  ([UIScreen mainScreen].bounds.size)
@interface GoodsVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>
{
    
    GoodsDetailModel *_dataModel;
}

@property (nonatomic, strong)  NSArray *btnArr;
@property(nonatomic,strong) NSMutableArray *viewControllerArray;
@property (nonatomic, strong)UIPageViewController *pageController;
@property (nonatomic, assign)NSInteger currentPageIndex;
@property (nonatomic,strong) UIButton *commentBtn;
@end

@implementation GoodsVC
/**
 *  只需要修改的第一处
 */
//- (NSArray *)btnArr{
//    if (!_btnArr) {
//        _btnArr =  @[@"详情",@"规格",@"推荐",@"评论",];
//    }
//    return _btnArr;
//}

/**
 *  只需要修改的第二处
 */
//- (NSMutableArray *)viewControllerArray{
//    if (!_viewControllerArray) {
//
//        _dataModel = [[GoodsDetailModel alloc]init];
//
//        _viewControllerArray = [[NSMutableArray alloc]init];
//        GoodsDetailVC *FController = [[GoodsDetailVC alloc]init];
////        FController.dataModel = _dataModel;
//
//        __weak __typeof(self)weakSelf = self;
//        [FController setMoreCommentcallback:^{
//            [weakSelf changeControllerClick:weakSelf.commentBtn];
//        }];
//        FController.goodsID = self.goodIds;
//        SpecVC *SController = [[SpecVC alloc]init];
//        RecommendVC *TController = [[RecommendVC alloc]init];
//        CommentVC *TController2 = [[CommentVC alloc]init];
//        [_viewControllerArray addObjectsFromArray:@[FController,SController,TController,TController2]];
//    }
//    return _viewControllerArray;
//}

-(void)viewDidLoad
{
    [self initMainController];
    //[self setupPageViewController];
    if (!getUserId) {
        MyAlert *alert = [MyAlert manage];
        [alert showBtnAlertWithTitle:@"提醒" detailTitle:@"您还未登录是否登录？" button1Title:@"取消" button2Title:@"确定" confirm:^{
            LoginAndRegisterVC *vc1 = [[LoginAndRegisterVC alloc]init];
            vc1.isVistor = YES;
            BXNavigationController *nav1 = [[BXNavigationController alloc]initWithRootViewController:vc1];
            [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:nav1 animated:YES completion:nil];
        }];
        return;
    }
    
    NSDictionary *dic = @{@"goodsId":_goodIds,
                          @"userId":getUserId
                          };
    
    [HttpRequestManager postGoodsDeatailRequest:dic viewcontroller:self finishBlock:^(GoodsDetailModel *qusetModel) {
        _dataModel = qusetModel;
        if (self.title==nil) {
            self.title = qusetModel.title;
        }
        
     
        if (!qusetModel) {
           UIView * wuBackView = [[UIView alloc]init];
            wuBackView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:wuBackView];
            [wuBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.offset(0);
            }];
            
            UILabel *wuLab = [Tool labelWithTitle:@"该商品已下架" color:The_placeholder_Color_grary fontSize:15 alignment:1];
            [wuBackView addSubview:wuLab];
            
            [wuLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.view);
                make.size.mas_equalTo(CGSizeMake(150, 40));
            }];
            
                self.view.backgroundColor = The_list_backgroundColor;
                
                UIImageView *wuImageView = [[UIImageView alloc]init];
                wuImageView.image = [UIImage imageNamed:@"wu@2x.png"];
                [wuBackView addSubview:wuImageView];
                
                [wuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self.view);
                    make.size.mas_equalTo(CGSizeMake(150, 40));
                    make.bottom.mas_equalTo(wuLab.mas_top).offset(-20);
                }];

        }else
        {
            
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"reloadDataModel" object:_dataModel userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];

        }
    
//        _dataModel.commentArr = _tableViewDataArray;
//        [self.tableView reloadData];
        
    }];

    
    
    
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"fenxiang@2x.png"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 20;
    
    ShoppingCarBtn *shoppingCarBtn = [[ShoppingCarBtn alloc]init];
    shoppingCarBtn.frame = CGRectMake(0, 0, 20, 20);
    [shoppingCarBtn perpareData];
    [shoppingCarBtn addTarget:self action:@selector(ShoppingCartAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarbuttion2 = [[UIBarButtonItem alloc] initWithCustomView:shoppingCarBtn];
    
    
    
    self.navigationItem.rightBarButtonItems = @[rightbarbuttion2,negativeSpacer,rightBar];
    
    
    
}

#pragma mark buttonAction



/**
 * 购物车
 */
-(void)ShoppingCartAction
{
    ShoppingCartVC *vc = [[ShoppingCartVC alloc]init];
    vc.status = @"";
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark buttonAction

-(void)shareAction
{
    BXLog(@"分享");
    
    [[Tool tools] appShare:self];
    
}


//- (UIPageViewController *)pageController{
//    if (!_pageController) {
//        _pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//        _pageController.view.frame = CGRectMake(0, 41, ScreenSize.width, ScreenSize.height - 41);
//        _pageController.delegate = self;
//        _pageController.dataSource = self;
//        [_pageController setViewControllers:@[[self.viewControllerArray objectAtIndex:_currentPageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//    }
//    return _pageController;
//}

//初始化导航控制器
-(void)initMainController{
    
    
//    self.title = @"产品详情";
    self.view.backgroundColor = [UIColor whiteColor];
//    UILabel *theLine = [[UILabel alloc]init];
//    for (int i = 0; i < self.btnArr.count; i ++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        CGSize  size = [self.btnArr[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"ZHSRXT--GBK1-0" size:20]}];
//        //        btn.titleLabel.font = [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:16];
//
//        [btn setTitle:self.btnArr[i] forState:UIControlStateNormal];
//        [btn setTitleColor:The_TitleColor forState:UIControlStateNormal];
//        [btn setTitleColor:The_MainColor forState:UIControlStateSelected];
//        //        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//        btn.titleLabel.font = [UIFont fontWithName:The_titleFont size:16];
//
//
//        btn.frame = CGRectMake(0 + i*KHScreenW/self.btnArr.count,  0 , KHScreenW/self.btnArr.count, 40);
//
//        btn.tag = BtnTag + i;
//        if (i == _currentPageIndex) {
//            btn.selected = YES;
//
//            theLine .frame = CGRectMake(btn.frame.origin.x + ((btn.frame.size.width)/2 - (size.width)/2),40,size.width, 1);
//            theLine.tag = 2000;
//        }
//        if (i==3) {
//            _commentBtn = btn;
//        }
//        [btn addTarget:self action:@selector(changeControllerClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn];
//    }
//
//    theLine.backgroundColor = The_MainColor;
//    [self.view addSubview:theLine];
    GoodsDetailVC *goodDetailVc=[[GoodsDetailVC alloc] init];
    goodDetailVc.goodsID=_goodIds;
    [self addChildViewController:goodDetailVc];
    [self.view addSubview:goodDetailVc.view];
}


#pragma mark naviationButtonAction
-(void)setupPageViewController{
    //[self addChildViewController:self.pageController];
    //[self.view addSubview:self.pageController.view];
    //[self syncScrollView];
}
//-(void)syncScrollView{
//    for (UIView *view in self.pageController.view.subviews) {
//        if ([view isKindOfClass:[UIScrollView class]]) {
//            UIScrollView *pageScrollView = (UIScrollView *)view;
//            pageScrollView.delegate = self;
//            pageScrollView.scrollsToTop=NO;
//        }
//    }
//}
//-(void)changeControllerClick:(id)sender{
//    UIButton *btn = (UIButton *)sender;
//    NSInteger tempIndex = _currentPageIndex;
//    __weak typeof (self) weakSelf = self;
//    NSInteger nowTemp = btn.tag - BtnTag;
//    if (nowTemp > tempIndex) {
//        for (int i = (int)tempIndex + 1; i <= nowTemp; i ++) {
//            [weakSelf.pageController setViewControllers:@[[weakSelf.viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
//                if (finished) {
//                    [weakSelf updateCurrentPageIndex:i];
//                }
//            }];
//        }
//    }else if (nowTemp < tempIndex){
//        for (int i = (int)tempIndex ; i >= nowTemp; i--) {
//            [weakSelf.pageController setViewControllers:@[[weakSelf.viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:^(BOOL finished) {
//                if (finished) {
//                    [weakSelf updateCurrentPageIndex:i];
//                }
//            }];
//        }
//    }
//}

//-(void)updateCurrentPageIndex:(NSInteger)newIndex
//{
//    _currentPageIndex = newIndex;
//
//    UIButton *btn = (UIButton *)[self.view viewWithTag:BtnTag+_currentPageIndex];
//    for (int i = 0 ; i < self.btnArr.count; i ++) {
//        UIButton *otherBtn = (UIButton *)[self.view viewWithTag:BtnTag + i];
//        if (btn.tag == otherBtn.tag) {
//            otherBtn.selected = YES;
//        }else{
//            otherBtn.selected = NO;
//        }
//    }
//
//
//    CGSize  size = [self.btnArr[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:20]}];
//
//
//    NSInteger X = _currentPageIndex;
//    UIButton *btn2 = (UIButton *)[self.view viewWithTag:X+BtnTag];
//    [UIView animateWithDuration:0.2 animations:^{
//        UIView *line = (UIView *)[self.view viewWithTag:2000];
//        CGRect sizeRect = line.frame;
//        sizeRect.origin.x = btn2.frame.origin.x;
//        line .frame = CGRectMake(btn2.frame.origin.x + ((btn2.frame.size.width)/2 - (size.width)/2), 40,size.width, 1);
//
//    }];
//}
//#pragma mark --------Scroll协议-------
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGSize  size = [self.btnArr[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:20]}];
//
//
//    NSInteger X = _currentPageIndex;
//    UIButton *btn = (UIButton *)[self.view viewWithTag:X+BtnTag];
//    [UIView animateWithDuration:0.2 animations:^{
//        UIView *line = (UIView *)[self.view viewWithTag:2000];
//        CGRect sizeRect = line.frame;
//        sizeRect.origin.x = btn.frame.origin.x;
//        line .frame = CGRectMake(btn.frame.origin.x + ((btn.frame.size.width)/2 - (size.width)/2), 40,size.width, 1);
//
//        //        line.frame = CGRectMake(btn.frame.origin.x, 64 - 2, btn.frame.size.width, 2);
//    }];
//}

//#pragma mark - Page View Controller Data Source
//
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
//{
//    NSInteger index = [self indexOfController:viewController];
//
//    if ((index == NSNotFound) || (index == 0)) {
//        return nil;
//    }
//
//    index--;
//    return [_viewControllerArray objectAtIndex:index];
//}
//
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
//{
//    NSInteger index = [self indexOfController:viewController];
//    index++;
//
//    if (index == [_viewControllerArray count]) {
//        return nil;
//    }
//    return [_viewControllerArray objectAtIndex:index];
//}
//
//-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
//{
//    if (completed) {
//        _currentPageIndex = [self indexOfController:[pageViewController.viewControllers lastObject]];
//        [self updateCurrentPageIndex:_currentPageIndex];
//        NSLog(@"当前界面是界面=== %ld",_currentPageIndex);
//    }
//}
//
//-(NSInteger)indexOfController:(UIViewController *)viewController
//{
//    for (int i = 0; i<[_viewControllerArray count]; i++) {
//        if (viewController == [_viewControllerArray objectAtIndex:i])
//        {
//            return i;
//        }
//    }
//    return NSNotFound;
//}





@end
