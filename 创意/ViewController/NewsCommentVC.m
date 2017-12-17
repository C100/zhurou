//
//  NewsCommentVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "NewsCommentVC.h"
#import "NewsCommentModel.h"
#import "newsCommentCell.h"
#import "NewsReplyVC.h"

@interface NewsCommentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_tableViewDataArray;
    
    UITableView *_tableView;
//    GoodsDetailModel *_dataModel;
    
}


@end

@implementation NewsCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于原木生活";
    
    [self configUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self prepareData];

    
}

#pragma mark intviewcontroller




-(void)prepareData
{
    
    NSDictionary *dic = @{@"id":_chuanyiId,
                          };
    
    [HttpRequestManager postChuanyiDeatailRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data ,NSMutableArray *arr) {
        _tableViewDataArray = arr;
        
        NSDictionary *infoDic = data[@"info"];
//        _resourceUrl = infoDic[@"chuanyiContent"];
        self.title = infoDic[@"chuanyiName"];
        
        [self.tableView reloadData];
    }];
    

//    
//        _tableViewDataArray = [[NSMutableArray alloc]init];
//        for (int i = 0; i < 10; i++) {
//            NewsCommentModel *model = [[NewsCommentModel alloc]init];
//            model.time = @"2016-08-09";
//            model.name = @"老朱";
//            model.detailTitle = @"感受到壹筑e家的购买流程和产品详情感觉横不错，安装也十分简单";
//            model.nameImgUrl = textImg_Url;
//           
//    
//            CGSize detailSize = [model.detailTitle sizeWithFont:[UIFont fontWithName:The_titleFont size:13] maxSize:CGSizeMake(KHScreenW-70, CGFLOAT_MAX)];
////            CGSize replyTitleSize = [model.replyTitle sizeWithFont:[UIFont fontWithName:The_titleFont size:13] maxSize:CGSizeMake(KHScreenW-70, CGFLOAT_MAX)];
//            model.detailTitleHeight = detailSize.height;
////            model.replyTitleHeight = replyTitleSize.height;
//            
//            
//            for (int j = 0; j < 10; j++) {
//                CommonModel *comm = [[CommonModel alloc]init];
//                comm.title1 = @"用户";
//                comm.title2 = @"2016-3-23";
//                comm.title3 = @"亲爱的用户您好，画板餐桌目前只有官网出售的固定规格，我们会反馈给你的建议希望可以有更多的选择，另外建议您可以查看其他种类的桌子，感谢你的关注。";
//                
//                if (j==2) {
//                    comm.title3 = @"感谢你的关注。";
//                }
//                
//                CGSize detailSize = [comm.title3 sizeWithFont:[UIFont fontWithName:The_titleFont size:13] maxSize:CGSizeMake(KHScreenW-70, CGFLOAT_MAX)];
//                
//                comm.height = detailSize.height;
//
//                [model.replyModelArr addObject:comm];
//            }
//            
//            [_tableViewDataArray addObject:model];
//        }
    
    
}

-(void)configUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    //    [self.tableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    
    
    UIView *underView = [[UIView alloc]init];
        underView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:underView];
    [self.view bringSubviewToFront:underView];
    
    [underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.height.mas_equalTo(60);
    }];

    UIButton *newAddressBtn = [Tool buttonWithTitle:@"添加评论" titleColor:[UIColor whiteColor] font:18 imageName:nil target:self action:@selector(addPinglun)];
    newAddressBtn.backgroundColor = The_MainColor;
    [underView addSubview:newAddressBtn];
    
    [newAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.right.offset(-50);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];

}



#pragma mark buttonAction

-(void)addPinglun
{
    
    NewsReplyVC *vc = [[NewsReplyVC alloc]init];
    vc.detailTitle = self.title;
        vc.chuanyiId = _chuanyiId;
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)replyAction:(UIButton*)btn
{
    
    NewsCommentModel *model = _tableViewDataArray[btn.tag - 100];

    NewsReplyVC *vc = [[NewsReplyVC alloc]init];
    vc.detailTitle = self.title;
    vc.chuanyiId = _chuanyiId;
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"你好");
    
    
    
}

#pragma mark --tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewDataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid = @"CommentCell";
    NewsCommentModel *model = _tableViewDataArray[indexPath.row];
    model.havePingLunTitle = YES;
    newsCommentCell *cell = [[newsCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid model:model index:indexPath uiviewcontroller:self];
    [cell.replyBtn addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.replyBtn.tag = 100 + indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //分割线
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    
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
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsCommentModel *model = _tableViewDataArray[indexPath.row];
    
    CGFloat cellHeight;
    
    cellHeight = model.detailTitleHeight + 74;
    
    if (indexPath.row == 0) {
        cellHeight = model.detailTitleHeight + 126;

    }
    
    
    for (CommonModel *common in model.replyModelArr) {
        cellHeight  = common.height + 60 + cellHeight ;
    }
    

    
    return cellHeight;
    
}



@end
