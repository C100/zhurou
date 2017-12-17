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

@end

@implementation LCYPreSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提前交割确认";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initInterface];
    [self getDataAction];
}

- (void)getDataAction{
    
    NSString *string0 = [NSString stringWithFormat:@"%ld头",self.model.count.integerValue];
    
    NSString *string1 = [NSString stringWithFormat:@"%@/%@",self.model.term,self.model.saleLimit];
    
    NSString *string2 = [NSString stringWithFormat:@"%@/%@元",self.model.price,self.model.presentPrice];
    
    NSString *string3 = [NSString stringWithFormat:@"%@/%@元",self.model.totalPrice,self.model.presentTotalPrice];
    
    NSString *string4 = [NSString stringWithFormat:@"%.0f%%",self.model.proportion.floatValue * 100];
    
    NSString *string5 = [NSString stringWithFormat:@"%.0f%%", (1 - self.model.proportion.floatValue) * 100];
    
    NSString *string6 = [NSString stringWithFormat:@"%.0f",self.model.proportion.floatValue * _model.count.integerValue * self.model.presentTotalPrice.floatValue];

    NSString *string7 = [NSString stringWithFormat:@"%.0f",self.model.presentTotalPrice.floatValue * self.model.count.integerValue * (1 - self.model.proportion.floatValue)];
    
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

@end
