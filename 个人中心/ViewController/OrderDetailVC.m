//
//  OrderDetailVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/28.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderDetailModel.h"
#import "OrderDetailCell.h"
#import "AddressModel.h"
#import "GoodsModel.h"
#import "ShoppingCarUnderView.h"
#import "AddressManagerVC.h"
#import "MyCouponsVC.h"
#import "TextViewVC.h"
#import "PayWebViewController.h"
#import "OrderDetailVC.h"

@interface OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    ShoppingCarUnderView *_underView;
    CGFloat _orderPrice;
    NSString *_fapiaoJson;
    NSString *_payWay;
    BOOL _isClickTableView;
    NSNumber *_xinyongeduPrice;
    CGFloat _priceActual;
    NSNumber *_yuePrice;
}

@end

@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self prepareData];
    [self getReceiptInfo];
    _isClickTableView = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

//检查银行卡号
- (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1]intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

#pragma mark intviewcontroller
-(void)getReceiptInfo{
    CGFloat allPrice = 0;
    for (int i = 0; i < _model.goodsArr.count; i++) {
        GoodsModel *goodsModel = _model.goodsArr[i];
        allPrice = [goodsModel.scalePrice floatValue] * [goodsModel.number floatValue] + allPrice;
    }
    
    
    NSString *allPriceStr = [NSString stringWithFormat:@"%.0f",allPrice*100];
    [HttpRequestManager getReceiptInfoWithReceiptId:nil andInitiaMoney:@(allPriceStr.intValue) andFinishBlock:^(NSDictionary *dataDic) {
        if (dataDic) {
            //下单时需要传的满减
            _model.discountJson = [[Tool tools]jsonWithDictionary:dataDic];
            NSNumber *discountFactor = dataDic[@"discountFactor"];
            NSNumber *initiaMoney = dataDic[@"initiaMoney"];
            NSNumber *favorableMoney = dataDic[@"favorableMoney"];
            NSString *discount = [NSString stringWithFormat:@"%.1f",discountFactor.floatValue];
            if ([discount isEqualToString:@"0.0"]) {
                _model.discount = nil;
            }else{
                _model.discount = [NSString stringWithFormat:@"%.1f折，减免¥%.2f",(100-discountFactor.intValue)/10.0,(initiaMoney.floatValue-favorableMoney.floatValue)/100];
            }
            
            
            _orderPrice = allPrice;
            [_underView configview3withpriceTitle:@"实付款：" priceTitle:[[NSString alloc]initWithFormat:@"%0.2f",favorableMoney.floatValue/100 ] btnTitle:@"确认"];
            //[_underView configview2withpriceTitle:@"实付款：" priceTitle:[[NSString alloc]initWithFormat:@"%0.2f",allPrice ] btnTitle:@"确定"];
            _priceActual = favorableMoney.floatValue/100;
            [_underView.btn1 addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            [self.tableView reloadData];
            
        }
    }];
}
-(void)prepareData
{
    [HttpRequestManager postGetAddressRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *dataArr) {
        
        AddressModel *defaultAddress = nil;
        for (AddressModel *addressMmodel in dataArr) {
            if (addressMmodel.isSelect) {
                defaultAddress =addressMmodel;
            }
        }
        _model.AddressModel = defaultAddress;
        [self.tableView reloadData];
        BXLog(@"%@",dataArr);
    }];
    
    //我的信用额度
    NSNumber *isOnNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"isAppInReviewNum"];
    if (isOnNum.intValue==0) {
        [HttpRequestManager getMyCreditWithFinishBlock:^(NSDictionary *dataDic) {
            if (dataDic) {
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
                NSNumber *moneyCount = dataDic[@"moneyCount"];
                _xinyongeduPrice = moneyCount;
//                cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2f",moneyCount.floatValue];
            }
        }];
        
        
        [HttpRequestManager postMyInfoRequest:nil viewcontroller:self finishBlock:^(NSDictionary *data) {
//         data[@"money"]
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
            NSNumber *moneyCount = data[@"money"];
            _yuePrice = moneyCount;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2f",moneyCount.floatValue];
        }];
    }
    

}

-(void)configUI
{
    self.view.backgroundColor = The_list_backgroundColor;
    self.title = @"订单填写";
    
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
//    CGFloat allPrice = 0;
//    for (int i = 0; i < _model.goodsArr.count; i++) {
//        GoodsModel *goodsModel = _model.goodsArr[i];
//        allPrice = [goodsModel.scalePrice floatValue] * [goodsModel.number floatValue] + allPrice;
//    }
//    _orderPrice = allPrice;
//    [_underView configview3withpriceTitle:@"实付款：" priceTitle:[[NSString alloc]initWithFormat:@"%0.2f",allPrice ] btnTitle:@"确认"];
//    //[_underView configview2withpriceTitle:@"实付款：" priceTitle:[[NSString alloc]initWithFormat:@"%0.2f",allPrice ] btnTitle:@"确定"];
//    [_underView.btn1 addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
        
}

#pragma mark buttonAction
-(void)confirmAction:(UIButton *)sender
{
    
    NSLog(@"确定");
    
    if (!_model.AddressModel) {
        [[MyAlert manage]showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请添加一个地址"];
        return;
    }

//    [HttpRequestManager payWithReceiptId:@(1623) andFinishBlock:^(NSString *data) {
//        PayWebViewController *vc = [[PayWebViewController alloc]init];
//        vc.isFirst = @"first";
//        vc.html = data;
//        [self.navigationController pushViewController:vc animated:YES];
//        
//        return ;
//    }];
    NSNumber *isOnNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"isAppInReviewNum"];
    if (isOnNum.intValue==1||sender==nil) {//审核中
        [[MyAlert manage] payWaysAlert:^(NSString *str) {
            
            //取消购物车的数量
            NSNotification * notice = [NSNotification notificationWithName:@"shoppingCarChange" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
            NSMutableArray *goodsArr = [[NSMutableArray alloc]init];
            for (int i = 0 ; i < _model.goodsArr.count; i++) {
                GoodsModel *goodModel = _model.goodsArr[i];
                NSDictionary *goodDic =@{@"goodsAmount":goodModel.number,
                                         @"goodsColor":goodModel.color,
                                         @"goodsId":goodModel.goodsId,
                                         @"goodsColorStyleId":goodModel.detailId,
                                         @"goodsStyle":goodModel.type,
                                         @"goodsName":goodModel.title,
                                         @"goodsSmallUrl":goodModel.imgUrl,
                                         @"colorName":goodModel.colorName,
                                         };
                [goodsArr addObject:goodDic];
            }
            
            NSDictionary *praramDic = @{@"payMsg":goodsArr,
                                        };
            NSString *jsonStr =  [ self dictionaryToJson:praramDic];
            
            if (_model.code==nil) {
                _model.code = @"";
            }
            
            if (jsonStr==nil) {
                jsonStr = @"";
            }
            if (_fapiaoJson == nil) {
                _fapiaoJson = @"";
            }
            
            //支付方式
            NSDictionary *dic = @{@"payMethod":str,
                                  @"receiptAddressId":_model.AddressModel.ID,
                                  @"voucherId":_model.couponsId,
                                  @"payMsg":jsonStr,
                                  @"memo":_model.remark,
                                  @"fapiao":_fapiaoJson,
                                  @"cartIds":_model.carIds,
                                  @"promotionCode":_model.code,
                                  @"moneyOffJson":_model.discountJson
                                  };
            
            
            [HttpRequestManager postPayRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
                if ([str isEqualToString:@"KQ_PAY"]) {
                    PayWebViewController *vc = [[PayWebViewController alloc]init];
                    vc.isFirst = @"first";
                    vc.html = data[@"pk"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
        }];
    }else{
        if (_payWay==nil) {
            [[MyAlert manage]showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请选择支付方式"];
            return;
        }else{
            
            [[MyAlert manage]showBtnAlertWithTitle:@"提醒" detailTitle:[NSString stringWithFormat:@"使用%@",_payWay] confirm:^{
                
                
                NSString *payMethod;
                if ([_payWay isEqualToString:@"信用额度支付"]) {
                    payMethod = @"XY_PAY";
                }else{
                    payMethod = @"YE_PAY";
                }
                
                
                //取消购物车的数量
                NSNotification * notice = [NSNotification notificationWithName:@"shoppingCarChange" object:nil userInfo:nil];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                NSMutableArray *goodsArr = [[NSMutableArray alloc]init];
                for (int i = 0 ; i < _model.goodsArr.count; i++) {
                    GoodsModel *goodModel = _model.goodsArr[i];
                    NSDictionary *goodDic =@{@"goodsAmount":goodModel.number,
                                             @"goodsColor":goodModel.color,
                                             @"goodsId":goodModel.goodsId,
                                             @"goodsColorStyleId":goodModel.detailId,
                                             @"goodsStyle":goodModel.type,
                                             @"goodsName":goodModel.title,
                                             @"goodsSmallUrl":goodModel.imgUrl,
                                             @"colorName":goodModel.colorName,
                                             };
                    [goodsArr addObject:goodDic];
                }
                
                NSDictionary *praramDic = @{@"payMsg":goodsArr,
                                            };
                NSString *jsonStr =  [ self dictionaryToJson:praramDic];
                
                if (_model.code==nil) {
                    _model.code = @"";
                }
                
                if (jsonStr==nil) {
                    jsonStr = @"";
                }
                if (_fapiaoJson == nil) {
                    _fapiaoJson = @"";
                }
                
                //支付方式
                NSDictionary *dic = @{@"payMethod":payMethod,
                                      @"receiptAddressId":_model.AddressModel.ID,
                                      @"voucherId":_model.couponsId,
                                      @"payMsg":jsonStr,
                                      @"memo":_model.remark,
                                      @"fapiao":_fapiaoJson,
                                      @"cartIds":_model.carIds,
                                      @"promotionCode":_model.code,
                                      @"moneyOffJson":_model.discountJson
                                      };
                
                
                [HttpRequestManager postPayRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
                    NSNumber *code = data[@"code"];
                    if (code.intValue == 200) {
                        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"支付成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                        //                    }];
                    }else{
                        NSString *message = data[@"msg"];
                        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:message];
                    }

                }];
                
            }];
            
            
            
        }
    }
    
    
    
    
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//优惠码
-(void)codeAction{
    [[MyAlert manage]showCodeInfoAlertView:@"" contentTsitle:@"" finsh:^(NSString *str) {
        _model.code = str;
        [self.tableView reloadData];
    }];
}

//优惠券
-(void)youhuiquanAction
{
    MyCouponsVC *vc = [[MyCouponsVC alloc]init];
    vc.isShopping = YES;
    vc.orderPrice = _orderPrice;
    [vc setCouponsCallBack:^(CouponsModel *model) {
        
        
        _model.coupons = [[NSString alloc]initWithFormat:@"-￥%0.2f",[model.price floatValue]];
        _model.couponsId = model.ID;

        
       
        CGFloat allPrice = 0;
        for (int i = 0; i < _model.goodsArr.count; i++) {
            GoodsModel *goodsModel = _model.goodsArr[i];
            allPrice = [goodsModel.scalePrice floatValue] * [goodsModel.number floatValue] + allPrice;
        }
        allPrice = allPrice - [model.price floatValue];
        if (_model.discount) {
            NSString *discount = [_model.discount componentsSeparatedByString:@"$"].lastObject;
            allPrice -= discount.floatValue;
        }
//

        _underView.priceLab.text = [[NSString alloc]initWithFormat:@"haha"];
        NSString *title = @"实付款：";
        NSString *price = [[NSString alloc]initWithFormat:@"%0.2f",allPrice];

        NSString *titleZongStr = [[NSString alloc]initWithFormat:@"%@￥%@",title,price ];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleZongStr];
//        [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,title.length)];
        
        
        
        [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,title.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(title.length, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:The_titleFont size:17] range:NSMakeRange(title.length+2, 3)];
        _underView.priceLab.attributedText = str;

        
        
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController: vc animated:YES];
}

//发票信息
-(void)fapiaoInfoAction
{
    
    
    NSString *title = @"";
    NSString *titleContent = @"";
    NSString *code = @"";
    
    NSRange gerenrange = [_model.billInfo rangeOfString:@"个人"];//查找子串，找不到返回NSNotFound 找到返回location和length
    
    if (gerenrange.location != NSNotFound) {
        
        
        title = @"个人";
        titleContent = [_model.billInfo substringFromIndex:3];
    }
    NSRange gongshirange = [_model.billInfo rangeOfString:@"公司"];//查找子串，找不到返回NSNotFound 找到返回location和length

    if (gongshirange.location != NSNotFound) {
        title = @"公司";
//        titleContent = [_model.billInfo substringFromIndex:3];
        NSDictionary *fapiaoDic = [[Tool tools]dictionaryWithJsonString:_fapiaoJson];
        titleContent = [NSString stringWithFormat:@"%@",fapiaoDic[@"orderCheck"]];
        code = fapiaoDic[@"code"];

    }
    
    
    
    [[MyAlert manage]showBillInfoAlertView:title contentTsitle:titleContent andCode:code andIsOnlyShow:NO finsh:^(NSArray *infos) {

//        NSString *callBackStr = str;
//        NSArray *infos = [callBackStr componentsSeparatedByString:@"#"];
        
        _model.billInfo =infos.firstObject;
        _fapiaoJson = infos.lastObject;
        
        [self.tableView reloadData];

    }];
    

}
//备注
-(void)remarkAction
{
    TextViewVC *vc = [[TextViewVC alloc]init];
    vc.VCTitle = @"备注";
    vc.contantTitle = _model.remark;
    [vc setCallback:^(NSString *str) {
        NSLog(@"%@",str);
        _model.remark = str;
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --tableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 5;
    }else if (section==3){
       NSNumber *isOnNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"isAppInReviewNum"];
        if (isOnNum.intValue==1) {//审核中
            return 1;
        }
        return 3;
    }
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0||indexPath.section==1||indexPath.section==2) {
        static NSString *cellid = @"OrderDetailCell";
        OrderDetailCell *cell  = [[OrderDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid InspectModel:_model IndexPath:indexPath VC:self];
        [cell.couponsBtn addTarget:self action:@selector(youhuiquanAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.billInfoBtn addTarget:self action:@selector(fapiaoInfoAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.remarkBtn addTarget:self action:@selector(remarkAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.codeButton addTarget:self action:@selector(codeAction) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSNumber *isOnNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"isAppInReviewNum"];
        NSArray *images = @[@"余额",@"信用额度支付",@"第三方支付"];
        NSArray *titles = @[@"余额支付",@"信用额度支付",@"第三方支付"];
        if (isOnNum.intValue==1) {//审核中
            images = @[@"第三方支付"];
            titles = @[@"第三方支付"];
        }
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
            cell.textLabel.textColor = k888888Color;
            cell.textLabel.font = kFont(14);
            cell.detailTextLabel.textColor = k333333Color;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
        cell.textLabel.text = titles[indexPath.row];
//        cell.detailTextLabel.text = @"0.00";
        if (indexPath.row==images.count-1) {
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"";
        }else{
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"勾选"]];
            cell.accessoryView = imageView;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AddressManagerVC *vc = [[AddressManagerVC alloc]init];
        vc.isOrder = YES;
        vc.selectedAddressModel = _model.AddressModel;
        vc.orderAdressId = _model.AddressModel.ID;
        [vc setCallback:^(AddressModel *model) {
            _model.AddressModel = model;//在地址管理中点击某个地址 / 删除的地址与该页地址不一致
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section==3) {
        //支付方式
        NSNumber *isOnNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"isAppInReviewNum"];
        if (isOnNum.intValue==1) {//审核中
            //弹弹框
            [self confirmAction:nil];
            return;
        }
        if (indexPath.row==0) {
            if (_yuePrice.floatValue<_priceActual) {
                [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"余额不足"];
                return;
            }
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
            UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"勾选"]];
            cell.accessoryView = iv;
            
            UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
            UIImageView *iv1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"勾"]];
            cell1.accessoryView = iv1;
            _payWay = @"余额支付";
        }else if (indexPath.row==1){
            
            if (_xinyongeduPrice.floatValue<_priceActual) {//不可用
                [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"信用额度余额不足"];
                return;
            }
            UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
            UIImageView *iv1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"勾"]];
            cell1.accessoryView = iv1;
            
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
            UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"勾选"]];
            cell.accessoryView = iv;
            
            
            _payWay = @"信用额度支付";
        }else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
            UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"勾选"]];
            cell.accessoryView = iv;
            
            UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
            UIImageView *iv1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"勾选"]];
            cell1.accessoryView = iv1;
            _payWay = nil;
            [self confirmAction:nil];

            
        }
    }
    
}
//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else if (section==3){
        return 35;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==3) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, 35)];
        bgView.backgroundColor = [UIColor clearColor];
        UILabel *titleLabel = [Tool labelWithTitle:@"选择支付方式" color:kCCCCCCColor fontSize:14 alignment:0];
        titleLabel.frame = CGRectMake(10, 11, KHScreenW-10, 14);
        [bgView addSubview:titleLabel];
        
        return bgView;
    }else{
        return nil;
    }
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
//        return _model.goodsArr.count * 70;
        return UITableViewAutomaticDimension;
    }
    
    return 38;
}


@end
