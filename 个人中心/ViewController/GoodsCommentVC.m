//
//  GoodsCommentVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/22.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "GoodsCommentVC.h"
#import "GoodsCommentCell.h"
#import "GoodsCommentModel.h"
#import "GoodsModel.h"

@interface GoodsCommentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_tableViewDataArray;
}

@end

@implementation GoodsCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加评论";
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    _tableViewDataArray = _orderModel.goodsArr;
    
//    GoodsModel *tempModel = [[GoodsModel alloc]init];
//    tempModel.imgUrl = textImg_Url;
//    tempModel.title = @"测试";
//    tempModel.color = @"红的";
//    
//    [_tableViewDataArray addObject:tempModel];
    for (GoodsModel *model in _tableViewDataArray) {
        model.timeStr = _orderModel.time;
    }
    
}

-(void)configUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = The_list_backgroundColor;
    self.tableView.delegate = self;
//    [self.tableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    
    
    UIBarButtonItem *item = [Tool BarButtonItemWithName:@"提交" font:15 target:self action:@selector(fabuActon)];
    
    self.navigationItem.rightBarButtonItem = item;

    
    
    
 
}


#pragma mark --tableViewDelegate



-(void)fabuActon
{
    
    
    NSMutableDictionary *commentJsonDic = [[NSMutableDictionary alloc]init];
    
    [self.view endEditing:YES];
    
    int i = 0;
    
    NSMutableArray *commentArr = [[NSMutableArray alloc]init];
    
    
    for (GoodsModel *goodesModel in _tableViewDataArray) {
        NSMutableDictionary *commentGoodsDic = [[NSMutableDictionary alloc]init];
        
        if (goodesModel.commentStr.length > 0) {
            i++;
            
//            for (NSDictionary *dic in _pinglunListArr) {
            for (int i = 0; i < _pinglunListArr.count; i++) {
                    NSDictionary *dic = _pinglunListArr[i];
                
                if ([goodesModel.goodsId integerValue] == [dic[@"commentTypeId"] integerValue] ) {
                    BXLog(@"=====成功");
                    [_pinglunListArr removeObject:dic];
                    NSMutableString *imgStr = [[NSMutableString alloc]init];
                    //拼接图片string
                    for (NSString *tempStr in goodesModel.commentImgArr) {
                        [imgStr appendFormat:@"%@;",tempStr];
                    }
                    
                    
                    if (goodesModel.commentStr.length > 255) {
                        
                        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:[[NSString alloc]initWithFormat:@"最多输入255个文字！当前字数%lu",(unsigned long)goodesModel.commentStr.length]];
                        return;
                    }
                    

                    
                    [commentGoodsDic setObject:goodesModel.commentStr forKey:@"commentContent"];
                    [commentGoodsDic setObject:imgStr forKey:@"commentPic"];
                    [commentGoodsDic setObject:dic[@"commentTypeId"] forKey:@"commentTypeId"];
                    [commentGoodsDic setObject:dic[@"id"] forKey:@"id"];
                }
            }

        }
        
              [commentArr addObject:commentGoodsDic];
    }
    
    [commentJsonDic setObject:commentArr forKey:@"commentJson"];
    NSString*commentJsonStr = [[Tool tools]jsonWithDictionary:commentJsonDic];

    if (i==0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请填写评论内容！"];
        return;
    }
    
    NSDictionary *dic = @{@"receiptId":_orderModel.ID,
                          @"commentJson":commentJsonStr,
                          };
    
    [HttpRequestManager postAddGoodsCommentRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
        if([data[@"code"] intValue] == 200) {
            
            _callback();
        };
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return _tableViewDataArray.count;
    
//    return 3;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GoodsModel *model = _tableViewDataArray[indexPath.row];
    static NSString *cellid = @"GoodsCommentCell";
    GoodsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell = [[GoodsCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid InspectModel:model IndexPath:indexPath VC:self ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCallback:^{
        [self.tableView reloadData];
    }];
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
    return 350-(100-(KHScreenW-6*10)/5);
}



#pragma mark buttonAction

@end
