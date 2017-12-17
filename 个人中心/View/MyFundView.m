//
//  MyFundView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/27.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyFundView.h"
#import "UIView+ViewController.h"
#import "MarketAndBackViewController.h"
#import "MoneyViewController.h"
#import "UIImageView+WebCache.h"

@implementation MyFundView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.topView = [[UIView alloc]init];
        self.topView.layer.cornerRadius = 10;
        self.topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-12);
            make.height.mas_equalTo(100);
        }];
        
        self.iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的资金头像"]];
        [self.topView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(14);
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        self.nameLabel = [Tool labelWithTitle:@"XXX" color:k272F3FColor fontSize:12 alignment:0];
        [self.topView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(8);
            make.top.mas_equalTo(18);
            make.height.mas_equalTo(12);
            make.right.mas_equalTo(-12);
        }];
        
        self.withdrawButton = [Tool buttonWithTitle:@"提现" titleColor:[UIColor whiteColor] font:16 imageName:nil target:nil action:nil];
        self.withdrawButton.layer.cornerRadius = 6;
        [self.topView addSubview:self.withdrawButton];
        self.withdrawButton.backgroundColor = The_MainColor;
        [self.withdrawButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-30);
            make.size.mas_equalTo(CGSizeMake(80, 36));
            make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(2);
        }];
        
        UILabel *symbolLabel = [Tool labelWithTitle:@"¥" color:k272F3FColor fontSize:16 alignment:0];
        symbolLabel.font = [UIFont systemFontOfSize:16];
        [self.topView addSubview:symbolLabel];
        [symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(26);
            make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_equalTo(27);
            make.size.mas_equalTo(CGSizeMake(10, 16));
            make.bottom.mas_equalTo(-23);
        }];
        
        self.moneyLabel = [Tool labelWithTitle:@"924" color:k272F3FColor fontSize:24 alignment:0];
        [self.topView addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(symbolLabel.mas_right).mas_equalTo(6);
            make.right.mas_equalTo(self.withdrawButton.mas_left).mas_equalTo(-12);
            make.bottom.mas_equalTo(symbolLabel.mas_bottom).mas_equalTo(0);
            make.height.mas_equalTo(24);
        }];
        
        //阴影
        self.topView.layer.shadowColor = k666666Color.CGColor;
        self.topView.layer.shadowOffset = CGSizeMake(1, 2);
        self.topView.layer.shadowOpacity = .8;
        
        [self setButtonView];
    }
    return self;
}

-(void)setButtonView{
    [self headButtonView];
    [self viewControllerArray];
    
    [self pageController];
    
    
    
    [self syncScrollView];
    
    self.currentPageIndex = 0;
    
    __weak __typeof(self)weakSelf = self;
    [self.headButtonView setHeadButtonsCallBack:^(NSInteger i) {
//        @strongify(self);
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

- (WHeadButtonsView *)headButtonView{
    if (_headButtonView == nil) {
        
        _headButtonView = [[WHeadButtonsView alloc] initWithTitlesArray:@[@"商城消费",@"我的佣金",@"退款明细",@"提现明细"] with:YES];
        [self addSubview:_headButtonView];
        [_headButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(12);
            make.height.mas_equalTo(56);
        }];
    }
    return _headButtonView;
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
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(self.headButtonView.mas_bottom).mas_equalTo(0);
            
            
            //            make.size.mas_equalTo(CGSizeMake(KHScreenW, self.bounds.size.height-44));
            
        }];
    }
    return _pageController;
}

- (NSMutableArray *)viewControllerArray{
    if (!_viewControllerArray) {
        _viewControllerArray = [[NSMutableArray alloc]init];
        MarketAndBackViewController *vc1 = [[MarketAndBackViewController alloc]init];
        vc1.type = @"商城消费";
        MoneyViewController *vc2 = [[MoneyViewController alloc]init];
        vc2.type = @"我的佣金";
        MarketAndBackViewController *vc3 = [[MarketAndBackViewController alloc]init];
        vc3.type = @"退款明细";
        MoneyViewController *vc4 = [[MoneyViewController alloc]init];
        vc4.type = @"提现明细";
        [_viewControllerArray addObject:vc1];
        [_viewControllerArray addObject:vc2];
        [_viewControllerArray addObject:vc3];
        [_viewControllerArray addObject:vc4];
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
    for (UIButton *button in self.headButtonView.buttonsArray) {
        [button setTitleColor:kAAAAAAColor forState:UIControlStateNormal];
    }
    UIButton *button = self.headButtonView.buttonsArray[index];
    [button setTitleColor:The_MainColor forState:UIControlStateNormal];
    CGFloat width = KHScreenW/self.headButtonView.titlesArray.count;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = CGRectMake((width-20)/2+width*index, 40, 20, 3);
        self.headButtonView.lineView.frame = frame;
    }];
}

-(void)setCurrentPageIndex:(NSInteger)currentPageIndex{
    _currentPageIndex = currentPageIndex;
    for (UIButton *button in self.headButtonView.buttonsArray) {
        [button setTitleColor:kAAAAAAColor forState:UIControlStateNormal];
    }
    UIButton *button = self.headButtonView.buttonsArray[self.currentPageIndex];
    [button setTitleColor:The_MainColor forState:UIControlStateNormal];
    CGFloat width = KHScreenW/self.headButtonView.titlesArray.count;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = CGRectMake((width-20)/2+width*self.currentPageIndex, 40, 20, 3);
        self.headButtonView.lineView.frame = frame;
    }];
    
    if (self.currentPageIndex >= 2) {
        [self.pageController setViewControllers:@[[self.viewControllerArray objectAtIndex:self.currentPageIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }else{
        [self.pageController setViewControllers:@[[self.viewControllerArray objectAtIndex:self.currentPageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    
    self.headButtonView.lastButtonTag = self.currentPageIndex;
}

#pragma mark --------Scroll协议-------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (UIButton *button in self.headButtonView.buttonsArray) {
        [button setTitleColor:kAAAAAAColor forState:UIControlStateNormal];
    }
    UIButton *button = self.headButtonView.buttonsArray[self.currentPageIndex];
    [button setTitleColor:The_MainColor forState:UIControlStateNormal];
    CGFloat width = KHScreenW/self.headButtonView.titlesArray.count;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = CGRectMake((width-20)/2+width*self.currentPageIndex, 40, 20, 3);
        self.headButtonView.lineView.frame = frame;
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

-(void)setPersonalModel:(PersonalInfoModel *)personalModel{
    _personalModel = personalModel;
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgBase_Url,personalModel.imgUrl]] placeholderImage:[UIImage imageNamed:@"我的资金头像"]];
    [Tool setImgurl:self.iconImageView imgurl:personalModel.imgUrl];
    self.nameLabel.text = personalModel.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",personalModel.money.floatValue/100];
}

@end
