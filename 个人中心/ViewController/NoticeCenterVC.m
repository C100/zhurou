//
//  NoticeCenterVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/11.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "NoticeCenterVC.h"
#import "NoticeCenterCell.h"
#import "NoticeCenterModel.h"


@interface NoticeCenterVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_tableViewDataArray;
    
}

@end

@implementation NoticeCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    self.view.backgroundColor =  The_list_backgroundColor;
    
    [self prepareData];
    [self configUI];
}
-(void)prepareData
{
    _tableViewDataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 10; i++) {
        NoticeCenterModel *model = [[NoticeCenterModel alloc]init];
       model.timeStr = @"8月25日  18:00";
        model.imgUrl = textImg_Url;
        model.detailStr = @"尊敬的柚元，为庆祝杭州G20峰会的顺利召开，壹筑e家现推出“满2000送1000代金券”活动，活动时间为2016年9月1日至2016年9月10日。";
        CGSize replyTitleSize = [model.detailStr sizeWithFont:[UIFont fontWithName:The_titleFont size:14] maxSize:CGSizeMake(KHScreenW-140, CGFLOAT_MAX)];
        model.detailStrHeight = replyTitleSize.height ;
        [_tableViewDataArray addObject:model];
    }
    
    
    
    
}

-(void)configUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    
    
    NoticeCenterCell *cell = [[NoticeCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid InspectModel:model IndexPath:indexPath VC:self];
    [cell.openBtn addTarget:self action:@selector(openBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.openBtn.tag = 100 + indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    [cell.moreButton addTarget:self action:@selector(MoreImgAction:) forControlEvents:UIControlEventTouchUpInside];
    //    cell.moreButton.tag = 100 + indexPath.row;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
    
    NoticeCenterModel *model = _tableViewDataArray[indexPath.row];
    
//    CGFloat cellHeight = 180;
    
//    cellHeight = model.detailTitleHeight + 44;
//    
//    if (model.imgArr.count > 0) {
//        cellHeight  = ScalePx(80) + cellHeight + 10;
//    }
//    
//    if (model.replyTitle.length > 0) {
//        cellHeight  = 80 + cellHeight + model.replyTitleHeight;
//        
//    }
    
    
    
    CGFloat detailStrHeight = 0;
    if (model.detailStrHeight > 70) {
       
        
        if (model.isOpen) {
            detailStrHeight = model.detailStrHeight + 10;
            
        }else{
            detailStrHeight = 70;
        }
        detailStrHeight =  detailStrHeight + 40;
        
    }else
    {
      
        
        detailStrHeight = model.detailStrHeight;
    }
    
       return detailStrHeight + 50;
    
}




@end
