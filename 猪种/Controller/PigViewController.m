//
//  PigViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "PigViewController.h"
#import "ZHPigBannerView.h"
#import "ZHPigFirstTableCell.h"
#import "ZHScreenAdaptation.h"
#import "ZHPigSecondTableCell.h"
#import "ZHPigHeaderTableCell.h"
#import "ZHPigThirdTableCell.h"
#import "ZHPigBuyView.h"
#import "ZHRealNameAuthViewController.h"
#import "ZHPigNetwork.h"
#import "ZHPigInfoModel.h"
#import "ZHCompactViewController.h"
#import "ZHPigMyOrderViewController.h"
#import "LoginAndRegisterVC.h"
#import "BXNavigationController.h"

@interface PigViewController () <UITableViewDataSource, UITableViewDelegate, ZHPigBuyViewDelegate>

@property (nonatomic, weak) IBOutlet ZHPigBannerView *pigBannerView;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UIView *tableHeaderView;

@property (nonatomic, copy) NSArray *sectionTitles;

@property (nonatomic, strong) ZHPigInfoModel *pigInfoModel;

@property (nonatomic, assign) BOOL needAuth;// 是否需要实名认证
@property (nonatomic, assign) BOOL hasOrderToBePaid;// 是否有未支付的订单

@end

@implementation PigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableHeaderView.frame = CGRectMake(0, 0, 0, [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:250]);
    self.tableView.tableHeaderView = self.tableHeaderView;

    self.sectionTitles = @[@"", @"", @"市场价变动图", @"市仓图", @"价格明细"];

    [[[ZHPigNetwork alloc] init] versionDetectionWithCallback:^(BOOL status, NSString *message, id obj, NSString *code) {
        [[MyAlert manage]showBtnAlertWithTitle:@"温馨提示" detailTitle:@"有新版本更新，请升级" confirm:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:obj]];
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadPigInfo];
    [self checkNeedRealNameAuth];
    [self.pigBannerView manageExceptionWhenAutoScroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network
- (void)loadPigInfo {
    [[[ZHPigNetwork alloc] init] getPigInfoWithCallback:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            self.pigInfoModel = obj;
            self.pigBannerView.dataSource = self.pigInfoModel.bannerImages;
            [self.tableView reloadData];
        }
    }];
}

- (void)checkNeedRealNameAuth {
    [[[ZHPigNetwork alloc] init] checkNeedRealNameAuthWithCallback:^(BOOL status, NSString *message, id obj, NSString *code) {
        if ([code isEqualToString:@"0000"]) {
            self.needAuth = NO;
            self.hasOrderToBePaid = NO;
        } else if ([code isEqualToString:@"5003"]) {
            self.needAuth = YES;
        } else if ([code isEqualToString:@"5004"]) {
            self.hasOrderToBePaid = YES;
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ZHPigFirstTableCell";
    if (indexPath.section == 0) {
        cellIdentifier = @"ZHPigFirstTableCell";
        ZHPigFirstTableCell *firstTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [firstTableCell configureWithPigInfoModel:self.pigInfoModel];
        return firstTableCell;
    } else if (indexPath.section == 1 || indexPath.section == self.sectionTitles.count - 1)  {
        cellIdentifier = @"ZHPigSecondTableCell";
        ZHPigSecondTableCell *secondTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (indexPath.section == 1) {
            [secondTableCell configureWithText:self.pigInfoModel.pigIntroduce];
        } else {
            [secondTableCell configureWithText:self.pigInfoModel.priceDetail];
        }
        return secondTableCell;
    } else {
        cellIdentifier = @"ZHPigThirdTableCell";
        ZHPigThirdTableCell *thirdTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (indexPath.section == 2) {
            [thirdTableCell configureWithImageURLString:self.pigInfoModel.priceImage];
        } else {
            [thirdTableCell configureWithImageURLString:self.pigInfoModel.warehouseImage];
        }
        return thirdTableCell;
    }
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    static NSString *cellIdentifier = @"ZHPigHeaderTableCell";
    ZHPigHeaderTableCell *headerCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [headerCell configureWithTitle:self.sectionTitles[section]];
    return headerCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        return 10;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:125];
    } else if (indexPath.section == 1) {
        return [ZHPigSecondTableCell heightWithText:self.pigInfoModel.pigIntroduce];
    } else if (indexPath.section == self.sectionTitles.count - 1) {
        return [ZHPigSecondTableCell heightWithText:self.pigInfoModel.priceDetail];
    }
    return 220;
}

#pragma mark - ZHPigBuyViewDelegate
- (void)pigBuyView:(ZHPigBuyView *)pigBuyView confirmWithModel:(ZHPigBuyModel *)model {

    if (!getUserId) {
        MyAlert *alert = [MyAlert manage];
        [alert showBtnAlertWithTitle:@"提醒" detailTitle:@"您还未登录是否登录？" button1Title:@"取消" button2Title:@"确定" confirm:^{
            LoginAndRegisterVC *vc1 = [[LoginAndRegisterVC alloc]init];
            vc1.isVistor = YES;
            BXNavigationController *nav1 = [[BXNavigationController alloc]initWithRootViewController:vc1];
            [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:nav1 animated:YES completion:nil];
        }];
    } else {
        [UIApplication appDelegate].pigBuyModel = model;

//        ZHCompactViewController *compactVC = [[ZHCompactViewController alloc] init];
//        compactVC.URLString = self.pigInfoModel.contractURLString;
//        [self.navigationController pushViewController:compactVC animated:YES];
//
//        ZHPigMyOrderViewController *myOrderViewController = [[UIStoryboard storyboardWithName:@"ZHPig" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(ZHPigMyOrderViewController.class)];
//        [self.navigationController pushViewController:myOrderViewController animated:YES];


        if (self.hasOrderToBePaid) {
            ZHPigMyOrderViewController *myOrderViewController = [[UIStoryboard storyboardWithName:@"ZHPig" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(ZHPigMyOrderViewController.class)];
            [self.navigationController pushViewController:myOrderViewController animated:YES];
        } else {
            if (self.needAuth) {
                ZHRealNameAuthViewController *realNameAuthVC = [[UIStoryboard storyboardWithName:@"ZHPig" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(ZHRealNameAuthViewController.class)];
                [self.navigationController pushViewController:realNameAuthVC animated:YES];
            } else {
                ZHCompactViewController *compactVC = [[ZHCompactViewController alloc] init];
                compactVC.URLString = self.pigInfoModel.contractURLString;
                [self.navigationController pushViewController:compactVC animated:YES];
            }
        }
    }
}

#pragma mark - IBAction
- (IBAction)buyButtonClick:(id)sender {
    ZHPigBuyView *buyView = [[ZHPigBuyView alloc] init];
    buyView.delegate = self;
    [buyView configureWithPigInfoModel:self.pigInfoModel];
    [buyView show];
}

@end
