//
//  PigGiftedViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "PigGiftedViewController.h"
#import "PigGiftedTableView.h"
#import "GoodsVC.h"

@interface PigGiftedViewController ()

@property(nonatomic, strong) PigGiftedTableView *myTableView;
@property (nonatomic, strong) GoodsDetailModel *goodsDetailModel;

@end

@implementation PigGiftedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"猪种礼包";
    self.myTableView = [[PigGiftedTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    [self.view addSubview:self.myTableView];
    
    self.myTableView.pigListModel = self.pigListModel;
    [self initNet];
    
    __block __weak PigGiftedViewController *weakself = self;

    [self.myTableView setSelectCallBack:^(id obj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            GoodsVC *vc = [[GoodsVC alloc]init];
            vc.goodIds = weakself.goodsDetailModel.goodsId;
            vc.title = weakself.pigListModel.goodsName;
            [weakself.navigationController pushViewController:vc animated:YES];
        });
    }];
}

- (void)initNet{
    
    NSDictionary *dic = @{@"goodsId":self.pigListModel.orderId,
                          @"userId":getUserId
                          };
    
    [HttpRequestManager postGoodsDeatailRequest:dic viewcontroller:self finishBlock:^(GoodsDetailModel *goodsDetailModel) {
        self.goodsDetailModel = goodsDetailModel;
        self.myTableView.goodsDetailModel = goodsDetailModel;
    }];
}

@end
