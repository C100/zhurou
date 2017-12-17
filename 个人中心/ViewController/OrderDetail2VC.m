//
//  OrderDetail2VC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/17.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "OrderDetail2VC.h"
#import "OrderDetailModel.h"
#import "OrderDetailCell2.h"
#import "AddressModel.h"
#import "GoodsModel.h"
#import "ShoppingCarUnderView.h"
#import "AddressManagerVC.h"
#import "MyCouponsVC.h"
#import "TextViewVC.h"
#import "GoodsCommentVC.h"
#import "OrderDetailVC.h"
#import "PayWebViewController.h"
#import "BackProductApplyViewController.h"
#import "logisticsInfoViewController.h"
#import "MyAlert.h"
#import "BackProductInfoViewController.h"

@interface OrderDetail2VC ()<UITableViewDelegate,UITableViewDataSource,OrderDetailCell2Delegate>
{
    ShoppingCarUnderView *_underView;
    GoodsModel *_operateGoodsModel;
    UIButton *_backMoneyButton;
    UIButton *_backProButton;
    CGFloat _allPrice;
    CGFloat _discountPrice;
    
}

@end

@implementation OrderDetail2VC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSDictionary *dic = @{@"receiptId":_orderId,
                          };
    
    [HttpRequestManager postOrderDetilInfoRequest:dic viewcontroller:self finishBlock:^(OrderDetailModel *model) {
        _model = model;
        
//        _model.type = _type;
        CGFloat allPrice = 0;
        for (int i = 0; i < _model.goodsArr.count; i++) {
            GoodsModel *goodsModel = _model.goodsArr[i];
            allPrice = [goodsModel.scalePrice floatValue] * [goodsModel.number floatValue] + allPrice;
        }
        
        _allPrice = allPrice;
        allPrice = allPrice - [model.coupons floatValue] * 0.01;
        if (model.discount) {
            NSString *discount = [model.discount componentsSeparatedByString:@"$"].lastObject;
            allPrice -= discount.floatValue;
        }
        

        NSString *btnString = @"确定";
        
        if ([_model.type isEqualToString:@"待付款"]) {
            btnString = @"付款";
        }else if ([_model.type isEqualToString:@"待收货"])
        {
            btnString = @"确认收货";

        }else if ([_model.type isEqualToString:@"待评价"])
        {
            btnString = @"评价";

        }else if ([_model.type isEqualToString:@"已完成"])
        {
            btnString = @"再次购买";

        }else if ([_model.type isEqualToString:@"待发货"])
        {
            btnString = @"等待卖家发货";
            
        }

//        [_underView configview2withpriceTitle:@"实付款：" priceTitle:[[NSString alloc]initWithFormat:@"%0.2f",allPrice ] btnTitle:btnString];
//        [_underView.btn1 addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        
        _discountPrice = allPrice;
        [_underView configview3withpriceTitle:@"实付款：" priceTitle:[[NSString alloc]initWithFormat:@"%0.2f",allPrice] btnTitle:btnString];
        [_underView.btn1 setTitle:btnString forState:UIControlStateNormal];
        [_underView.btn1 addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        
        if ([_model.type isEqualToString:@"待付款"]) {
            _underView.btn2.hidden = NO;
            [_underView.btn2 setTitle:@"删除" forState:UIControlStateNormal];
        }else if ([_model.type isEqualToString:@"待收货"])
        {
            _underView.btn2.hidden = NO;
            [_underView.btn2 setTitle:@"查看物流" forState:UIControlStateNormal];
        }else if ([_model.type isEqualToString:@"待评价"])
        {
            _underView.btn2.hidden = YES;
            
        }else if ([_model.type isEqualToString:@"已完成"])
        {
            _underView.btn2.hidden = YES;
            
        }else if ([_model.type isEqualToString:@"待发货"])
        {
            _underView.btn2.hidden = YES;
        }
        [_underView.btn2 addTarget:self action:@selector(otherOperate:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self.tableView reloadData];
    }];
    
}

//查看物流
-(void)otherOperate:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"删除"]) {
        //删除
        [[MyAlert manage] showBtnAlertWithTitle:@"提醒" detailTitle:@"是否删除订单？" confirm:^{
            NSDictionary *dic = @{@"receiptId":_model.receiptId,
                                  };
            
            [HttpRequestManager postOrderDeletRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
                //删除订单成功
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }];
    }else{
        logisticsInfoViewController *vc = [[logisticsInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)configUI
{
    self.view.backgroundColor = The_list_backgroundColor;
    self.title = @"订单详情";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64 - 50) style:UITableViewStylePlain];
    self.tableView.backgroundColor = The_list_backgroundColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //    [self.tableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    self.tableView.estimatedRowHeight = 60;
    
    _underView = [[ShoppingCarUnderView alloc]init];
    _underView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_underView];
    [self.view bringSubviewToFront:_underView];
    
    [_underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(@50);
    }];
    
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;
    
    //设置导航栏的按钮
    UIBarButtonItem *backButton = [UIBarButtonItem itemWithImageName:@"NavbackView" highImageName:@"NavbackView" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
    
    // 就有滑动返回功能
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;

    
}

#pragma mark buttonAction


- (void)back {
    if (_ispay) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
  
    }
    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//确认按钮分配事件

-(void)confirmAction
{
    if ([_type isEqualToString:@"待付款"]) {
        [self payAction];
    }else if ([_type isEqualToString:@"待收货"])
    {
        [self souhuoAction];
    }else if ([_type isEqualToString:@"待评价"])
    {
        [self pingrunAction];
    }else if ([_type isEqualToString:@"已完成"])
    {
        
        [self payAgain];
//        btnString = @"再次购买";
        
    }

}


-(void)payAction
{
    [[MyAlert manage]payWaysAlert:^(NSString *str) {
        NSDictionary *dic = @{@"receiptId":_model.receiptId,
                              @"payMethod":str
                                  };
        
        [HttpRequestManager postOrderRepayRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            if (data) {
                if (data[@"pk"]) {
                    PayWebViewController *vc = [[PayWebViewController alloc]init];
                    vc.isFirst = @"first";
                    vc.html = data[@"pk"];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    _type = @"待收货";
                    _model.type = @"待收货";
                    [_underView.btn1 setTitle:@"确认收货" forState:UIControlStateNormal];
                    [self.tableView reloadData];
                    
                    self.allordervc.callback();
                }
                
                
            }
            
            
            
        }];
        
    }];
    
    
}


-(void)souhuoAction
{
    
    
    [[MyAlert manage] showBtnAlertWithTitle:@"提醒" detailTitle:@"是否确认收货？" confirm:^{
        
        NSDictionary *dic = @{@"receiptId":_model.receiptId,
                              };
        
        [HttpRequestManager postOrderSouhuoRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            //        self.allordervc.callback();
            _type = @"待评价";
            
            _model.type = @"待评价";
            [_underView.btn1 setTitle:@"评价" forState:UIControlStateNormal];
            [self.tableView reloadData];
            
            if (!self.ispay) {
                self.allordervc.callback();
                
            }
            
        }];

    }];
    
}
-(void)pingrunAction
{
//    NSDictionary *dic = @{@"receiptId":_model.receiptId,
//                          };
//    
//    [HttpRequestManager postOrderCommentListRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
////        self.allordervc.callback();
//
//    }];
    
    NSDictionary *dic = @{@"receiptId":_model.receiptId,
                          };
    

    
    [HttpRequestManager postOrderCommentListRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
        NSArray *arr = data[@"info"];
        
        
        OrderModel *ordermodel = [[OrderModel alloc]init];
        ordermodel.ID = _model.receiptId;
        ordermodel.goodsArr = _model.goodsArr;
        ordermodel.time = _model.timeStr;
        
        GoodsCommentVC *vc = [[GoodsCommentVC alloc]init];
        
        [vc setCallback:^{
            _type = @"已完成";

            _model.type = @"已完成";
            [_underView.btn1 setTitle:@"再次购买" forState:UIControlStateNormal];
            [self.tableView reloadData];
            
            self.allordervc.callback();
        }];
        vc.orderModel = ordermodel;
        vc.pinglunListArr = arr;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    
}


-(void)payAgain
{
    
    
    OrderDetailModel *orderDetailModel = [[OrderDetailModel alloc]init];
    orderDetailModel.goodsArr = _model.goodsArr ;
    OrderDetailVC *vc = [[OrderDetailVC alloc]init];
    vc.model = orderDetailModel;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

-(void)backAction:(UIButton *)sender{
    if (sender.selected == NO) {
        sender.selected = !sender.selected;
    }
    
    if (sender.tag==200) {
        _backProButton.selected = NO;
    }else{
        _backMoneyButton.selected = NO;
    }
}

-(void)applyForWithTag:(NSInteger)tag andTitle:(NSString *)title{
    NSInteger index = tag;
    _operateGoodsModel = _model.goodsArr[index];
    
    CGFloat singleProPrice = [_operateGoodsModel.scalePrice floatValue]*_operateGoodsModel.number.intValue;
    CGFloat actualPrice = singleProPrice-((_allPrice-_discountPrice)/_allPrice*singleProPrice);
    
    if ([title isEqualToString:@"申请退款"]) {
        BackProductApplyViewController *vc = [[BackProductApplyViewController alloc]init];
        vc.goodsModel = _operateGoodsModel;
        vc.orderDetailModel = _model;
        vc.type = @(1);
        vc.backAllPrice = actualPrice;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择服务类型" message:@"\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
        
        NSArray *arr = @[@"退货退款",@"换货"];
        for (int i = 0; i<2; i++) {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 65+(1+40)*i, 300, 41)];
            bgView.userInteractionEnabled = YES;
            bgView.backgroundColor = [UIColor clearColor];
            [alert.view addSubview:bgView];
            UIButton *chooseButton = [Tool buttonWithTitle:arr[i] titleColor:k666666Color font:14 imageName:nil target:self action:@selector(backAction:)];
            [bgView addSubview:chooseButton];
            [chooseButton setTitleColor:The_MainColor forState:UIControlStateSelected];
            chooseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            chooseButton.frame = CGRectMake(15, 10, 80, 20);
            chooseButton.tag = 200+i;
            if (i==0) {
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(chooseButton.frame)+10, alert.view.bounds.size.width, 1)];
                [bgView addSubview:lineView];
                lineView.backgroundColor = kDDDDDDColor;
                _backMoneyButton = chooseButton;
                chooseButton.selected = YES;
            }else{
                _backProButton = chooseButton;
                chooseButton.selected = NO;
            }
        }
        
        
        alert.view.layer.masksToBounds = YES;
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            BackProductApplyViewController *vc = [[BackProductApplyViewController alloc]init];
            vc.goodsModel = _operateGoodsModel;
            vc.orderDetailModel = _model;
            if (_backMoneyButton.selected) {
                vc.type = @(1);
            }else{
                vc.type = @(2);
            }
            vc.backAllPrice = actualPrice;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [alert addAction:a1];
        [alert addAction:a2];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark --tableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        if (_model.refundOrExchangeStatusNum.intValue==0||_model.refundOrExchangeStatusNum==nil) {//不存在退换货
            return 6;
        }
        return 7;
    }
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"OrderDetailCell";
    OrderDetailCell2 *cell  = [[OrderDetailCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid InspectModel:_model IndexPath:indexPath VC:self];
    cell.orderDetailCell2Delegate = self;
    if (indexPath.row==6) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
//    [cell.couponsBtn addTarget:self action:@selector(youhuiquanAction) forControlEvents:UIControlEventTouchUpInside];
//    [cell.billInfoBtn addTarget:self action:@selector(fapiaoInfoAction) forControlEvents:UIControlEventTouchUpInside];
//    [cell.remarkBtn addTarget:self action:@selector(remarkAction) forControlEvents:UIControlEventTouchUpInside];
//    [cell.detailBackButton addTarget:self action:@selector(detailBackAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2&&indexPath.row==4) {//发票信息
        MyAlert *alert = [MyAlert manage];
        
        NSDictionary *fapiaoDic = [[Tool tools]dictionaryWithJsonString:_model.billInfo];
        if (fapiaoDic) {
            NSNumber *type = fapiaoDic[@"type"];
            if (type.intValue==0) {//个人
//                fapiaoStr = [NSString stringWithFormat:@"个人 %@",fapiaoDic[@"orderCheck"]];
                [alert showBillInfoAlertView:@"个人" contentTsitle:fapiaoDic[@"orderCheck"] andCode:nil andIsOnlyShow:YES finsh:^(NSArray *data) {
                    
                }];
            }else{
//                fapiaoStr = [NSString stringWithFormat:@"公司 %@ %@",fapiaoDic[@"orderCheck"],fapiaoDic[@"code"]];
                [alert showBillInfoAlertView:@"公司" contentTsitle:fapiaoDic[@"orderCheck"] andCode:fapiaoDic[@"code"] andIsOnlyShow:YES finsh:^(NSArray *data) {
                    
                }];
            }
            
        }
        
        
        
        
    }
    if (indexPath.row==6) {
        //查看物流信息
        BackProductInfoViewController *vc = [[BackProductInfoViewController alloc]init];
        vc.backProModel = self.backProModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

//返回分区的脚的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 91;
    }else if (indexPath.section == 1)
    {
//        return _model.goodsArr.count * 70 + 35;
        return UITableViewAutomaticDimension;
    }
    
    return 38;
}

@end
