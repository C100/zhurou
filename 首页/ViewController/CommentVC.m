//
//  CommendVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "CommentVC.h"
#import "CommentModel.h"
#import "CommentCell.h"
#import "GoodsDetailModel.h"


@interface CommentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_tableViewDataArray;
    
    UITableView *_tableView;
    GoodsDetailModel *_dataModel;
    UIView *wuBackView;


}

@end

@implementation CommentVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataModel:) name:@"reloadDataModel" object:nil];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self prepareData];
    [self configUI];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark intviewcontroller


-(void)reloadDataModel:(NSNotification *)text
{
    _dataModel =  text.object;
    _tableViewDataArray = _dataModel.commentArr;
    
    
    
    
    if (_tableViewDataArray.count == 0) {
        wuBackView.hidden = NO;
        //            _tableview.hidden = YES;
    }else
    {
        wuBackView.hidden = YES;;
        //            _tableview.hidden = NO;
        
    }
    
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

-(void)prepareData
{
    
//    _tableViewDataArray = [[NSMutableArray alloc]init];
//    for (int i = 0; i < 10; i++) {
//        CommentModel *model = [[CommentModel alloc]init];
//        model.time = @"2016-08-09";
//        model.name = @"老朱";
//        model.detailTitle = @"感受到壹筑e家的购买流程和产品详情感觉横不错，安装也十分简单";
//        model.nameImgUrl = textImg_Url;
//        [model.imgArr addObjectsFromArray: @[textImg_Url,textImg_Url]];
//        model.replyTitle = @"亲爱的老朱，感想您对壹筑e家的支持。你的逗逼是我们改进的动力";
//        
//        CGSize detailSize = [model.detailTitle sizeWithFont:[UIFont fontWithName:The_titleFont size:13] maxSize:CGSizeMake(KHScreenW-70, CGFLOAT_MAX)];
//        CGSize replyTitleSize = [model.replyTitle sizeWithFont:[UIFont fontWithName:The_titleFont size:13] maxSize:CGSizeMake(KHScreenW-70, CGFLOAT_MAX)];
//        model.detailTitleHeight = detailSize.height;
//        model.replyTitleHeight = replyTitleSize.height;
//        [_tableViewDataArray addObject:model];
//    }
    
  
}

-(void)configUI
{
    
    
    //没有优惠券时
    wuBackView = [[UIView alloc]init];
    [self.view addSubview:wuBackView];
    [wuBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
    
    
    if (_tableViewDataArray.count == 0) {
        wuBackView.hidden = NO;
        //            _tableview.hidden = YES;
    }else
    {
        wuBackView.hidden = YES;;
        //            _tableview.hidden = NO;
        
    }

    
    
    
    UILabel *wuLab = [Tool labelWithTitle:@"暂时没有评价" color:The_placeholder_Color_grary fontSize:15 alignment:1];
    [wuBackView addSubview:wuLab];
    
    [wuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64-40) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
//    [self.tableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    self.tableView.estimatedRowHeight = 60;

}



#pragma mark buttonAction

#pragma mark --tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewDataArray.count;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid = @"Comment333Cell";
    CommentModel *model = _tableViewDataArray[indexPath.row];
//    model.havePingLunTitle = YES;
    
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = model;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//   CommentCell *cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid model:model index:indexPath uiviewcontroller:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}



//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

//返回分区的脚的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    CommentModel *model = _tableViewDataArray[indexPath.row];
//
//    CGFloat cellHeight;
//    
//    cellHeight = model.detailTitleHeight + 44;
//    
//    if (model.imgArr.count > 0) {
//        cellHeight  = ScalePx(80) + cellHeight + 10;
//    }
//    
//    if (model.replyTitle.length > 0) {
//        cellHeight  = 80 + cellHeight + model.replyTitleHeight;
//    }
//    
//    return cellHeight;
    
    return UITableViewAutomaticDimension;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(0, 0, KHScreenW, 50);
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = The_list_light_backgroundColor;
    lineView.frame = CGRectMake(0, 0, KHScreenW, 10);
    [backView addSubview:lineView];
    
    NSString *pinglunStr = [[NSString alloc]initWithFormat:@"评论(%lu)",(unsigned long)_dataModel.commentArr.count ];
    
    UILabel *titleLab = [Tool labelWithTitle:pinglunStr color:The_TitleColor fontSize:16 alignment:1];
    [backView addSubview:titleLab];
    titleLab.frame = CGRectMake(0, 20, KHScreenW, 20);
    return backView;
}


@end
