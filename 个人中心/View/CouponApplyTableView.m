//
//  CouponApplyTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "CouponApplyTableView.h"
#import "CouponApplyCell.h"

@implementation CouponApplyTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kF5F5F5Color;
        self.titles = @[@"客户姓名",@"客户手机",@"客户地区",@"小区名称"];
        self.placeholders = @[@"请输入持卡人姓名",@"请输入手机号",@"",@"请输入名称"];
        
        self.tableFooterView = [[UIView alloc]init];
        
        //注册
        [self registerClass:[CouponApplyCell class] forCellReuseIdentifier:@"CouponApplyCell"];
        
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponApplyCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    cell.row = indexPath.row;
    cell.placeholder = self.placeholders[indexPath.row];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, 70)];
    bgView.backgroundColor = [UIColor clearColor];
    
    UIButton *applyButton = [UIButton buttonWithTitle:@"申请优惠码" titleColor:[UIColor whiteColor] font:kLightFont(14) target:self action:@selector(applyAction)];
    [bgView addSubview:applyButton];
    applyButton.frame = CGRectMake((KHScreenW-280)/2, 30, 280, 40);
    applyButton.backgroundColor = The_MainColor;
    
    return bgView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        //[self showPickerView];
        self.pickView = [LocationPickerView shareInstance];
        self.pickView.locationPickerViewDelegate = self;
        [[[UIApplication sharedApplication] keyWindow]addSubview:self.pickView];
//        areaPick.block = ^(NSString *province,NSString *city,NSString *town){
//            _dataModel.address =[NSString stringWithFormat:@"%@%@%@",province,city,town];
//            [_tableview reloadData];
//        };
    }
}

-(void)applyAction{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<self.titles.count; i++) {
        CouponApplyCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (i == 2) {
            [arr addObject:cell.chooseLabel.text];
        }else{
            [arr addObject:cell.myTextField.text];
        }
                                 
    }
    [self.couponApplyTableViewDelegate applyActionWithName:arr[0] andPhoneNum:arr[1] andLocation:arr[2] andAddress:arr[3]];
}

//-(void)hidePickerView:(UIButton *)sender{
//    [self hidePickerView];
//    if ([sender isEqual:self.pickView.sureButton]) {
//        if ([self.selectedPro isEqualToString:@""]||self.selectedPro == nil) {
//            self.selectedPro = self.pickView.selectedPro;
//        }
//        if ([self.selectedCity isEqualToString:@""]||self.selectedCity == nil) {
//            self.selectedCity = self.pickView.selectedCity;
//        }
//        CouponApplyCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//        cell.chooseLabel.text = [NSString stringWithFormat:@"%@%@",[self.selectedPro substringToIndex:self.selectedPro.length-1],[self.selectedCity substringToIndex:self.selectedCity.length-1]];
//    }
//}
//-(void)showPickerView{
//    [UIView animateWithDuration:.2 animations:^{
//        self.bgView.alpha = .6;
//        self.pickView.frame = CGRectMake(0, KHScreenH-200, KHScreenW, 200);
//        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.pickView];
//    } completion:^(BOOL finished) {
//        
//    }];
//}
//-(void)hidePickerView{
//    [UIView animateWithDuration:.2 animations:^{
//        self.pickView.frame = CGRectMake(0, KHScreenH, KHScreenW, 200);
//        self.bgView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self.bgView removeFromSuperview];
//        self.bgView = nil;
//    }];
//}

#pragma mark LocationPickerView delegate
-(void)chooseLocationWithProvince:(NSString *)pro andCity:(NSString *)city{
    
    self.selectedPro = pro;
    self.selectedCity = city;
    CouponApplyCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.chooseLabel.text = [NSString stringWithFormat:@"%@%@",[self.selectedPro substringToIndex:self.selectedPro.length-1],[self.selectedCity substringToIndex:self.selectedCity.length-1]];
                             
}

#pragma mark life circle
//-(LocationPickerView *)pickView{
//    if (_pickView == nil) {
//        _pickView = [[LocationPickerView alloc]initWithFrame:CGRectMake(0, KHScreenH, KHScreenW, 200)];
//        _pickView.locationPickerViewDelegate = self;
//        [[UIApplication sharedApplication].keyWindow addSubview:_pickView];
//        [_pickView.cancleButton addTarget:self action:@selector(hidePickerView:) forControlEvents:UIControlEventTouchUpInside];
//        [_pickView.sureButton addTarget:self action:@selector(hidePickerView:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _pickView;
//}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH)];
        [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
    }
    return _bgView;
}


@end
