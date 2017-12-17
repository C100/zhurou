//
//  ZHPigBannerView.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigBannerView.h"
#import "UIView+Nib.h"

@interface ZHPigBannerView () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlWidth;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) CGFloat viewWidth;
@property (nonatomic) CGFloat viewHeight;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *currentModels;

@end

@implementation ZHPigBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBannerView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initBannerView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)initBannerView
{
    UIView *view = [[NSBundle bundleForClass:self.class] loadNibNamed:@"ZHPigBannerView" owner:self options:nil][0];
    [self zhAddSubviewToFillContent:view];

    self.pageControl.hidden = YES;
    self.scrollView.scrollsToTop = NO;
    self.currentModels = [NSMutableArray array];
}

#pragma mark - NSTimer
- (void)timerStart
{
    [self timerStop];
    if (self.dataSource.count > 1) {
        self.timer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(timerScrollImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:UITrackingRunLoopMode beforeDate:[NSDate date]];
    }
}

- (void)timerStop
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)timerScrollImage
{
    [self.scrollView setContentOffset:CGPointMake(self.viewWidth * 2, 0) animated:YES];
}

- (void)manageExceptionWhenAutoScroll
{
    if (self.scrollView.contentOffset.x > self.viewWidth) {
        self.scrollView.contentOffset = CGPointMake(self.viewWidth * 2, 0);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self timerStop];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self timerStart];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(self.viewWidth, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= self.viewWidth * 2) {
        self.currentPage++;
        if (self.currentPage >= self.dataSource.count) {
            self.currentPage = 0;
        }
        [self reloadData];
    } else if (scrollView.contentOffset.x <= 0) {
        self.currentPage--;
        if (self.currentPage < 0) {
            self.currentPage = self.dataSource.count - 1;
        }
        [self reloadData];
    }
}

#pragma mark - DataSource
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    if (dataSource.count <= 0) {
        return;
    }
    self.pageControl.hidden = NO;
    self.viewWidth = [[UIScreen mainScreen] bounds].size.width;
    self.viewHeight = self.bounds.size.height;
    self.pageControl.numberOfPages = dataSource.count;
    self.pageControlWidth.constant = dataSource.count * 16;
    [self reloadData];
    [self timerStart];
}

- (void)reloadData
{
    self.pageControl.currentPage = self.currentPage;
    if (self.dataSource.count == 0) {
        return;
    }
    if (self.currentModels.count > 0) {
        [self.currentModels removeAllObjects];
    }
    // 当数据源变少时，防止currentPage越界
    if (self.currentPage > self.dataSource.count - 1) {
        self.currentPage = self.dataSource.count - 1;
    }
    NSInteger currentIndex = self.currentPage;
    NSInteger total = self.dataSource.count;
    NSInteger frontIndex = (currentIndex + total - 1) % total;
    NSInteger rearIndex = (currentIndex + total + 1) % total;

    [self.currentModels addObject:self.dataSource[frontIndex]];
    [self.currentModels addObject:self.dataSource[currentIndex]];
    [self.currentModels addObject:self.dataSource[rearIndex]];
    [self configureScrollView];

}

- (void)configureScrollView
{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    self.scrollView.contentSize = CGSizeMake(self.viewWidth * 3, self.viewHeight);
    for (int index = 0; index < self.currentModels.count; index++) {
        [self addScrollViewSubviewsWithIndex:index];
    }
    [self.scrollView setContentOffset:CGPointMake(self.viewWidth, 0)];
}

- (void)addScrollViewSubviewsWithIndex:(NSInteger)index
{
    UIImageView *bannerContentView = [[UIImageView alloc] initWithFrame:CGRectMake(self.viewWidth * index, 0, self.viewWidth, self.viewHeight)];
    [bannerContentView sd_setImageWithURL:[NSURL URLWithString:self.currentModels[index]]];
    [self.scrollView addSubview:bannerContentView];
}

@end
