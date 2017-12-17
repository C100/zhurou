//
//  FindDeetailVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/10/18.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "FindDetailVC.h"
#import "FindDetailModel.h"
#import "FindDetailCell.h"
#import "ShoppingCartModel.h"
#import "GoodsDetailView.h"
#import "ShoppingCarBtn.h"
#import "ShoppingCartVC.h"
@interface FindDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
 
    GoodsDetailView *_goodsView;
    FindDetailModel *_dataModel;
}

@end

@implementation FindDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    [self configUI];
 }

#pragma mark buttonAction

-(void)shareAction
{
    BXLog(@"分享");
    [[Tool tools] appShare:self];

}

#pragma mark intviewcontroller
-(void)prepareData
{
    NSDictionary *dic = @{@"id":self.goodIds,};
    [HttpRequestManager postFaxianDeatailRequest:dic viewcontroller:self finishBlock:^(FindDetailModel *model) {
        _dataModel = model;
//        self.title = model.Title;
        [self.tableView reloadData];
    }];
    
}

-(void)configUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = The_list_light_backgroundColor;
    [self.view addSubview:self.tableView];
    
    
    
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


-(void)collectionAction:(NSInteger)index
{
    
    CommonModel *  commonModel = _dataModel.googsArr[index];

    
    NSDictionary *dic = @{@"goodsId":commonModel.ID};
    
    if ([commonModel.type intValue] == 0) {
        [ HttpRequestManager postCollectAddRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            
            if ([data[@"code"] intValue] == 200) {
                commonModel.type = @"1";
                [self.tableView reloadData];
                
            }
        }];
        
    }else
    {
        [ HttpRequestManager postCollectDelteRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            if ([data[@"code"] intValue] == 200) {
                commonModel.type = @"0";

                [self.tableView reloadData];
                
            }
            
        }];
        
    }
    

}

-(void)shoppingCarAction:(NSInteger)index
{
    CommonModel *  commonModel = _dataModel.googsArr[index];
    
    
    NSDictionary *dic = @{@"goodsId":commonModel.ID};
    

    
    
    [HttpRequestManager postGoodsDeatailRequest:dic viewcontroller:self finishBlock:^(GoodsDetailModel *qusetModel) {
        
        ShoppingCartModel *_shoopingModel = [[ShoppingCartModel alloc]init];
        
        
        
        _shoopingModel.modelArr = qusetModel.shoppingCareGoodsArr;
        _shoopingModel.titleText = qusetModel.title;
        _shoopingModel.type = qusetModel.detailTitle;
        _shoopingModel.price = qusetModel.price;
        _shoopingModel.goodsId = qusetModel.goodsId;
        NSMutableDictionary *colorDic = [[NSMutableDictionary alloc]init];
        NSMutableDictionary *stytleDic = [[NSMutableDictionary alloc]init];
        
        for (int i = 0; i < qusetModel.shoppingCareGoodsArr.count; i++) {
            
            ShoppingGoodsModel *model = qusetModel.shoppingCareGoodsArr[i];
            
            [colorDic setObject:@"1" forKey:model.color];
            [stytleDic setObject:@"1" forKey:model.stytle];
            
        }
        _shoopingModel.number = @"1";
        _shoopingModel.colorArr = [[colorDic allKeys] mutableCopy];
        _shoopingModel.typeArr = [[stytleDic allKeys] mutableCopy];
        
        
        
        
        _goodsView = [[GoodsDetailView alloc]init];
//        _goodsView.selectModel = selectModel;
//        _goodsView.carId = model.carId;
        _goodsView.isAddShoppingCare = YES;
        _goodsView.Model = _shoopingModel;
        //    _goodsView.shoppingCareEdit = YES;
        [_goodsView showGoodsView:_goodsView];
        
        [_goodsView.requestBtn addTarget:self action:@selector(requestAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }];
    

    
    
}


/**
 * 确定按钮
 */

-(void)requestAction:(UIButton *)btn
{
    _goodsView.hidden = YES;
    
    
    
}


#pragma mark --tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger row= 0;
    switch (section) {
        case 0:
            row=1;
            break;
        case 1:
            row=_dataModel.contentArr.count;
            break;
        case 2:
            row=1;
            break;
        default:
            break;
    }
    
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FindDetailCell *cell = [[FindDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FindDetailCell" model:_dataModel index:indexPath uiviewcontroller:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setCollectCallback:^(NSInteger a) {
        
        [self collectionAction:a];
    }];
    
    [cell setShoppingCarCallback:^(NSInteger b) {
        [self shoppingCarAction:b];
    }];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    LoginVC *vc = [[LoginVC alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
}
//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
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
            CommonModel *commonModel =  _dataModel.contentArr[indexPath.row];
            row=commonModel.height + ScalePx(195) + 35;
            
        }
            break;
        case 2:
        {
            row=  ( _dataModel.googsArr.count/2 + _dataModel.googsArr.count%2) *(ScalePx(228) + 10) + 10;
;
   
        }
            
        default:
            break;
    }
    
    return row;
}






@end
