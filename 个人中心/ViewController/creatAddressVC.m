//
//  creatAddressVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "creatAddressVC.h"

#import "newAddressCell.h"
#import "AddressModel.h"
#import "UITools.h"
@interface creatAddressVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_tableViewDataArray;
    UIImageView *_titleImageView;
    AddressModel *_dataModel;

}


@end

@implementation creatAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_isEdit) {
        self.title = @"编辑地址";

    }else
    {
        self.title = @"新建地址";

    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    if (!_model) {
        _model =[[AddressModel alloc]init];
        
        _dataModel = [[AddressModel alloc]init];
        
    }else
    {
        _dataModel = [[AddressModel alloc]init];
        _dataModel.address = _model.address;
        _dataModel.title = _model.title;
        _dataModel.phone = _model.phone;
        _dataModel.detailAddress =_model.detailAddress;
        _dataModel.isSelect = _model.isSelect;
        _dataModel.ID = _model.ID;
    }

}

-(void)configUI
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64) style:UITableViewStylePlain];
    _tableview.backgroundColor = The_list_backgroundColor;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
    
    
    UIBarButtonItem *save = [Tool BarButtonItemWithName:@"保存" font:15 target:self action:@selector(saveAction)];
    
    
//    UIButton *btn = [[UIButton alloc]init];
//    btn.backgroundColor = [UIColor redColor];
//   UIBarButtonItem * saveAction= [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = save;
    
    
}

#pragma mark buttonAction

-(void)changImg
{
    
    [UITools selectImageFrom:self complete:^(UIImage *img) {
        
        _titleImageView.image = img;
        
    }];
    
    
}


//地区按钮事件
-(void)AreaBtn
{
    [self.view endEditing:YES];
    
    AddressPickView *areaPick = [AddressPickView shareInstance];
    [[[UIApplication sharedApplication] keyWindow]addSubview:areaPick];
    areaPick.block = ^(NSString *province,NSString *city,NSString *town){
        _dataModel.address =[NSString stringWithFormat:@"%@%@%@",province,city,town];
        [_tableview reloadData];
    };
}

//设置为默认地址

-(void)defaultBtnAction
{
//    _dataModel.isSelect = !_dataModel.isSelect;
    _dataModel.isSelect = YES;

    [_tableview reloadData];
    
    
}

-(void)saveAction
{
    NSString *defaultStr = @"0";
    
    [self.view endEditing:YES];
    
    if (_dataModel.title.length == 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"警告" detailTitle:@"收件人不能为空"];
        return;
        
    }
    
    if (_dataModel.address.length == 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"警告" detailTitle:@"省市县不能为空"];
        return;
    }
    
    
    if (_dataModel.phone.length == 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"警告" detailTitle:@"手机号不能为空"];
        return;
        
    }
  
    if (![_dataModel.phone isValidateMobile]) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"警告" detailTitle:@"请输入正确手机号"];
        return;
    }
    
   
    
    if (_dataModel.detailAddress.length == 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"警告" detailTitle:@"详细地址不能为空"];
        return;

    }
    

    
    _model.address = _dataModel.address;
    _model.title = _dataModel.title;
    _model.phone = _dataModel.phone;
    _model.detailAddress =_dataModel.detailAddress;
    _model.isSelect = _dataModel.isSelect;
    _model.ID = _dataModel.ID;

    if (_dataModel.isSelect) {
        defaultStr = @"1";
    }
    if (self.isEdit) {
        NSDictionary *dic = @{@"address":_dataModel.detailAddress,
                              @"mobile":_dataModel.phone,
                              @"name":_dataModel.title,
                              @"isDefault":defaultStr,
                              @"local":_dataModel.address,
                              @"id":_dataModel.ID
                              };
        
        [HttpRequestManager postEditAddressRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            if ([data[@"code"] integerValue] == 200) {
                _callback(_model);
                
                if (_OrderAddressEdit) {
                    _addressVc.callback(_model);
                }
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }];
        
    }else
    {
     

        
        NSDictionary *dic = @{@"address":_dataModel.detailAddress,
                              @"mobile":_dataModel.phone,
                              @"name":_dataModel.title,
                              @"isDefault":defaultStr,
                              @"local":_dataModel.address,
                              
                              };

        [HttpRequestManager postNewAddressRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            if ([data[@"code"] integerValue] == 200) {
                _callback(_model);
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }];
        
    }
    
  
    
}


#pragma mark --tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     newAddressCell*cell= [[newAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newAddressCell" InspectModel:_dataModel IndexPath:indexPath VC:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.addressBtn addTarget:self action:@selector(AreaBtn) forControlEvents:UIControlEventTouchUpInside];
    [cell.defaultBtn addTarget:self action:@selector(defaultBtnAction) forControlEvents:UIControlEventTouchUpInside];

    return cell;
    
    
    
}

//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 0.01;
    }

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
