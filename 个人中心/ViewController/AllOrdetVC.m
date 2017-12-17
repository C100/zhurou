//
//  AllOrdetVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "AllOrdetVC.h"
#import "OrderModel.h"
#import "OrderCell.h"
#import "GoodsModel.h"
#import "AddressModel.h"
#import "FeedbackVC.h"
#import "GoodsCommentVC.h"
#import "OrderDetailVC.h"
#import "PayWebViewController.h"
#import "logisticsInfoViewController.h"
#import "OrderDetail2VC.h"
@interface AllOrdetVC ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation AllOrdetVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataModel:) name:@"orderAllReloadData" object:nil];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"地址管理";
    
    
    [self configUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareData];
}
#pragma mark intviewcontroller



-(void)reloadDataModel:(NSNotification *)text
{
    NSDictionary *dataDic =  text.object;
    _tableViewDataArray = [[NSMutableArray alloc]init];
    
    NSArray *dataArr = dataDic[@"allReceipt"];
    
    for (int i = 0; i < dataArr.count; i++) {
        
        NSDictionary *goodsDic = dataArr[i];
        
        OrderModel *model = [[OrderModel alloc]init];
        model.time = [NSDate dateStrFromCstampTime:[goodsDic[@"createTime"] intValue] withDateFormat:@"YYYY-MM-dd"];
        model.timeint = goodsDic[@"createTime"] ;
        model.payDic = [goodsDic mutableCopy];
        model.addressId  =  goodsDic[@"receiptAddressId"];
        model.ID = goodsDic[@"id"];
        model.companyNo = goodsDic[@"companyNo"];
        model.waybillNumber = goodsDic[@"waybillNumber"];
        NSDictionary *payMsgDic = [[Tool tools] dictionaryWithJsonString:goodsDic[@"payJson"]];
        NSArray *payMsgArr = payMsgDic[@"payMsg"];
        
        for (int j = 0; j < payMsgArr.count; j++) {
            NSDictionary *goodsDic = payMsgArr[j];
            GoodsModel *tempModel = [[GoodsModel alloc]init];
            tempModel.imgUrl = goodsDic[@"goodsSmallUrl"];
            tempModel.colorName = goodsDic[@"colorName"];
            tempModel.title =  goodsDic[@"goodsName"];
            tempModel.color =  goodsDic[@"goodsColor"];
            tempModel.type = goodsDic[@"goodsStyle"];
            tempModel.goodsId = goodsDic[@"goodsId"];
            tempModel.detailId = goodsDic[@"goodsColorStyleId"];
            tempModel.price = [Tool priceChange:goodsDic[@"price"]];
            tempModel.scalePrice = [Tool priceChange:goodsDic[@"price"]];
            tempModel.number =  goodsDic[@"goodsAmount"];

            
            CGFloat tempPrice = ([tempModel.price floatValue] * 100)/[tempModel.number floatValue];
            tempModel.scalePrice = [[NSString alloc]initWithFormat:@"%0.2f",tempPrice * 0.01];
            tempModel.price = [[NSString alloc]initWithFormat:@"%0.2f",tempPrice * 0.01];

            [model.goodsArr addObject:tempModel];
        }
        
        
        
      
        
        
        if ([goodsDic [@"showStatus"] intValue] == 1) {
            model.type = @"待付款";
        }else if ([goodsDic [@"showStatus"] intValue] == 2) {
            model.type = @"待发货";
        }else if ([goodsDic [@"showStatus"] intValue] == 4) {
            model.type = @"待评价";
        }else if ([goodsDic [@"showStatus"] intValue] == 5)
        {
            model.type = @"已完成";
        }else if ([goodsDic [@"showStatus"] intValue] == 6){
            model.type = @"待收货";
        }
        
        if (model.type) {
            [_tableViewDataArray addObject:model];
        }
    }
    
    
    
    
    
//    NSArray *array = [_tableViewDataArray  sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        //给对象排序
//        NSComparisonResult result = [obj1 compareParkInfo:obj2];
//        return result;
//    }];
//    _tableViewDataArray = [[NSMutableArray alloc]initWithArray:array];
    
    [self changeArrayByArray:_tableViewDataArray];

    
    [self.tableView reloadData];
}

//排序
-(void)changeArrayByArray:(NSMutableArray *)array
{
    
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        OrderModel *a = (OrderModel *)obj1;
        OrderModel *b = (OrderModel *)obj2;
        
        int aNum = [a.timeint intValue];
        int bNum = [b.timeint intValue];
        
        if (aNum > bNum) {
            return NSOrderedAscending;
        }
        else if (aNum < bNum){
            return NSOrderedDescending;
        }
        else {
            return NSOrderedSame;
        }
    }];
}


-(void)prepareData
{
  
}

-(void)configUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64-40) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
}

#pragma mark buttonAction

-(void)payAction:(UIButton *)btn
{
    __weak __typeof(self)weakSelf = self;
    OrderModel *model = weakSelf.tableViewDataArray[btn.tag - 100];
    //选择哪种支付方式
    [[MyAlert manage] payWaysAlert:^(NSString *str) {
        
        NSDictionary *dic = @{@"receiptId":model.ID,
                              @"payMethod":str
                              };

        [HttpRequestManager postOrderRepayRequest:dic viewcontroller:weakSelf finishBlock:^(NSDictionary *data) {
            if (data[@"pk"]) {
                PayWebViewController *vc = [[PayWebViewController alloc]init];
                vc.isFirst = @"first";
                vc.html = data[@"pk"];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }];
    }];
    
    

    
}

-(void)deletAction:(UIButton *)btn
{
    OrderModel *model = _tableViewDataArray[btn.tag - 10];
    
    __weak __typeof(self)weakSelf = self;
    [[MyAlert manage] showBtnAlertWithTitle:@"提醒" detailTitle:@"是否删除订单？" confirm:^{
        NSDictionary *dic = @{@"receiptId":model.ID,
                              };
        
        [HttpRequestManager postOrderDeletRequest:dic viewcontroller:weakSelf finishBlock:^(NSDictionary *data) {
            
        }];
    }];
    
    
    
    
}

-(void)confirmAction:(UIButton *)btn
{
    __weak __typeof(self)weakSelf = self;
    OrderModel *model = weakSelf.tableViewDataArray[btn.tag - 1000];
    [[MyAlert manage] showBtnAlertWithTitle:@"提醒" detailTitle:@"是否确认收货？" confirm:^{
        
        
        NSDictionary *dic = @{@"receiptId":model.ID,
                              };
        
        [HttpRequestManager postOrderSouhuoRequest:dic viewcontroller:weakSelf finishBlock:^(NSDictionary *data) {
            
        }];
    }];
    
}
-(void)pingrunAction:(UIButton *)btn
{
    
    OrderModel *model = _tableViewDataArray[btn.tag - 10000];
    NSDictionary *dic = @{@"receiptId":model.ID,
                          };
    __weak __typeof(self)weakSelf = self;
    [HttpRequestManager postOrderCommentListRequest:dic viewcontroller:weakSelf finishBlock:^(NSDictionary *data) {
        NSArray *arr = data[@"info"];
        
        GoodsCommentVC *vc = [[GoodsCommentVC alloc]init];
        vc.orderModel = model;
        [vc setCallback:^{
            weakSelf.callback();
        }];
        vc.pinglunListArr = arr;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

-(void)payAgain:(UIButton *)btn
{
    
    OrderModel *model = _tableViewDataArray[btn.tag - 100000];

    OrderDetailModel *orderDetailModel = [[OrderDetailModel alloc]init];
    orderDetailModel.goodsArr = model.goodsArr ;
    OrderDetailVC *vc = [[OrderDetailVC alloc]init];
    vc.model = orderDetailModel;
    [self.navigationController pushViewController:vc animated:YES];
    

    
}

-(void)logisticsInfo:(UIButton *)sender{
    //查看物流信息
    logisticsInfoViewController *vc = [[logisticsInfoViewController alloc]init];
    vc.orderModel = _tableViewDataArray[sender.tag-1000000];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderModel *model = _tableViewDataArray[indexPath.row];
    OrderCell* cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderCell" InspectModel:model IndexPath:indexPath];
    cell.model = model;
    cell.delectBtn.tag = 10 + indexPath.row;
    cell.payBtn.tag = 100 + indexPath.row;
    cell.confirmBtn.tag = 1000 + indexPath.row;
    cell.reviewBtn.tag = 10000 + indexPath.row;
    cell.buyAgainBtn.tag = 100000 + indexPath.row;
    cell.logisticsButton.tag = 1000000+indexPath.row;

    [cell.payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delectBtn addTarget:self action:@selector(deletAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.reviewBtn addTarget:self action:@selector(pingrunAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.buyAgainBtn addTarget:self action:@selector(payAgain:) forControlEvents:UIControlEventTouchUpInside];
    [cell.logisticsButton addTarget:self action:@selector(logisticsInfo:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    OrderModel *model = _tableViewDataArray[indexPath.row];
    
    
    OrderDetailModel *orderDetailModel = [[OrderDetailModel alloc]init];
    orderDetailModel.goodsArr = model.goodsArr ;
    OrderDetail2VC *vc = [[OrderDetail2VC alloc]init];
    vc.model = orderDetailModel;
    vc.orderId = model.ID;
    vc.type = model.type;
    vc.allordervc = self;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
    OrderModel *model = _tableViewDataArray[indexPath.row];
    return 156 + (model.goodsArr.count -1) * 70;
}








@end
