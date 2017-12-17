//
//  CreateViewController.m
//  XiJuOBJ
//
//  Created by james on 16/9/6.
//  Copyright © 2016年 kerr. All rights reserved.
//


#import "CreateViewController.h"

//#import "HomeViewController.h"
#import "HomeSingleCell.h"
#import "HomeModel.h"
#import "HomeMultCell.h"
#import "MJChiBaoZiHeader.h"
#import "newsVC.h"
#import <Lottie/Lottie.h>

@interface CreateViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_tableViewDataArray;
    
}

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller

-(void)prepareData
{
//    _tableViewDataArray = [[NSMutableArray alloc]init];
//
//    for (int i = 0; i < 10; i++) {
//        HomeModel *model = [[HomeModel alloc]init];
//        model.titleImgUrl = textImg_Url;
//        model.title = textTitle_Url;
//        model.detailTitle = @"哈哈";
//        model.type = @"0";
//        model.Price = @"$100000起";
//        model.colorArr = @[@"a1c6e7",@"3d4136",@"8dd07d"];
//        model.imgArr = @[textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url];
//        [_tableViewDataArray addObject:model];
//        
//    }
    
    
    NSDictionary *dic = @{@"type":@"2",
                          };
    
    
    [HttpRequestManager postChuangyiRequest:dic viewcontroller:self finishBlock:^(NSMutableArray *arr) {
        
        _tableViewDataArray = arr;
        [_tableview reloadData];
    }];
    

    
    [_tableview.mj_header endRefreshing];
    
}

-(void)configUI
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64-30) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_tableview];
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(prepareData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    [header beginRefreshing];
    
    _tableview.mj_header = header;
    
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
    
    //    if ([model.type intValue] == 0) {
    static NSString *cellid = @"HomeMultCell";
    HomeMultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[HomeMultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    //        HomeModel *model = _tableViewDataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    //    }else
    //    {
    //        static NSString *cellid = @"HomeSingleCell";
    //
    //        HomeSingleCell *cell = [[HomeSingleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid model:model index:indexPath uiviewcontroller:self];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        [cell.moreButton addTarget:self action:@selector(MoreImgAction:) forControlEvents:UIControlEventTouchUpInside];
    //        cell.moreButton.tag = 100 + indexPath.row;
    //        return cell;
    //    }
    
    
}
//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel *model = _tableViewDataArray[indexPath.row];
    

    newsVC *vc = [[newsVC alloc]init];
    
    vc.homemodel = model;
    vc.chuanyiId = model.ID;
//    vc.resourceUrl = @"https://www.baidu.com";
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
            return model.imgArr.count/3*(width + 10) + 310 ;
        }else
        {
            if (model.imgArr.count>5) {
                return 2*(width + 10) + 310 ;
                
            }else
            {
                return model.imgArr.count/3*(width + 10) + 310 ;
                
            }
        }
    }
    
    
}



@end
