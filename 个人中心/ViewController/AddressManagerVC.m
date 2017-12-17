//
//  AddressManagerVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/24.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "AddressManagerVC.h"
#import "AddressCell.h"
#import "creatAddressVC.h"
#import "AuthSuccessViewController.h"
@interface AddressManagerVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_tableViewDataArray;
    AddressModel *_model;
    AddressModel *_defaultAddressModel;
    
}

@end

@implementation AddressManagerVC



- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"地址管理";
    
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
  
    
   [HttpRequestManager postGetAddressRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *dataArr) {
       _tableViewDataArray = dataArr;
       [self.tableView reloadData];
   }];
    
    
}

-(void)configUI
{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64-60) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    UIView *underView = [[UIView alloc]init];
//    underView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:underView];
    [self.view bringSubviewToFront:underView];
    
    [underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    
    
    UIButton *newAddressBtn = [Tool buttonWithTitle:@"新建地址" titleColor:[UIColor whiteColor] font:18 imageName:nil target:self action:@selector(newAddressAction)];
    newAddressBtn.backgroundColor = The_MainColor;
    [underView addSubview:newAddressBtn];
    
    [newAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.right.offset(-50);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    
}

#pragma mark buttonAction
-(void)newAddressAction{
    creatAddressVC *VC = [[creatAddressVC alloc]init];
    [VC setCallback:^(AddressModel *model) {
        
        if (model.isSelect) {
            for (AddressModel *tempModel in _tableViewDataArray) {
                tempModel.isSelect = NO;
            }
        }
//        [_tableViewDataArray addObject:model];
//        [self.tableView reloadData];
        
        //[self prepareData];
        [HttpRequestManager postGetAddressRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *dataArr) {
            _tableViewDataArray = dataArr;
            [self.tableView reloadData];
            if (_tableViewDataArray.count == 1) {//从没有到新添加的
                _callback(dataArr.firstObject);
            }
        }];
    }];
    [self.navigationController pushViewController:VC animated:YES]; 
    
}

/**
 * 编辑地址
 */

-(void)editAddressAction:(UIButton *)btn
{
    
    AddressModel *model = _tableViewDataArray[btn.tag - 100];

    
    creatAddressVC *VC = [[creatAddressVC alloc]init];
    VC.addressVc = self;
    if ([model.ID integerValue] == [_orderAdressId integerValue]  && _orderAdressId) {
        VC.OrderAddressEdit = YES;
    }
    VC.model = model;
    VC.isEdit = YES;
    [VC setCallback:^(AddressModel *model) {
        if (model.isSelect) {
            for (AddressModel *tempModel in _tableViewDataArray) {
                tempModel.isSelect = NO;
            }
            model.isSelect = YES;
        }
        
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 * 删除地址
 */

-(void)deletAddressAction:(UIButton *)btn
{
    
    AddressModel *model = _tableViewDataArray[btn.tag - 1000];
    NSDictionary *dic = @{@"id":model.ID};
    
    [[MyAlert manage] showBtnAlertWithTitle:@"删除地址" detailTitle:@"是否删除地址？" confirm:^{
      
        [HttpRequestManager postDelectAddressRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            if ([data[@"code"] integerValue] == 200) {
                
                [_tableViewDataArray removeObjectAtIndex:btn.tag - 1000];
                
                if (model.isSelect == YES) {//删除的是默认地址
                    if (_tableViewDataArray.count>0) {
                        AddressModel *firstModel = _tableViewDataArray.firstObject;
                        firstModel.isSelect = YES;
                        _defaultAddressModel = firstModel;
                    }
                }
                
                [self.tableView reloadData];
                
                //确认删除收货地址
                if (_tableViewDataArray.count > 0) {//没有收货地址了
                    if ([model.ID isEqual:self.selectedAddressModel.ID]) {
                        _callback(_defaultAddressModel);
                    }
                }else{
                    _callback(nil);
                }
                
            }

        }];
    }];   
}


#pragma mark --tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AddressModel *model = _tableViewDataArray[indexPath.row];
    static NSString *cellid = @"HomeMultCell";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = model;
    if (model.isSelect) {
        _defaultAddressModel = model;
    }
    cell.editButton.tag = 100 + indexPath.row;
    cell.deletButton.tag = 1000 + indexPath.row;

    [cell.editButton addTarget:self action:@selector(editAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deletButton addTarget:self action:@selector(deletAddressAction:) forControlEvents:UIControlEventTouchUpInside];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressModel *model = _tableViewDataArray[indexPath.row];
    if (self.source) {
        //认证审核
        [HttpRequestManager applyForCounselorWithUserId:getUserId andConsignee:model.title andConsigneePhone:model.phone andAddress:[NSString stringWithFormat:@"%@%@",model.address,model.detailAddress] andFinishBlock:^(NSDictionary *dataDic) {
            if (dataDic) {
                AuthSuccessViewController *vc = [[AuthSuccessViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }else{
        
        
        if (_isOrder) {
            _callback(model);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
 
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
    return 110;
}




@end






