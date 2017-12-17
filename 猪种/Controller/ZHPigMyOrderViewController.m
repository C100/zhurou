//
//  ZHPigMyOrderViewController.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigMyOrderViewController.h"
#import "ZHPigOrderGoodsTableCell.h"
#import "ZHScreenAdaptation.h"
#import "ZHPigMyOrderAddressTableCell.h"
#import "ZHPigNetwork.h"
#import "ZHPigMyOrderModel.h"
#import "ZHPigMyOrderIdTableCell.h"
#import "ZHPigMyOrderInvoiceTableCell.h"
#import "Pingpp.h"
#import "ZHPigPayModel.h"
#import "MBProgressHUD.h"

@interface ZHPigMyOrderViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UILabel *labelRemainTime;
@property (nonatomic, weak) IBOutlet UILabel *labelTotalPrice;

@property (nonatomic, weak) IBOutlet UIView *viewRemainTime;

@property (nonatomic, weak) IBOutlet UIButton *buttonCancelOrder;
@property (nonatomic, weak) IBOutlet UIButton *buttonPay;

@property (nonatomic, strong) ZHPigMyOrderModel *myOrderModel;

@property (nonatomic, strong) NSDictionary *invoiceDict;

@property (nonatomic, strong) ZHPigPayModel *payModel;

@property (nonatomic, assign) BOOL isOrderOvertime;

@end

@implementation ZHPigMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.titleText) {
        self.title = self.titleText;
    } else {
        self.title = @"未完成订单";
    }

    [self loadOrderInfo];

    //设置导航栏的按钮
    UIBarButtonItem *backButton = [UIBarButtonItem itemWithImageName:@"NavbackView" highImageName:@"NavbackView" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network
- (void)loadOrderInfo {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [[[ZHPigNetwork alloc] init] getOrderToBePaidWithCallback:^(BOOL status, NSString *message, id obj, NSString *code) {
        [hud hideAnimated:YES];
        if (status) {
            self.myOrderModel = obj;
            if (self.myOrderModel.invoice.length > 0) {
                self.invoiceDict = [[Tool tools] dictionaryWithJsonString:self.myOrderModel.invoice];
            }
            [self configureSubviews];
            [self.tableView reloadData];
        } else {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:message];
        }
    }];
}

- (void)payOrderWithPayType:(NSNumber *)payType {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [[[ZHPigNetwork alloc] init] payOrderToBePaidWithMyOrderModel:self.myOrderModel payType:payType callback:^(BOOL status, NSString *message, id obj, NSString *code) {
        [hud hideAnimated:YES];
        if (status) {
            self.payModel = obj;
            [self goToPay];
        } else {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:message];
        }
    }];
}



#pragma mark -
- (void)configureSubviews {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSInteger second = self.myOrderModel.overTime - timeInterval;
    if (second > 0) {
        [self startCountdownWithStartTime:second];
    } else {
        [self configureSubviewsAfterOrderOvertime];
    }

    self.labelTotalPrice.text = [NSString stringWithFormat:@"%@", self.myOrderModel.totalPrice];
}

- (void)configureSubviewsAfterOrderOvertime {
    self.labelRemainTime.text = @"订单超时";
    self.title = @"已关闭订单";
    [self.buttonCancelOrder setTitle:@"删除订单" forState:UIControlStateNormal];
    [self.buttonPay setTitle:@"重新选购" forState:UIControlStateNormal];
    self.isOrderOvertime = YES;
}

- (void)startCountdownWithStartTime:(NSInteger)startTime {
    NSDate *oldDate = [NSDate date];
    __block NSInteger countDownTime = startTime;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if (countDownTime <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self configureSubviewsAfterOrderOvertime];
            });
        } else {
            NSDate *newDate = [NSDate date];
            NSTimeInterval timeInterval = [newDate timeIntervalSinceDate:oldDate];
            int seconds = startTime - timeInterval;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self configureLabelRemainTimeWithTime:seconds];
            });
            if (seconds <= 1) {
                countDownTime = 1;
            }
            countDownTime --;
        }
    });
    dispatch_resume(timer);
}

- (void)configureLabelRemainTimeWithTime:(NSInteger)time {
    NSString *string = @"剩余时间：";
    NSString *timeString = [self getTimeStringWithTime:time];
    NSString *labelRemainTime = [NSString stringWithFormat:@"%@%@", string, timeString];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:labelRemainTime];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:182/255.0f green:37/255.0f blue:30/255.0f alpha:1.0] range:NSMakeRange(string.length, labelRemainTime.length - string.length)];
    self.labelRemainTime.attributedText = attributedText;
}

- (NSString *)getTimeStringWithTime:(NSInteger)time
{
    NSInteger minutes = time/60;
    NSInteger second = time%60;

    NSString *secondString = [NSString stringWithFormat:@"%@", @(second)];
    if (secondString.length < 2) {
        secondString = [NSString stringWithFormat:@"0%@", secondString];
    }
    NSString *minuteString = [NSString stringWithFormat:@"%@", @(minutes)];
    if (minuteString.length < 2) {
        minuteString = [NSString stringWithFormat:@"%@", minuteString];
    }
    NSString *timeString = [NSString stringWithFormat:@"%@：%@", minuteString, secondString];
    return timeString;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.myOrderModel.invoice.length > 0) {
        return 5;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"";
    if (indexPath.row == 0) {
        cellIdentifier = @"ZHPigMyOrderAddressTableCell";
        ZHPigMyOrderAddressTableCell *addressTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [addressTableCell configureWithMyOrderModel:self.myOrderModel];
        return addressTableCell;
    } else if (indexPath.row == 3) {
        cellIdentifier = @"ZHPigMyOrderIdTableCell";
        ZHPigMyOrderIdTableCell *orderIdTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [orderIdTableCell configureWithOrderId:self.myOrderModel.orderNumber];
        return orderIdTableCell;
    } else if (indexPath.row == 4) {
        cellIdentifier = @"ZHPigMyOrderInvoiceTableCell";
        ZHPigMyOrderInvoiceTableCell *invoiceTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [invoiceTableCell configureWithInvoiceDict:self.invoiceDict];
        return invoiceTableCell;
    }
    cellIdentifier = @"ZHPigOrderGoodsTableCell";
    ZHPigOrderGoodsTableCell *goodsTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.row == 1) {
        [goodsTableCell configureWithPigBuyModel:self.myOrderModel.buyModel];
    } else if (indexPath.row == 2) {
        [goodsTableCell configureWithPigGiftModel:self.myOrderModel.giftModel];
    }
    return goodsTableCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [ZHPigMyOrderAddressTableCell heightWithMyOrderModel:self.myOrderModel];
    } else if (indexPath.row == 3) {
        return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:47];;
    } else if (indexPath.row == 4) {
        return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:37];;
    }
    return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:116];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        MyAlert *alert = [MyAlert manage];
        NSNumber *invoiceType = self.invoiceDict[@"type"];
        NSString *title;
        if ([invoiceType integerValue] == 0) {
            title = @"个人";
        } else {
            title = @"公司";
        }
        [alert showBillInfoAlertView:title contentTsitle:self.invoiceDict[@"orderCheck"] andCode:self.invoiceDict[@"code"] andIsOnlyShow:YES finsh:^(NSArray *data) {
            
        }];
    }
}

#pragma mark - IBAction
- (IBAction)cancelOrder:(id)sender {
    if (self.isOrderOvertime) {
        [self deleteOrder];
    } else {
        [self cancelOrder];
    }
}

- (void)deleteOrder {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [[[ZHPigNetwork alloc] init] deleteOrderWithOrderId:self.myOrderModel.orderId callback:^(BOOL status, NSString *message, id obj, NSString *code) {
        [hud hideAnimated:YES];
        if (status) {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"订单删除成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"订单删除失败"];
        }
    }];
}

- (void)cancelOrder {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [[[ZHPigNetwork alloc] init] cancelOrderWithOrderId:self.myOrderModel.orderId callback:^(BOOL status, NSString *message, id obj, NSString *code) {
        [hud hideAnimated:YES];
        if (status) {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"订单取消成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"订单取消失败"];
        }
    }];
}

- (IBAction)pay:(id)sender {
    if (self.isOrderOvertime) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        MyAlert *alert = [MyAlert manage];
        [alert payWaysAlert:^(NSString *str) {
            NSNumber *payType;
            if ([str isEqualToString:@"alipay"]) {
                payType = @(2);
            } else {
                payType = @(1);
            }
            [self payOrderWithPayType:payType];
        }];
    }
}

- (void)goToPay {
    [Pingpp createPayment:self.payModel.payCharge viewController:self appURLScheme:@"wx423f76b92edd0590" withCompletion:^(NSString *result, PingppError *error) {
        if ([result isEqualToString:@"success"]) {
            [[[ZHPigNetwork alloc] init] paySucceededWithOrderId:self.payModel.orderId callback:nil];
            [[MyAlert manage] paysuccessAlert:YES time:self.payModel.startTime price:self.payModel.totalPrice finsh:^(NSString *str) {
                if (self.isPushedFromMyPig) {
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        } else if ([result isEqualToString:@"cancel"]) {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"用户取消支付"];
        } else {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"支付失败"];
        }
    }];
}

- (void)back {
    if (self.isPushedFromMyPig) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
