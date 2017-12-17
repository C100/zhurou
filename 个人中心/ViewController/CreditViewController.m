//
//  CreditViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "CreditViewController.h"
#import "CreditTableView.h"
#import "AddCreditViewController.h"

@interface CreditViewController ()<CreditTableViewDelegate>

@property (nonatomic,strong) CreditTableView *tableView;


@end

@implementation CreditViewController

#pragma mark life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡";
    [self setNaviRightButton];
    [self prepareData];
    
    
    self.tableView = [[CreditTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.tableView.creditTableViewDelegate = self;
    self.tableView.selectedCardModel = self.model;
    [self.view addSubview:self.tableView];
}
-(void)setRefresh:(NSString *)refresh{
    _refresh = refresh;
    [self prepareData];
}

#pragma mark method
-(void)prepareData{
    [HttpRequestManager postCreditCardsWithFinishBlock:^(NSMutableArray *datas) {
        if (datas) {
            self.tableView.infos = datas;
        }
    }];
}

//设置右侧按钮
-(void)setNaviRightButton{
    UIButton *rightButton = [Tool buttonWithTitle:@"添加银行卡" titleColor:[LUtils colorHex:@"#98BBE3"] font:0 imageName:nil target:self action:@selector(addCreditAction)];
    rightButton.frame = CGRectMake(KHScreenW-80-10, (64-16)/2, 80, 16);
    rightButton.titleLabel.font = kLightFont(16);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
-(void)addCreditAction{
    AddCreditViewController *vc = [[AddCreditViewController alloc]init];
    __weak __block CreditViewController *weakSelf = self;
    vc.myCallBack = ^(id obj){
        [weakSelf prepareData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//添加银行卡成功后 刷新界面
-(void)setAddCreditInfos:(NSArray *)addCreditInfos{
    _addCreditInfos = addCreditInfos;
    [self.tableView.infos addObject:addCreditInfos];
    [self.tableView reloadData];
    
}

#pragma mark CreditTableView delegate
//-(void)chooseCreditWithCardNum:(NSString *)cardNum{
//    self.cardNum = cardNum;
//    //传值
//    _callBack(_cardNum);
//    [self.navigationController popViewControllerAnimated:YES];
//}
-(void)chooseCreditWithCardNum:(CreditCardModel *)model{
    self.cardNum = model.openNumber;
    //传值
    _callBack(model);
    [self.navigationController popViewControllerAnimated:YES];

    
}

-(void)deleteCreditCardWithModel:(CreditCardModel *)model andSelectedModel:(CreditCardModel *)seleModel{
    [HttpRequestManager deleteCreditCardWithCreditId:model.creditId andFinishBlock:^(NSDictionary *dataDic) {
        if (dataDic) {
            NSNumber *code = dataDic[@"code"];
            if (code.intValue==kSuccessCode) {
                if (self.tableView.infos.count>0) {
                    //如果删除的是默认的银行卡
                    if (model.isDefault.intValue==1) {
                        CreditCardModel *firstModel = self.tableView.infos.firstObject;
                        firstModel.isDefault = @(1);
                        //[self.tableView reloadData];
                        if (model.creditId.intValue==seleModel.creditId.intValue) {//还是选中的
                            self.tableView.selectedCardModel = nil;
                            _callBack(nil);
                        }
                    }else if (model.creditId.intValue==seleModel.creditId.intValue){
                        //删除的是选中的卡
//                        CreditCardModel *model = self.tableView.infos.firstObject;
//                        self.tableView.selectedCardNum = model.openNumber;
//                        _callBack(self.tableView.selectedCardNum);
                        self.tableView.selectedCardModel = nil;
                        _callBack(nil);
                    }else{
                        _callBack(nil);
                    }
                        
                }else{
                    _callBack(nil);
                }
                
                //[self.tableView reloadData];
            }
        }
    }];
}
-(void)editCreditCardInfoWithModel:(CreditCardModel *)model{
    [HttpRequestManager getCreditCardInfoWithCreditId:model.creditId andFinishBlock:^(CreditCardModel *cmodel) {
        if (cmodel) {
            AddCreditViewController *vc = [[AddCreditViewController alloc]init];
            vc.navigationTitle = @"编辑银行卡";
            vc.clickCreditModel = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}


@end
