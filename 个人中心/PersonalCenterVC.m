//
//  PersonalCenterVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/21.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "AboutMeVC.h"
#import "MyCouponsVC.h"
#import "CollectionVC.h"
#import "PersonalInfoVC.h"
#import "OrderVC.h"
#import "NoticeCenterVC2.h"
#import "SettingVC.h"
#import "MQChatViewManager.h"
#import "OrderModel.h"
#import "NoticeCenterModel.h"
#import "GongzhonhaoVC.h"
#import "AuthenViewController.h"
#import "WelfareViewController.h"
#import "LUtils.h"
#import "CouponApplyViewController.h"
#import "AddressManagerVC.h"
#import "MyFundViewController.h"
#import "MyInviteViewController.h"
#import "SettingViewController.h"
#import "MyCreditLimitViewController.h"
#import "DepositAuthenViewController.h"
#import "BackProViewController.h"
#import "LoginAndRegisterVC.h"
#import "BXNavigationController.h"
#import "MyPigViewController.h"

@interface PersonalCenterVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_tableViewDataArray;
    UIImageView *_titleImageView;
    UILabel *_nameLab;
    UILabel *_waitPayMark;
    UILabel *_finshPayMark;
    UIView *noticeYuanView;
    PersonalInfoModel* _personalModel;
    NSArray *_tableViewContents;
    
}

@property (nonatomic, assign) NSInteger lcystatus;

@end

@implementation PersonalCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lcystatus = 4;
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.view.backgroundColor = The_MainColor;
    
    [self updateOrderData];
    [self configUI];
    
//    NSNumber *isOnNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"isAppInReviewNum"];
//    if (isOnNum.intValue==1) {//审核中
//        _tableViewContents = @[@[@"我的收藏",@"我的优惠券",@"我的地址"],@[@"我的邀请码",@"在线客服",@"关于我们"]];
//    }else{
//        _tableViewContents = @[@[@"我的收藏",@"我的优惠券",@"我的资金",@"我的信用额度",@"我的地址"],@[@"我的猪种",@"托管养殖师"],@[@"我的邀请码",@"在线客服",@"关于我们"]];
//    }
    
    _tableViewContents = @[@[@"我的收藏",@"我的优惠券",@"我的地址"],@[@"我的邀请码",@"在线客服",@"关于我们"]];

    [self lcy_requestIsHiddenData];
    
}

- (void)lcy_requestIsHiddenData{
    __block __weak PersonalCenterVC *weakself = self;

    [HttpRequestManager postAdImgViewRequest:nil viewcontroller:self finishBlock:^(NSDictionary *data) {
        
        NSInteger isAppInReview = (NSInteger)[data objectForKey:@"isAppInReview"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isAppInReview==1) {//审核中
                _tableViewContents = @[@[@"我的收藏",@"我的优惠券",@"我的地址"],@[@"我的邀请码",@"在线客服",@"关于我们"]];
            }else{
                _tableViewContents = @[@[@"我的收藏",@"我的优惠券",@"我的资金",@"我的信用额度",@"我的地址"],@[@"我的猪种",@"托管养殖师"],@[@"我的邀请码",@"在线客服",@"关于我们"]];
            }
            [_tableview reloadData];
            [weakself prepareData];
        });
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self prepareData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark intviewcontroller

-(void)setAuthenStatus:(NSString *)authenStatus{
    _authenStatus = authenStatus;
    //    [_tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)prepareData
{
    //    [HttpRequestManager postChangeDesignerAuthStatusWithFinishBlock:^(NSDictionary *dataDic) {
    //
    //    }];
    
    //判断是否登录  登录再请求吧
    NSNumber *userId = [[NSUserDefaults standardUserDefaults]objectForKey:kUserId];
    if (userId) {
        //设计师认证状态
        [HttpRequestManager postDesignerInfoWithFinishBlock:^(NSDictionary *dataDic) {
            if (dataDic) {
                NSDictionary *info = dataDic[@"info"];
                NSNumber *certificationStatus = info[@"certificationStatus"];
                self.authenStatus = [LUtils designerAuthStatusWithCertificationStatus:certificationStatus];
                [self.tableView reloadData];
            }
        }];
    }
    
    
    [HttpRequestManager postMyInfoRequest:nil viewcontroller:self finishBlock:^(NSDictionary *data) {
        _personalModel =[[PersonalInfoModel alloc]init];
        _personalModel.imgUrl = data[@"headUrl"];
        
        NSArray *com = [_personalModel.imgUrl componentsSeparatedByString:@"http://qzapp.qlogo.cn/qzapp"];
        NSString *imgLastUrl  = @"";
        if (com.count==2) {
            imgLastUrl = [NSString stringWithFormat:@"http://q.qlogo.cn/qqapp%@",com.lastObject];
            _personalModel.imgUrl = imgLastUrl;
        }
        _personalModel.state = data[@"state"];
        _personalModel.name = data[@"username"];
        _personalModel.phone = data[@"mobile"];
        _personalModel.userCode = data[@"userCode"];
        _personalModel.money = data[@"money"];
        _personalModel.useInvitationCode = [data objectForKey:@"useInvitationCode"];
        [Tool setTouxiangImgurl:_titleImageView imgurl:_personalModel.imgUrl];
        _nameLab.text = data[@"username"];
    }];
    
    /**
     * 是否有新通知
     */
    
    [HttpRequestManager postXiaoXiGetRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *data) {
        _personalModel.haveNotice = NO;
        for (NoticeCenterModel *noticeModel in data) {
            if ([noticeModel.isRead integerValue] != 1) {
                _personalModel.haveNotice = YES;
            }
        }
        if (!_personalModel.haveNotice) {
            noticeYuanView.backgroundColor = [UIColor whiteColor];
        }else{
            noticeYuanView.backgroundColor = [UIColor redColor];
        }
        //        [self.tableView reloadData];
    }];
    
    
    //托管养殖认证
    NSNumber *isOnNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"isAppInReviewNum"];
    if (isOnNum.intValue==1) {//审核中
        
    }else{
        [HttpRequestManager getApplyInfoWithFinishBlock:^(NSDictionary *dataDic) {
            if (dataDic) {
                UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                NSDictionary *infoDic = dataDic[@"data"];
                if (infoDic == nil) {//为空 未认证
                    self.lcystatus = 4;
                    cell.detailTextLabel.text = @"未认证";
                }else{
                    NSNumber *statusNum = infoDic[@"status"];
                    self.lcystatus = statusNum.integerValue;
                    switch (statusNum.intValue) {
                        case 0:
                            cell.detailTextLabel.text = @"认证中";
                            break;
                        case 1:
                            cell.detailTextLabel.text = @"认证通过";
                            break;
                        case 2:
                            cell.detailTextLabel.text = @"重新认证";
                            break;
                        default:
                            break;
                    }
                }
                
            }
            
        }];
        
        
        //我的信用额度
        [HttpRequestManager getMyCreditWithFinishBlock:^(NSDictionary *dataDic) {
            if (dataDic) {
                UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                NSNumber *moneyCount = dataDic[@"moneyCount"];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2f",moneyCount.floatValue];
            }
        }];
        
    }
    
    
}

-(void)updateOrderData
{
    [HttpRequestManager postOrderGetAllRequest:nil viewcontroller:self finishBlock:^(NSDictionary *data) {
        NSDictionary *dataDic =  data;
        NSMutableArray *orderArr = [[NSMutableArray alloc]init];
        
        NSArray *dataArr = dataDic[@"allReceipt"];
        
        for (int i = 0; i < dataArr.count; i++) {
            
            NSDictionary *goodsDic = dataArr[i];
            
            [[UserManager manage]saveUserInfoWithDic:goodsDic];
            
            
            OrderModel *model = [[OrderModel alloc]init];
            
            model.time = [NSDate dateStrFromCstampTime:[goodsDic[@"createTime"] intValue] withDateFormat:@"YYYY-MM-dd"];
            model.payDic = [goodsDic mutableCopy];
            
            model.ID = goodsDic[@"id"];
            NSDictionary *payMsgDic = [[Tool tools] dictionaryWithJsonString:goodsDic[@"payJson"]];
            NSArray *payMsgArr = payMsgDic[@"payMsg"];
            
            for (int j = 0; j < payMsgArr.count; j++) {
                NSDictionary *goodsDic = payMsgArr[j];
                
                
                //            @"goodsColor":goodModel.color,
                
                GoodsModel *tempModel = [[GoodsModel alloc]init];
                tempModel.imgUrl = goodsDic[@"goodsSmallUrl"];
                tempModel.colorName = goodsDic[@"colorName"];
                tempModel.title =  goodsDic[@"goodsName"];
                tempModel.color =  goodsDic[@"goodsColor"];
                tempModel.type = goodsDic[@"goodsStyle"];
                tempModel.goodsId = goodsDic[@"goodsId"];
                tempModel.detailId = goodsDic[@"goodsColorStyleId"];
                tempModel.price = [Tool priceChange:goodsDic[@"price"]];
                tempModel.number =  goodsDic[@"goodsAmount"];
                [model.goodsArr addObject:tempModel];
            }
            if ([goodsDic [@"showStatus"] intValue] == 1) {
                model.type = @"待付款";
            }else if ([goodsDic [@"showStatus"] intValue] == 2) {
                model.type = @"待收货";
            }else if ([goodsDic [@"showStatus"] intValue] == 4) {
                model.type = @"待评价";
            }else if ([goodsDic [@"showStatus"] intValue] == 5)
            {
                model.type = @"已完成";
            }
            if (model.type) {
                [orderArr addObject:model];
            }
        }
        
        int fukuan = 0;
        int souhuo = 0;
        
        
        for (OrderModel *tempOrder in orderArr) {
            if ([tempOrder.type isEqualToString:@"待付款"]) {
                fukuan ++;
            }else if ([tempOrder.type isEqualToString:@"待收货"])
            {
                souhuo ++;
            }
        }
        
        if (fukuan == 0) {
            _waitPayMark.hidden = YES;
        }else
        {
            _waitPayMark.hidden = NO;
            _waitPayMark.text = [[NSString alloc]initWithFormat:@"%d",fukuan];
            if (fukuan > 10) {
                [_waitPayMark mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(12);
                }];
            }
        }
        
        if (souhuo == 0) {
            _finshPayMark.hidden = YES;
        }else
        {
            _finshPayMark.hidden = NO;
            _finshPayMark.text = [[NSString alloc]initWithFormat:@"%d",souhuo];
            if (fukuan > 10) {
                [_finshPayMark mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(12);
                }];
            }
        }
        
        
    }];
    
}

-(void)configUI
{
    
    _tableview = [[UITableView alloc] init];
    _tableview.backgroundColor = The_list_backgroundColor;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.bounces=false;
    _tableview.tableFooterView = [UIView new];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    
    //    UIBarButtonItem *rightbarbuttion2 = [UIBarButtonItem itemWithImageName:@"shezhi@2x.png" highImageName:@"shezhi@2x.png" target:self action:@selector(settingAction)];
    //    self.navigationItem.rightBarButtonItems = @[rightbarbuttion2];
    
    
    /**
     * 创建头视图
     */
    UIView *titleView = [[UIView alloc]init];
    titleView.height = 254;
    titleView.backgroundColor = [UIColor whiteColor];
    _tableview.tableHeaderView = titleView;
    
    
    UIView *bgImageView = [[UIImageView alloc]init];
    bgImageView.backgroundColor=The_MainColor;
    bgImageView.userInteractionEnabled = YES;
    [titleView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(107);
    }];
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor clearColor];
    [bgImageView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.centerY.equalTo(bgImageView);
        //        make.height.mas_equalTo(107);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoPersonalInfo)];
    [topView addGestureRecognizer:tap];
    
    _titleImageView = [[UIImageView alloc]init];
    [topView addSubview:_titleImageView];
    [Tool setTouxiangImgurl:_titleImageView imgurl:nil];
    _titleImageView.layer.cornerRadius = 30;
    _titleImageView.clipsToBounds = YES;
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(18);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerY.mas_equalTo(0);
    }];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"向右的白箭头"]];
    [topView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(9, 15));
        make.right.mas_equalTo(-12);
    }];
    
    _nameLab = [Tool labelWithTitle:_personalModel.name color:[UIColor whiteColor] fontSize:17 alignment:0];
    [topView addSubview:_nameLab];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.right.offset(0);
        make.left.mas_equalTo(_titleImageView.mas_right).mas_equalTo(20);
        make.right.mas_equalTo(arrowImageView.mas_left).mas_equalTo(-8);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
        //        make.top.mas_equalTo(_titleImageView.mas_bottom).mas_offset(20);
    }];
    
    UIView *middleView = [[UIView alloc]init];
    [titleView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(36);
    }];
    UITapGestureRecognizer *orderTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoOrderInfo)];
    [middleView addGestureRecognizer:orderTap];
    
    UILabel *myorderLabel = [Tool labelWithTitle:@"我的订单" color:k3D3D3DColor fontSize:14 alignment:1];
    [middleView addSubview:myorderLabel];
    [myorderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(12);
        make.height.mas_equalTo(14);
    }];
    [myorderLabel sizeToFit];
    
    UIImageView *marrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"向右的黑箭头1"]];
    [middleView addSubview:marrowImageView];
    [marrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(9, 15));
        make.right.mas_equalTo(-12);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kD6D6D6Color;
    [middleView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myorderLabel.mas_bottom).mas_equalTo(12);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(0);
    }];
    
    
    /**
     * 底部按钮
     */
    
    NSArray *imgArr = @[@"待付款",@"待发货 (1)",@"已发货",@"待评价",@"联系客服"];
    NSArray *btnTitleArr = @[@"待付款",@"待发货",@"待收货",@"待评价",@"售后／退款"];
    UIButton *lastBtn = nil;
    
    CGFloat width = KHScreenW/btnTitleArr.count;
    for (int i = 0; i < btnTitleArr.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 100 + i;
        //        btn.backgroundColor = [UIColor yellowColor];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.offset(0);
            make.top.mas_equalTo(middleView.mas_bottom).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(width, 70));
            if (i==0) {
                make.left.offset(0);
            }else if(i==btnTitleArr.count-1)
            {
                make.left.mas_equalTo(lastBtn.mas_right);
                make.bottom.mas_equalTo(-12);
            }else{
                make.left.mas_equalTo(lastBtn.mas_right);
            }
        }];
        
        UIImageView *btnimgView = [[UIImageView alloc]init];
        btnimgView.image = [UIImage imageNamed:imgArr[i]];
        [btn addSubview:btnimgView];
        btnimgView.contentMode = UIViewContentModeScaleAspectFit;
        [btnimgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.centerX.mas_equalTo(btn.centerX);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
        
        
        UILabel *btntitleLab = [Tool labelWithTitle:btnTitleArr[i] color:The_wordsColor fontSize:14 alignment:1];
        //        btntitleLab.backgroundColor = [UIColor redColor];
        [btn addSubview:btntitleLab];
        
        
        CGSize titleSize = [btntitleLab.text sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(KHScreenW, 20)];
        
        [btntitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(btnimgView.mas_bottom).mas_offset(10);
            make.centerX.mas_offset(btn.centerX);
            make.size.mas_equalTo(titleSize);
        }];
        
        lastBtn = btn;
        
        
        //红点
        
        if (i==0) {
            _waitPayMark = [[UILabel alloc]init];
            //            _waitPayMark.text = @"2";
            _waitPayMark.textAlignment = 1;
            _waitPayMark.textColor = [UIColor whiteColor];
            _waitPayMark.backgroundColor = [UIColor redColor];
            _waitPayMark.font = [UIFont systemFontOfSize:6];
            [btn addSubview:_waitPayMark];
            _waitPayMark.cornerRadius = 2;
            [_waitPayMark mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btntitleLab.mas_right);
                make.top.mas_equalTo(btntitleLab.mas_top);
                make.size.mas_equalTo(CGSizeMake(8, 8));
            }];
            _waitPayMark.hidden = YES;
        }
        if (i==1) {
            _finshPayMark = [[UILabel alloc]init];
            //                _finshPayMark.text = @"2";
            _finshPayMark.textAlignment = 1;
            _finshPayMark.textColor = [UIColor whiteColor];
            _finshPayMark.backgroundColor = [UIColor redColor];
            _finshPayMark.font = [UIFont systemFontOfSize:6];
            [btn addSubview:_finshPayMark];
            _finshPayMark.cornerRadius = 2;
            [_finshPayMark mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btntitleLab.mas_right);
                make.top.mas_equalTo(btntitleLab.mas_top);
                make.size.mas_equalTo(CGSizeMake(8, 8));
            }];
            _finshPayMark.hidden = YES;
            
        }
        
        //        UIView *lineView = [[UIView alloc]init];
        //        lineView.backgroundColor = The_line_Color_grary;
        //        [btn addSubview:lineView];
        //
        //        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.centerY.mas_equalTo(btn.centerY);
        //            make.right.mas_offset(-1);
        //            make.size.mas_equalTo(CGSizeMake(1, 30));
        //        }];
        //        if (i==3) {
        //            lineView.hidden = YES;
        //        }
    }
    
}

#pragma mark buttonAction
-(void)gotoPersonalInfo{
    SettingViewController *vc = [[SettingViewController alloc]init];
    //    PersonalInfoVC *vc = [[PersonalInfoVC alloc]init];
    vc.model = _personalModel;
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)settingAction
//{
//    SettingVC *vc = [[SettingVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}

-(void)gotoOrderInfo{
    OrderVC *vc = [[OrderVC alloc]init];
    vc.type = 0;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)btnAction:(UIButton *)btn
{
    OrderVC *vc = [[OrderVC alloc]init];
    
    if (btn.tag==104) {
        BackProViewController *vc = [[BackProViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    switch (btn.tag) {
        case 100:
        {
            NSLog(@"1");
            vc.type = 1;
            
        }
            break;
        case 101:
        {
            NSLog(@"2");
            vc.type = 2;
            
        }
            break;
        case 102:
        {
            NSLog(@"3");
            vc.type = 3;
            
        }
            break;
        case 103:
        {
            NSLog(@"4");
            vc.type = 4;
            
        }
            break;
        case 104:
        {
            //退货
            
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark --tableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = The_list_backgroundColor;
    return view;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    return 3;
    return _tableViewContents.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (section == 0) {
    //        return 5;
    //    }else if(section==1){
    //        return 2;
    //    }else{
    //        return 3;
    //    }
    NSArray *arr = _tableViewContents[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.textColor = k4D4D4DColor;
        
        cell.textLabel.font = [UIFont fontWithName:The_titleFont size:15];
        cell.separatorInset = UIEdgeInsetsMake(10,10,20,0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        cell.detailTextLabel.textColor = k4D4D4DColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    
    
    NSArray *arr = _tableViewContents[indexPath.section];
    cell.imageView.image = [UIImage imageNamed:arr[indexPath.row]];
    cell.textLabel.text = arr[indexPath.row];
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *arr = _tableViewContents[indexPath.section];
    NSString *title = arr[indexPath.row];
    if ([title isEqualToString:@"我的收藏"]) {
        CollectionVC *vc = [[CollectionVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"我的优惠券"]){
        MyCouponsVC *vc = [[MyCouponsVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"我的资金"]){
        if (getUserId==nil) {
            MyAlert *alert = [MyAlert manage];
            [alert showBtnAlertWithTitle:@"提醒" detailTitle:@"您还未登录是否登录？" button1Title:@"取消" button2Title:@"确定" confirm:^{
                LoginAndRegisterVC *vc1 = [[LoginAndRegisterVC alloc]init];
                vc1.isVistor = YES;
                BXNavigationController *nav1 = [[BXNavigationController alloc]initWithRootViewController:vc1];
                [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:nav1 animated:YES completion:nil];
            }];
        }else{
            MyFundViewController *vc = [[MyFundViewController alloc]init];
            vc.personModel = _personalModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }else if ([title isEqualToString:@"我的信用额度"]){
        MyCreditLimitViewController *vc = [[MyCreditLimitViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"我的地址"]){
        AddressManagerVC  *vc = [[AddressManagerVC alloc]init];
        [vc setCallback:^(AddressModel *model) {
            //        _model.AddressModel = model;//在地址管理中点击某个地址 / 删除的地址与该页地址不一致
            //        [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"我的猪种"]){
        MyPigViewController *vc = [[MyPigViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"托管养殖师"]){
        //养殖师
        /*判断状态
         认证中：不可以进入
         已认证：不可以进入
         未认证：可以进入
         被驳回：可以进入
         */
        //认证中和已认证状态下不能进入
        if (_lcystatus == 0 || _lcystatus == 1) {
            return;
        }
        
        DepositAuthenViewController *vc = [[DepositAuthenViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"我的邀请码"]){
        //我的邀请码
        MyInviteViewController *vc = [[MyInviteViewController alloc]init];
        vc.personModel = _personalModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"在线客服"]){
        [[Tool tools] showkefuViewController:self];
    }else{
        AboutMeVC *vc = [[AboutMeVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

//返回分区的脚的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

@end

