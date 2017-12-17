//
//  SpecVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "SpecVC.h"
#import "SpecCell.h"
#import "SpecModel.h"
#import "SpecLayout.h"
#import "CommonModel.h"
#import "CommentCell.h"
#import "GoodsDetailCell.h"
@interface SpecVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
    GoodsDetailModel *_dataModel;

}
@end

@implementation SpecVC



- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataModel:) name:@"reloadDataModel" object:nil];
        
    }
    return self;
}
/*
 实现瀑布流的效果:
 1.用UIScrollView直接实现
 2.用两个UITableView联动的方式来实现
 3.UICollectionView实现
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareData];
    
    [self configUI];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)reloadDataModel:(NSNotification *)text
{
    _dataModel =  text.object;
//    
//    _shoopingModel.modelArr = _dataModel.shoppingCareGoodsArr;
//    _shoopingModel.titleText = _dataModel.title;
//    _shoopingModel.type = _dataModel.detailTitle;
//    _shoopingModel.price = _dataModel.price;
//    NSMutableDictionary *colorDic = [[NSMutableDictionary alloc]init];
//    NSMutableDictionary *stytleDic = [[NSMutableDictionary alloc]init];
    
//    for (int i = 0; i < _dataModel.shoppingCareGoodsArr.count; i++) {
//        
//        ShoppingGoodsModel *model = _dataModel.shoppingCareGoodsArr[i];
//        
//        [colorDic setObject:@"1" forKey:model.color];
//        [stytleDic setObject:@"1" forKey:model.stytle];
//        
//    }
//    _shoopingModel.number = @"1";
//    _shoopingModel.colorArr = [[colorDic allKeys] mutableCopy];
//    _shoopingModel.typeArr = [[stytleDic allKeys] mutableCopy];
//    
//    _underView.Lab1.text = [[NSString alloc]initWithFormat:@"￥%@起",_dataModel.price];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

-(void)prepareData
{
    
}

-(void)configUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64-40) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = The_list_light_backgroundColor;
    [self.view addSubview:self.tableView];
    
    self.tableView.estimatedRowHeight = 60;
    
}


#pragma mark buttonAction


#pragma mark --tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger row= 0;
    switch (section) {
        case 0:
            row=0;
            break;
        case 1:
            row=0;
            break;
        case 2:
            row=1;
            break;
        case 3:
            row=1;
            break;
//        case 4:
//            row=1;
//            break;
//        case 5:
//        {
//            row=_dataModel.commentArr.count;
//            if (_dataModel.commentArr.count > 3) {
//                row = 3;
//            }
//        }
//            break;
            
            
        default:
            break;
    }
    
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 5) {
//        static NSString *cellid = @"CommentCell";
//        CommentModel *model = _dataModel.commentArr[indexPath.row];
//        //        model.havePingLunTitle = YES;
//        CommentCell *cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid model:model index:indexPath uiviewcontroller:self];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        static NSString *cellid = @"Comment333Cell";
                CommentModel *model = _dataModel.commentArr[indexPath.row];
        //    model.havePingLunTitle = YES;
        
        
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.model = model;

        return cell;
        
    }else
    {
        GoodsDetailCell *cell = [[GoodsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodsDetailCell" model:_dataModel index:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}





//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0 || section == 1) {
        return 0.01;
    }
    return 10;
}


//返回分区的脚的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row= 0;
    switch (indexPath.section) {
        case 0:
            row= ScalePx(220) + 46 + _dataModel.detailHeight + 20;
            break;
        case 1:
        {
            CommonModel *commonModel =  _dataModel.goodsArr[indexPath.row];
            row=commonModel.height + ScalePx(195) + 25;
            
        }
            break;
        case 2:
        {
//            row= ScalePx(152) + 60;
            return UITableViewAutomaticDimension;
            
        }
            break;
        case 3:
        {
            row= _dataModel.canshuCellHeight;
            
        }
            break;
        case 4:
        {
            row= (_dataModel.tuijianArr.count/3 + 1) * 100 + 58;
        }
            break;
            default:
            break;
    }
    
    return row;
}

//-(void)reloadDataModel:(NSNotification *)text
//{
//    _dataModel =  text.object;
////    _tableViewDataArray = _dataModel.commentArr;
//    
//    
//    
//    [self.tableView reloadData];
//}
//
//-(void)prepareData
//{
//    _dataArray = [[NSMutableArray alloc]init];
//        for (int i = 0; i<10; i++) {
//            SpecModel *model = [[SpecModel alloc]init];
////            model.cellHeight = arc4random() % 300 + 50;
//            model.imageUrl = textImg_Url;
//            model.title = @"重量";
//            model.detailTitle = @"20kg";
//            if (i>=3) {
//                model.title = @"安装情况";
//                model.detailTitle = @"随金属架附送7个螺杆，5-9分钟简单安装，分为好几个步骤进行。根据个人动手能力进行现场指导";
//            }
//            
//
//         CGSize mysize =   [model.detailTitle sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(KHScreenW/2-30, MAXFLOAT)];
//            model.cellHeight = mysize.height + 80;
//            [_dataArray addObject:model];
//        }
//    
//    
//    
//}
//
//-(void)uiConfig
//{
//    //layout是用来决定collectionView的布局的
//    //collectionView的属性,所有cell的属性
//    SpecLayout *layout = [[SpecLayout alloc]init];;
//    
//    layout.dataArray = _dataArray;
//    
//    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
//    
//    //initWithFrame:collectionViewLayout:layout
//    //    {
//    //        self.layout = layout;
//    //        layout.collectionView = self;
//    //
//    //        self.contentSize = [layout collectionViewContentSize];
//    //
//    //    }
//    
//    _collectionView.dataSource = self;
//    _collectionView.delegate = self;
//    [self.view addSubview:_collectionView];
//    _collectionView.backgroundColor = [UIColor whiteColor];
//    
//    [_collectionView registerClass:[SpecCell class]  forCellWithReuseIdentifier:@"cell"];
//    
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return _dataArray.count;
//}
//
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    SpecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    
//    cell.model = _dataArray[indexPath.row];
//    
//    return cell;
//}
//
//
@end




