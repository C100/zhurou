//
//  HomeViewController.m
//  XiJuOBJ
//
//  Created by james on 16/9/6.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeSingleCell.h"
#import "HomeModel.h"
#import "HomeMultCell.h"
#import "MJChiBaoZiHeader.h"
#import "ShoppingCartVC.h"
#import "SearchGoodsVC.h"
#import "GoodsVC.h"
#import "FindDetailVC.h"
#import "newsVC.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_tableViewDataArray;

}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BXRandomColor;
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller

-(void)prepareData
{
    

    [HttpRequestManager postHomeRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *arr) {
        
        _tableViewDataArray = arr;
        [_tableview reloadData];
    }];

    
    [_tableview.mj_header endRefreshing];
    
}

-(void)configUI
{
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-49-64) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
    _tableview.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(prepareData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    [header beginRefreshing];
    
    _tableview.mj_header = header;
    
//    [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"密码或用户名错误"];
    

}

#pragma mark buttonAction
-(void)MoreImgAction:(UIButton *)btn
{
    HomeModel *model = _tableViewDataArray[btn.tag - 100];
    model.isOpen = !model.isOpen ;
    [_tableview reloadData];

}

#pragma mark --tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HomeModel *model = _tableViewDataArray[indexPath.row];
    
    if ([model.type intValue] == 3 || [model.type intValue] == 2) {
        static NSString *cellid = @"HomeMultCell";
        HomeMultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[HomeMultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        HomeModel *model = _tableViewDataArray[indexPath.row];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }else
    {
        static NSString *cellid = @"HomeSingleCell";

        HomeSingleCell *cell = [[HomeSingleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid model:model index:indexPath uiviewcontroller:self];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.moreButton addTarget:self action:@selector(MoreImgAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.moreButton.tag = 100 + indexPath.row;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel *model = _tableViewDataArray[indexPath.row];

    if ([model.type intValue] == 3) {
        FindDetailVC *vc = [[FindDetailVC alloc]init];
        vc.goodIds = model.ID;
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.type intValue] == 1){
        GoodsVC *vc = [[GoodsVC alloc]init];
        vc.goodIds = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
 
    }else
    {
        newsVC *vc = [[newsVC alloc]init];
        vc.chuanyiId = model.ID;
//        vc.resourceUrl = @"https://www.baidu.com";
        [self.navigationController pushViewController:vc animated:YES];
    }
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
    CGFloat width = (KHScreenW - 15*4)/3;

    HomeModel *model = _tableViewDataArray[indexPath.row];
    
    if ([model.type intValue] == 0) {
        
        return 300;
        
    }else
    {
        if (model.isOpen) {
            //布局 改--原来没有加1的
            return (model.imgArr.count/3+1)*(width + 10) + 310 ;
        }else
        {
            if (model.imgArr) {
                if (model.imgArr.count>5) {
//                    return 2*(width + 10) + 310 ;
                    return 300;
                    
                }else
                {
//                    return (model.imgArr.count/3+1)*(width + 10) + 310 ;
                    return 300;
                    
                }
            }else{
                return 310;
            }
            
        }
    }
    
    
}





@end
