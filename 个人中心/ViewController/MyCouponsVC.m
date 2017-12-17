//
//  MyCouponsVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/22.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "MyCouponsVC.h"
#import "CouponsModel.h"
#import "CouponsCell.h"

@interface MyCouponsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_tableViewDataArray;
    UIImageView *_titleImageView;
    UITextField *_exchangeTextFild;
    UIView *wuBackView;
    UIButton *confirmBtn;
    
}

@end

@implementation MyCouponsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的优惠券";
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
//    _tableViewDataArray = [[NSMutableArray alloc]init];
    
    
    [HttpRequestManager postGetVoucherRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *arr) {
        
        _tableViewDataArray = arr;
        
        if (arr.count == 0) {
            wuBackView.hidden = NO;
            //确认按钮取消
            confirmBtn.hidden = YES;
//            _tableview.hidden = YES;
        }else
        {
            wuBackView.hidden = YES;;
            confirmBtn.hidden = NO;
//            _tableview.hidden = NO;

        }
        
        
        if (_isShopping) {
            for (CouponsModel *model in arr) {
                
                if ([model.LimitPrice intValue] * 0.01 > _orderPrice) {
                    model.UnCanUser = YES;
                }
                
            }
        }
        
        [_tableview reloadData];
    }];
    
    
//    for (int i = 0; i < 10; i++) {
//        CouponsModel *model = [[CouponsModel alloc]init];
//        model.price = @"100";
//        model.detailPrice = @"满100元可用";
//        model.time = @"2016-08-20 - 2016-09-30";
//        model.type = @"全品类";
//        model.title = @"秋冬新品优惠";
//        [_tableViewDataArray addObject:model];
//    }
    
}

-(void)configUI
{
   
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    //没有优惠券时
    wuBackView = [[UIView alloc]init];
    wuBackView.hidden = YES;
    wuBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wuBackView];
    [wuBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
    UILabel *wuLab = [Tool labelWithTitle:@"无可用优惠券" color:The_placeholder_Color_grary fontSize:15 alignment:1];
    [wuBackView addSubview:wuLab];
    
    [wuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    
    
    self.view.backgroundColor = The_list_backgroundColor;
    
    UIImageView *wuImageView = [[UIImageView alloc]init];
    wuImageView.image = [UIImage imageNamed:@"wu@2x.png"];
    [wuBackView addSubview:wuImageView];
    
    [wuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.bottom.mas_equalTo(wuLab.mas_top).offset(-20);
    }];
    
    

    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64-60) style:UITableViewStylePlain];
    _tableview.backgroundColor = [UIColor clearColor];
    
    //    _tableview.backgroundColor = The_list_backgroundColor;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    

    
    
    
    /**
     * 创建头视图
     */
    UIView *titleView = [[UIView alloc]init];
    titleView.height = 60;
    titleView.backgroundColor = [UIColor whiteColor];
    _tableview.tableHeaderView = titleView;


    UIView *luehuanView = [[UIView alloc]init];
//    luehuanView.backgroundColor = [UIColor redColor];
    [titleView addSubview:luehuanView];
    [luehuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(luehuanView.centerX);
//        make.size.mas_equalTo(CGSizeMake(230, 40));
        make.top.offset(25);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);

    }];
    
    
 
    
    UIButton *duiHuanBtn = [Tool buttonWithTitle:@"兑换" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(duihuanAction)];
    duiHuanBtn.backgroundColor = The_MainColor;
    [luehuanView addSubview:duiHuanBtn];

    [duiHuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.width.mas_equalTo(@80);
//        make.left.mas_equalTo(_exchangeTextFild.mas_right).mas_equalTo(10);
    }];
    
    _exchangeTextFild = [[UITextField alloc]init];
    _exchangeTextFild.placeholder = @" 请输入兑换码";
    _exchangeTextFild.font = [UIFont fontWithName:The_titleFont size:15];
    _exchangeTextFild.borderWidth = 1;
    _exchangeTextFild.borderColor = The_line_Color_grary;
    [luehuanView addSubview:_exchangeTextFild];
    [_exchangeTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.mas_equalTo(duiHuanBtn.mas_left).mas_equalTo(-10);
    }];
    
    UILabel *holderLab = [Tool labelWithTitle:@"优惠券不可叠加使用" color:The_placeholder_Color_grary fontSize:12 alignment:1];
    [titleView addSubview:holderLab];
    [holderLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(luehuanView.mas_bottom).offset(20);
        make.top.mas_offset(40);
        make.left.right.offset(0);
        make.height.mas_equalTo(14);
    }];
    
    

    UIView *underView = [[UIView alloc]init];
    underView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:underView];
    [self.view bringSubviewToFront:underView];
    [underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_equalTo(60);
    }];
    
    
    
    confirmBtn = [Tool buttonWithTitle:@"确定" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:@selector(confirmAction)];
    confirmBtn.backgroundColor = The_MainColor;
    [underView addSubview:confirmBtn];
    confirmBtn.hidden = YES;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(50);
        make.right.mas_offset(-50);
        make.centerY.mas_equalTo(underView.centerY);
        make.height.mas_offset(40);

    }];
    
    
    //判断是否是购物页面进入
    if (_isShopping) {
        
        duiHuanBtn.hidden = YES;
        _exchangeTextFild.hidden = YES;
    }else
    {
        holderLab.hidden = YES;
        underView.hidden = YES;
        _tableview.frame = CGRectMake(0, 0,KHScreenW, KHScreenH-64);
    }
    
    
}

#pragma mark buttonAction
-(void)duihuanAction
{
    if (_exchangeTextFild.text.length == 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"兑换码不能为空！"];
        return;
    }
    
    NSDictionary *dic = @{@"code":_exchangeTextFild.text,
                          };
    
    [HttpRequestManager postExchangeVoucherRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
        if ([data[@"code"] intValue] == 200) {
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"兑换成功！"];
            [self prepareData];
        }
        
    }];
    
    
}


-(void)confirmAction
{
    
    CouponsModel *selectModel = nil;
    
    for ( CouponsModel *tempModel in _tableViewDataArray) {
        if (tempModel.isSelect ) {
            selectModel = tempModel;
        }
    
    }
    
    if (selectModel) {
        _couponsCallBack(selectModel);
        [self.navigationController popViewControllerAnimated:YES];

    }else
    {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"警告" detailTitle:@"请选择优惠券"];
    }
    
    
}

#pragma mark --tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CouponsModel *model = _tableViewDataArray[indexPath.row];
    
    static NSString *cellid = @"HomeMultCell";
    CouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[CouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CouponsModel *model = _tableViewDataArray[indexPath.row];
    
    if ([model.voucherStatus integerValue] != 1) {
        //失效
        return;
    }

    if (!_isShopping) {
        return;
    }
    
    if (model.UnCanUser == YES) {
        return;
    }
    
    for ( CouponsModel *tempModel in _tableViewDataArray) {
        tempModel.isSelect = NO;
    }
    
    model.isSelect = !model.isSelect;
    [_tableview reloadData];
    
}
//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

//返回分区的脚的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScalePx(108);
}





@end
