//
//  NoticeCenterVC2.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/15.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "NoticeCenterVC2.h"
#import "NoticeCenterCell2.h"
#import "NoticeCenterModel.h"
#import "NoticeCenterDetailVC.h"
#import "FindDetailVC.h"
#import "newsVC.h"

@interface NoticeCenterVC2 ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_tableViewDataArray;
}

@end

@implementation NoticeCenterVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    self.view.backgroundColor =  The_list_backgroundColor;
    
//    [self prepareData];
    [self configUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self prepareData];
}

-(void)prepareData
{
    
    
    [HttpRequestManager postXiaoXiGetRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *data) {
        
        
        _tableViewDataArray = data;
        [self.tableView reloadData];
        
    }];
    
    
//    _tableViewDataArray = [[NSMutableArray alloc]init];
//    for (int i = 0; i < 10; i++) {
//        NoticeCenterModel *model = [[NoticeCenterModel alloc]init];
//        model.timeStr = @"8月25号  18:00";
//        model.imgUrl = textImg_Url;
//        model.detailStr = @"尊敬的柚元，为庆祝杭州G20峰会的顺利召开，壹筑e家现推出“满2000送1000代金券”活动，活动时间为2016年9月1日至2016年9月10日。";
//        CGSize replyTitleSize = [model.detailStr sizeWithFont:[UIFont fontWithName:The_titleFont size:14] maxSize:CGSizeMake(KHScreenW-20, CGFLOAT_MAX)];
//        model.detailStrHeight = replyTitleSize.height ;
//        [_tableViewDataArray addObject:model];
//    }
}

-(void)configUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    [self.tableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
}



#pragma mark buttonAction

-(void)openBtnAction:(UIButton *)btn
{
    NoticeCenterModel *model = _tableViewDataArray[btn.tag - 100];
    model.isOpen = !model.isOpen;
    [self.tableView reloadData];
}

#pragma mark --tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewDataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid = @"NoticeCenterCell";
    NoticeCenterModel *model = _tableViewDataArray[indexPath.row];
    
    
    NoticeCenterCell2 *cell = [[NoticeCenterCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid InspectModel:model IndexPath:indexPath VC:self];
    [cell.openBtn addTarget:self action:@selector(openBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.openBtn.tag = 100 + indexPath.row;
    cell.detailInfoBtn.tag = 10 + indexPath.row;
    [cell.detailInfoBtn addTarget:self action:@selector(pushDetailAction2:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    [cell.moreButton addTarget:self action:@selector(MoreImgAction:) forControlEvents:UIControlEventTouchUpInside];
    //    cell.moreButton.tag = 100 + indexPath.row;
    
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self pushDetailAction:indexPath.row];
    
}

-(void)pushDetailAction2:(UIButton *)btn
{
    
    NoticeCenterModel *model = _tableViewDataArray[btn.tag - 10];
    
    NSDictionary *dic = @{@"id":model.ID,
                          
                          };
    [HttpRequestManager postXiaoXiReadRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
    }];
    
    if ([model.type intValue] == 3) {
        FindDetailVC *vc = [[FindDetailVC alloc]init];
        vc.goodIds = model.turnID;
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.type intValue] == 1)
    {
        
        NoticeCenterDetailVC *vc = [[NoticeCenterDetailVC alloc]init];
        vc.noticeModel = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else
    {
        newsVC *vc = [[newsVC alloc]init];
        vc.chuanyiId = model.turnID;
        //        vc.resourceUrl = @"https://www.baidu.com";
        [self.navigationController pushViewController:vc animated:YES];
        
    }

}

-(void)pushDetailAction:(NSInteger )index
{
    
    NoticeCenterModel *model = _tableViewDataArray[index];

    NSDictionary *dic = @{@"id":model.ID,
                          
                          };
    [HttpRequestManager postXiaoXiReadRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
    }];
    
    if ([model.type intValue] == 3) {
        FindDetailVC *vc = [[FindDetailVC alloc]init];
        vc.goodIds = model.turnID;
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.type intValue] == 1)
    {
        
        NoticeCenterDetailVC *vc = [[NoticeCenterDetailVC alloc]init];
        vc.noticeModel = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else
    {
        newsVC *vc = [[newsVC alloc]init];
        vc.chuanyiId = model.turnID;
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
    
//    NoticeCenterModel *model = _tableViewDataArray[indexPath.row];
//    
//    
//    
//    
//    CGFloat detailStrHeight = 0;
//    if (model.detailStrHeight > 70) {
//        
//        
//        if (model.isOpen) {
//            detailStrHeight = model.detailStrHeight + 10;
//            
//        }else{
//            detailStrHeight = 70;
//        }
//        detailStrHeight =  detailStrHeight + 40;
//        
//    }else
//    {
//        
//        
//        detailStrHeight = model.detailStrHeight;
//    }
    
    return 116;
    
}





@end
