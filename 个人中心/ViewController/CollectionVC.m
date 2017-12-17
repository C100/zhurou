//
//  CollectionVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/23.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "CollectionVC.h"
#import "SearchGoodsModel.h"
#import "SearchGoodsCell.h"
#import "SeearchTitleView.h"
#import "SearchSelectModel.h"
#import "GoodsVC.h"
@interface CollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView* _vibrate;
    NSMutableArray *_sectionViewDataArry;
//    NSMutableArray *_searchViewArr1;
    NSMutableArray *_searchViewArr2;
    NSMutableArray *_searchViewArr3;
    
    
}

@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的收藏";
    
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareData];
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
//        model.isCollection = YES;
//        [_sectionViewDataArry addObject:model];
//    }
    
//    _searchViewArr1 = [[NSMutableArray alloc]init];
//    for (int i = 0; i < 10; i++) {
//        SearchSelectModel *model = [[SearchSelectModel alloc]init];
//        model.title = [[NSString alloc]initWithFormat:@"样式%d",i];
//        //        model.name = textTitle_Url;
//        //        model.price = @"10000";
//        
//        [_searchViewArr1 addObject:model];
//    }
//    
    [HttpRequestManager postCollectGetRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *arr) {
        _sectionViewDataArry = arr;
        [_vibrate reloadData];
        
    }];
    
    
}

-(void)configUI
{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    CGFloat space =(KHScreenW - ScalePx(172) * 2)/3-2;
    
    
    //创建一个layout布局类
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为127.5*127.5
    layout.itemSize = CGSizeMake(172*KHScreenW/375, (228+10)*KHScreenW/375);
    //    //整体view据上左下右距离
    layout.sectionInset = UIEdgeInsetsMake(10, space,10,space);
    //创建collectionView 通过一个布局策略layout来创建
    _vibrate = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64) collectionViewLayout:layout];
    _vibrate.delegate = self;
    _vibrate.dataSource = self;
    _vibrate.backgroundColor = The_list_backgroundColor;
    _vibrate.showsHorizontalScrollIndicator = NO;
    _vibrate.showsVerticalScrollIndicator = NO;
    _vibrate.userInteractionEnabled = YES;
    //注册item类型 这里使用系统的类型
    [_vibrate registerClass:[SearchGoodsCell class] forCellWithReuseIdentifier:@"vibrate"];
    [self.view addSubview:_vibrate];
    

}

#pragma mark buttonAction

-(void)delectBtn:(UIButton *)btn
{
    NSLog(@"%ld",(long)btn.tag);
    
    SearchSelectModel *model =_sectionViewDataArry[btn.tag - 100];

    
    NSDictionary *dic = @{@"goodsId":model.ID,
                                                   };
    
    [[MyAlert manage] showBtnAlertWithTitle:@"警告" detailTitle:@"是否取消收藏" confirm:^{
        
        [HttpRequestManager postCollectDelteRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            
            if ([data[@"code"] intValue] == 200) {
                [_sectionViewDataArry removeObjectAtIndex:btn.tag - 100];
                [_vibrate reloadData];
            }else
            {
                
            }
        }];
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
    [cell.collectionBtn addTarget:self action:@selector(delectBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.collectionBtn.tag = 100 + indexPath.row;
    cell.Model = _sectionViewDataArry[indexPath.row];
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
