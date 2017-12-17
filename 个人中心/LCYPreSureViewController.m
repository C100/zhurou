//
//  LCYPreSureViewController.m
//  XiJuOBJ
//
//  Created by 刘岑颖 on 2017/12/16.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "LCYPreSureViewController.h"
#import "LCYPreSureView.h"

@interface LCYPreSureViewController ()

@property (nonatomic, strong) LCYPreSureView *sureView;

@property (nonatomic, strong) NSNumber *deliveryAmount;
@property (nonatomic, strong) NSNumber *confirm;
@property (nonatomic, strong) NSNumber *overString;

@end

@implementation LCYPreSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提前交割确认";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initInterface];
    [self getDataAction];
    
    [self.sureView.cancelButton addTarget:self action:@selector(cancelButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureView.sureButton addTarget:self action:@selector(sureButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getDataAction{
    
    NSString *string0 = [NSString stringWithFormat:@"%ld头",self.model.count.integerValue];
    
    NSString *string1 = [NSString stringWithFormat:@"%@/%@",self.model.term,self.model.saleLimit];
    
    NSString *string2 = [NSString stringWithFormat:@"%@/%@元",self.model.price,self.model.presentPrice];
    
    NSString *string3 = [NSString stringWithFormat:@"%@/%@元",self.model.totalPrice,self.model.presentTotalPrice];
    
    NSString *string4 = [NSString stringWithFormat:@"%.0f%%",self.model.proportion.floatValue * 100];
    
    NSString *string5 = [NSString stringWithFormat:@"%.0f%%", (1 - self.model.proportion.floatValue) * 100];
    
    NSString *string6 = [NSString stringWithFormat:@"%.2f",self.model.proportion.floatValue * _model.count.integerValue * self.model.presentTotalPrice.floatValue];

    NSString *string7 = [NSString stringWithFormat:@"%.2f",self.model.presentTotalPrice.floatValue * self.model.count.integerValue * (1 - self.model.proportion.floatValue)];
    
    self.deliveryAmount = self.model.presentTotalPrice;
    self.confirm = [NSNumber numberWithFloat:[NSString stringWithFormat:@"%.2f",self.model.presentTotalPrice.floatValue * self.model.proportion.floatValue].floatValue];
    self.overString = [NSNumber numberWithFloat:[NSString stringWithFormat:@"%.2f",self.model.presentTotalPrice.floatValue * (1-self.model.proportion.floatValue)].floatValue];
    
    NSArray *dataArray = @[string0,
                           string1,
                           string2,
                           string3,
                           string4,
                           string5,
                           string6,
                           string7
                           ];
    
    self.sureView.dataArray = dataArray;
}

- (void)initInterface{
    self.sureView = [[LCYPreSureView alloc] init];
    [self.view addSubview:self.sureView];
    [self.sureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

- (void)cancelButtonClickAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureButtonClickAction{
    MyAlert *alert = [MyAlert manage];
    __block __weak LCYPreSureViewController *weakself = self;
    [alert showBtnAlertWithTitle:@"温馨提示" detailTitle:@"确认提前交割？" button1Title:@"取消" button2Title:@"确定" confirm:^{
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:weakself.model.proportion forKey:@"ratio"];
        [dict setObject:weakself.deliveryAmount forKey:@"deliveryAmount"];
        [dict setObject:weakself.confirm forKey:@"confirm"];
        [dict setObject:weakself.overString forKey:@"over"];
        [dict setObject:weakself.model.orderId forKey:@"orderId"];

        [HttpRequestManager preAction:dict viewcontroller:self finishBlock:^(NSDictionary *dict) {
            if ([[dict objectForKey:@"returnCode"] isEqualToString:@"0000"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                });
            }
        }];
    }];
}

@end
