//
//  SearchGoodsVCViewController.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/18.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "SearchGoodsVC.h"
#import "SearchGoodsModel.h"
#import "SearchGoodsCell.h"
#import "SeearchTitleView.h"
#import "SearchSelectModel.h"
#import "GoodsVC.h"
@interface SearchGoodsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,SeearchTitleViewDelegate>
{
     UICollectionView* _vibrate;
    NSMutableArray *_sectionViewDataArry;
    SeearchTitleView *_searchTitleView;
    NSMutableArray *_searchViewArr1;
    NSMutableArray *_searchViewArr2;
    NSMutableArray *_searchViewArr3;
    NSMutableDictionary *_praparmDic;
    BOOL _isNeedSearchContent;
    
}

@end

@implementation SearchGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
//    _sectionViewDataArry = [[NSMutableArray alloc]init];
//    for (int i = 0; i < 10; i++) {
//        SearchGoodsModel *model = [[SearchGoodsModel alloc]init];
//        model.imgUrl = textImg_Url;
//        model.name = textTitle_Url;
//        model.price = @"10000";
//        
//        [_sectionViewDataArry addObject:model];
//    }

    _isNeedSearchContent = NO;
    
    _praparmDic = [[NSMutableDictionary alloc]init];
    [_praparmDic setObject:@"" forKey:@"sceneId"];
    [_praparmDic setObject:@"" forKey:@"colorId"];
    [_praparmDic setObject:@"" forKey:@"typeId"];

  
    [self updateGoodsData];
    
    SearchSelectModel *buxianModel = [[SearchSelectModel alloc]init];
    buxianModel.title = @"不限";
    buxianModel.ID = @"";
    
    [HttpRequestManager postSearchSceneRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *arr) {
        _searchViewArr1 = arr;
        [_searchViewArr1 insertObject:buxianModel atIndex:0];

        [self updateSearchView];
    }];

    [HttpRequestManager postSearchColorRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *arr) {
        _searchViewArr2 = arr;
        [_searchViewArr2 insertObject:buxianModel atIndex:0];

        [self updateSearchView];
    }];
    
    [HttpRequestManager postSearchTypeRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *arr) {
        _searchViewArr3 = arr;
        [_searchViewArr3 insertObject:buxianModel atIndex:0];

        [self updateSearchView];
    }];

}

-(void)configUI
{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"搜索"] style:UIBarButtonItemStylePlain target:self action:@selector(showSearchView)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    CGFloat space =(KHScreenW - ScalePx(172) * 2)/3-2;

    CGFloat width = (KHScreenW-3*10)/2;
    CGFloat height = (ScalePx(172)+68);
    
    //创建一个layout布局类
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为127.5*127.5
    layout.itemSize = CGSizeMake(width, height);
//    //整体view据上左下右距离
    layout.sectionInset = UIEdgeInsetsMake(10, 10,10,10);
    //创建collectionView 通过一个布局策略layout来创建
    _vibrate = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 80, KHScreenW, KHScreenH-64- 80) collectionViewLayout:layout];
    _vibrate.delegate = self;
    _vibrate.dataSource = self;
    _vibrate.backgroundColor = The_list_backgroundColor;
    _vibrate.showsHorizontalScrollIndicator = NO;
    _vibrate.showsVerticalScrollIndicator = NO;
    _vibrate.userInteractionEnabled = YES;
    //注册item类型 这里使用系统的类型
    [_vibrate registerClass:[SearchGoodsCell class] forCellWithReuseIdentifier:@"vibrate"];
    [self.view addSubview:_vibrate];
    
    _searchTitleView = [[SeearchTitleView alloc]init];
    _searchTitleView.seearchTitleViewDelegate = self;
    [self.view addSubview:_searchTitleView];
    [_searchTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
    
    [self updateSearchView];
    
//    _searchTitleView = [[SeearchTitleView alloc]init];
//    _searchTitleView.arr1 = _searchViewArr1;
//    _searchTitleView.vc = self;
//    [_searchTitleView setCallback:^(SearchSelectModel *model) {
//        NSLog(@"%@",model.title);
//    }];
//    [_searchTitleView congigUI];
    
//    [self.view addSubview:_searchTitleView];
//    [self.view bringSubviewToFront:_searchTitleView];
//
//    [_searchTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_offset(0);
//        make.height.mas_equalTo(40);
//    }];
    
}

-(void)showSearchView{
    _vibrate.frame = CGRectMake(0, 80, KHScreenW, KHScreenH-64- 80);
    [_searchTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(80);
    }];
    _searchTitleView.searchView.hidden = NO;
    [_searchTitleView.searchView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
    }];
    [_searchTitleView.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
    }];
}

-(void)searchContent:(NSString *)content{
    _isNeedSearchContent = YES;
    [_praparmDic setObject:content forKey:@"title"];
    [self updateGoodsData];
}

-(void)beginEdit{
    _isNeedSearchContent = NO;
}

//更新产品数据
-(void)updateGoodsData
{
    if (_isNeedSearchContent==NO||_searchTitleView.searchBar.text.length==0) {
        [_praparmDic removeObjectForKey:@"title"];
    }
    [self.view endEditing:YES];
    
    [HttpRequestManager postSearchGoodsRequest:_praparmDic viewcontroller:self finishBlock:^(NSMutableArray *arr) {
        _sectionViewDataArry = arr;
        
        [_vibrate reloadData];
    }];

}

//更新搜索的类型
-(void)updateSearchView
{
//    [_searchTitleView removeFromSuperview];
//    _searchTitleView = nil;
    
    _searchTitleView.arr1 = _searchViewArr1;
    _searchTitleView.arr2 = _searchViewArr2;
    _searchTitleView.arr3 = _searchViewArr3;

    _searchTitleView.vc = self;
    
    

    
    [_searchTitleView setCallback:^(SearchSelectModel *model) {
        NSLog(@"%@",model.title);
        
        [_praparmDic setObject:model.ID forKey:model.pragram];
        [self updateGoodsData];
        
        
    }];
    [_searchTitleView congigUI];
    [_searchTitleView.cancelButton addTarget:self action:@selector(hideSearchView) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark buttonAction
-(void)hideSearchView{
    _isNeedSearchContent=NO;
    [self updateGoodsData];
    
    _vibrate.frame = CGRectMake(0, 40, KHScreenW, KHScreenH-64- 40);
    [_searchTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
    }];
    _searchTitleView.searchBar.text = @"";
    _searchTitleView.searchView.hidden = YES;
    [_searchTitleView.searchView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [_searchTitleView.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
    }];
}


#pragma mark collectionViewDelegate

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _sectionViewDataArry.count;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchGoodsCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"vibrate" forIndexPath:indexPath];
    cell.Model = _sectionViewDataArry[indexPath.row];
    
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  SearchGoodsModel *model =  _sectionViewDataArry[indexPath.row];
    
    GoodsVC *vc = [[GoodsVC alloc]init];
    vc.goodIds = model.ID;
    vc.title = model.name;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
