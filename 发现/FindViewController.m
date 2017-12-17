//
//  FindViewController.m
//  XiJuOBJ
//
//  Created by james on 16/9/6.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "FindViewController.h"
#import "FindDetailVC.h"

//#import "HomeViewController.h"
#import "HomeSingleCell.h"
#import "HomeModel.h"
#import "HomeMultCell.h"
#import "MJChiBaoZiHeader.h"
@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_tableViewDataArray;
    
}

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableViewDataArray = [[NSMutableArray alloc]init];
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareData
{
    
//    for (int i = 0; i < 10; i++) {
//        HomeModel *model = [[HomeModel alloc]init];
//        model.titleImgUrl = textImg_Url;
//        model.title = @"吾孙——朱泽众";
//        model.detailTitle = @"哈哈";
//        model.Price = @"$100000起";
//        model.type = @"1";
//        model.colorArr = @[@"a1c6e7",@"3d4136",@"8dd07d"];
//        model.imgArr = @[textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url];
//        [_tableViewDataArray addObject:model];
//        
//    }
    
//    for (int i = 0; i < 10; i++) {
//        HomeModel *model = [[HomeModel alloc]init];
//        model.titleImgUrl = textImg_Url;
//        model.title =textTitle_Url;
//        model.detailTitle = @"哈哈";
//        model.type = @"0";
//        model.Price = @"$100000起";
//        model.colorArr = @[@"a1c6e7",@"3d4136",@"8dd07d"];
//        model.imgArr = @[textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url,textImg_Url];
//        [_tableViewDataArray addObject:model];
//        
//    }
    
    
    NSDictionary *dic = @{@"type":@"3",
                          };
    [HttpRequestManager postHomeRequest:dic viewcontroller:self finishBlock:^(NSMutableArray *arr) {
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeModel *model = _tableViewDataArray[indexPath.row];
    FindDetailVC *vc = [[FindDetailVC alloc]init];
    vc.title = model.title;
    vc.goodIds = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
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
