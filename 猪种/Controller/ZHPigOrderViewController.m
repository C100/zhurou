//
//  ZHPigOrderViewController.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigOrderViewController.h"
#import "ZHPigOrderUserInfoTableCell.h"
#import "ZHPigOrderAddressTableCell.h"
#import "ZHPigOrderGoodsTableCell.h"
#import "ZHScreenAdaptation.h"
#import "AddressModel.h"
#import "AddressManagerVC.h"
#import "creatAddressVC.h"
#import "ZHPigNetwork.h"
#import "ZHPigOrderModel.h"
#import "ZHPigBuyModel.h"
#import "ZHPigMyOrderViewController.h"
#import "ZHPigOrderInvoiceTableCell.h"
#import "Pingpp.h"
#import "OrderDetail2VC.h"
#import "ZHPigPayModel.h"
#import "MBProgressHUD.h"
#import "MyPigViewController.h"

@interface ZHPigOrderViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UILabel *labelTotalPrice;

@property (nonatomic, copy) NSArray *addressModels;
@property (nonatomic, strong) AddressModel *addressModel;

@property (nonatomic, strong) ZHPigBuyModel *pigBuyModel;
@property (nonatomic, strong) ZHPigOrderModel *pigOrderModel;

@property (nonatomic, copy) NSString *invoiceString;
@property (nonatomic, copy) NSString *invoiceStringForUpload;
@property (nonatomic, strong) NSDictionary *invoiceDict;
@property (nonatomic, strong) ZHPigPayModel *payModel;

@end

@implementation ZHPigOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单填写";

    self.pigBuyModel = [UIApplication appDelegate].pigBuyModel;

    self.labelTotalPrice.text = [NSString stringWithFormat:@"%.2f", self.pigBuyModel.buyCount * self.pigBuyModel.pigPrice];

    [self loadOrderInfo];
    [self loadAddressModel];

    //设置导航栏的按钮
    UIBarButtonItem *backButton = [UIBarButtonItem itemWithImageName:@"NavbackView" highImageName:@"NavbackView" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network
- (void)loadOrderInfo {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [[[ZHPigNetwork alloc] init] getOrderInfoWithGoodsId:self.pigBuyModel.giftId callback:^(BOOL status, NSString *message, id obj, NSString *code) {
        [hud hideAnimated:YES];
        if (status) {
            self.pigOrderModel = obj;
            [self.tableView reloadData];
        } else {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:message];
        }
    }];
}

- (void)loadAddressModel {
    [HttpRequestManager postGetAddressRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *dataArr) {
        self.addressModels = dataArr;
        if (self.addressModels.count > 0) {
            [self.addressModels enumerateObjectsUsingBlock:^(AddressModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.isSelect) {
                    self.addressModel = obj;
                    *stop = YES;
                }
            }];
        } else {
            self.addressModel = nil;
        }
        [self.tableView reloadData];
    }];
}

- (void)uploadOrderWithPayType:(NSNumber *)payType {
    
    if (!self.pigBuyModel) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"没有认购猪种数据"];
        });
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [[[ZHPigNetwork alloc] init] uploadOrderPigBuyModel:self.pigBuyModel addressModel:self.addressModel invoice:self.invoiceStringForUpload payType:payType callback:^(BOOL status, NSString *message, id obj, NSString *code) {
        [hud hideAnimated:YES];
        if (status) {
            self.payModel = obj;
            [self goToPay];
        } else {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:message];
        }
    }];
}

- (void)goToPay {
    [Pingpp createPayment:self.payModel.payCharge viewController:self appURLScheme:@"wx423f76b92edd0590" withCompletion:^(NSString *result, PingppError *error) {
        if ([result isEqualToString:@"success"]) {
            [[[ZHPigNetwork alloc] init] paySucceededWithOrderId:self.payModel.orderId callback:nil];
            [[MyAlert manage] paysuccessAlert:YES time:self.payModel.startTime price:self.payModel.totalPrice finsh:^(NSString *str) {
                if ([str isEqualToString:@"1"]) {
                    [self.navigationController pushViewController:[[MyPigViewController alloc] init] animated:YES];
                } else if([str isEqualToString:@"2"]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        } else {
            if ([result isEqualToString:@"cancel"]) {
                [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"用户取消支付"];
            } else {
                [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"支付失败"];
            }
            ZHPigMyOrderViewController *myOrderViewController = [[UIStoryboard storyboardWithName:@"ZHPig" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(ZHPigMyOrderViewController.class)];
            [self.navigationController pushViewController:myOrderViewController animated:YES];
        }

    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"";
    if (indexPath.row == 0) {
        cellIdentifier = @"ZHPigOrderUserInfoTableCell";
        ZHPigOrderUserInfoTableCell *userInfoTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [userInfoTableCell configureWithPigOrderModel:self.pigOrderModel];
        return userInfoTableCell;
    } else if (indexPath.row == 1) {
        cellIdentifier = @"ZHPigOrderAddressTableCell";
        ZHPigOrderAddressTableCell *addressTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [addressTableCell configureWithAddressModel:self.addressModel];
        return addressTableCell;
    } else if (indexPath.row == 4) {
        cellIdentifier = @"ZHPigOrderInvoiceTableCell";
        ZHPigOrderInvoiceTableCell *invoiceTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [invoiceTableCell configureWithInvoiceString:self.invoiceString];
        return invoiceTableCell;
    }
    cellIdentifier = @"ZHPigOrderGoodsTableCell";
    ZHPigOrderGoodsTableCell *goodsTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.row == 2) {
        [goodsTableCell configureWithPigBuyModel:self.pigBuyModel];
    } else {
        [goodsTableCell configureWithPigGiftModel:self.pigOrderModel.giftModel];
    }
    return goodsTableCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:43];
    } else if (indexPath.row == 1) {
        return [ZHPigOrderAddressTableCell heightWithAddressModel:self.addressModel];
    } else if (indexPath.row == 4) {
        return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:48];;
    }
    return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:116];;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        if (self.addressModels.count == 0) {
            creatAddressVC *vc = [[creatAddressVC alloc]init];
            [vc setCallback:^(AddressModel *model) {
                [self loadAddressModel];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            AddressManagerVC  *vc = [[AddressManagerVC alloc]init];
            vc.isOrder = YES;
            [vc setCallback:^(AddressModel *model) {
                self.addressModel = model;
                [self.tableView reloadData];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.row == 4) {
        MyAlert *alert = [MyAlert manage];
        NSString *title;
        NSNumber *type = self.invoiceDict[@"type"];
        if ([type integerValue] == 0) {
            title = @"个人";
        } else {
            title = @"公司";
        }
        [alert showBillInfoAlertView:title contentTsitle:self.invoiceDict[@"orderCheck"] andCode:self.invoiceDict[@"code"] andIsOnlyShow:NO finsh:^(NSArray *data) {
            self.invoiceDict = [[Tool tools] dictionaryWithJsonString:data.lastObject];
            if (data.count == 2) {
                self.invoiceString = data.firstObject;
                self.invoiceStringForUpload = data.lastObject;
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - IBAction
- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)confirmOrder:(id)sender {
    if (!self.addressModel) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请填写收货地址"];
        });
        return;
    }
    MyAlert *alert = [MyAlert manage];
    [alert payWaysAlert:^(NSString *str) {
        NSNumber *payType;
        if ([str isEqualToString:@"alipay"]) {
            payType = @(2);
        } else {
            payType = @(1);
        }
        [self uploadOrderWithPayType:payType];
    }];
}

@end
