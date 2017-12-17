//
//  PersonalInfoVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/23.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "PersonalInfoModel.h"
#import "PersonalCell.h"
#import "UITools.h"
#import "AddressManagerVC.h"
#import "AddressModel.h"
#import "NameChangeVC.h"
#import "BindingPhoneVC.h"
@interface PersonalInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_tableViewDataArray;
    UIImageView *_titleImageView;
//    PersonalInfoModel *_model;
    
}


@end

@implementation PersonalInfoVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self prepareData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
  
    [HttpRequestManager postMyInfoRequest:nil viewcontroller:self finishBlock:^(NSDictionary *data) {
        
        _model.imgUrl = data[@"headUrl"];
        _model.name = data[@"username"];
        _model.phone = data[@"mobile"];
        _model.userCode = data[@"userCode"];
        _model.money = data[@"money"];
        _model.useInvitationCode = [data objectForKey:@"useInvitationCode"];
        [Tool setImgurl:_titleImageView imgurl:data[@"headUrl"]];
        if (_model.areaImg) {
            _titleImageView.image = _model.areaImg;
        }

        //        _nameLab.text = data[@"mobile"];
        
    }];

    
    [HttpRequestManager postGetAddressRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *arr) {
        for ( AddressModel *model in arr) {
            if (model.isSelect) {
                
                _model.address = [[NSString alloc] initWithFormat:@"%@%@", model.address,model.detailAddress];
            }
        }
        
        if (arr.count == 0) {
            _model.address = @"未设置";
        }
        [_tableview reloadData];

    }];
    
}

-(void)configUI
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64) style:UITableViewStylePlain];
    _tableview.backgroundColor = The_list_backgroundColor;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
    
    /**
     * 创建头视图
     */
    UIView *titleView = [[UIView alloc]init];
    titleView.height = 184;
    titleView.backgroundColor = [UIColor whiteColor];
    _tableview.tableHeaderView = titleView;
    
    
    _titleImageView = [[UIImageView alloc]init];
//    _titleImageView.image = [UIImage imageNamed:@"LOGO1@2x.png"];
    [Tool setTouxiangImgurl:_titleImageView imgurl:_model.imgUrl];
//    _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    if (_model.areaImg) {
        _titleImageView.image = _model.areaImg;
    }
    
    [titleView addSubview:_titleImageView];
    [_titleImageView addTarget:self action:@selector(changImg)];
    
    
    _titleImageView.layer.cornerRadius = 50;
    _titleImageView.layer.masksToBounds=true;
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(40);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_equalTo(titleView.mas_centerX);
    }];
    
    UILabel *nameLab = [Tool labelWithTitle:@"点击更换头像" color:The_wordsColor fontSize:13 alignment:1];
    [titleView addSubview:nameLab];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(_titleImageView.mas_bottom).mas_offset(10);
    }];
    
    
    
    UIBarButtonItem *save = [Tool BarButtonItemWithName:@"完成" font:15 target:self action:@selector(saveAction)];
    
      self.navigationItem.rightBarButtonItem = save;
    
    
}

#pragma mark buttonAction
-(void)saveAction
{
    
  
   
    [HttpRequestManager postUpdateUserImgRequest:_titleImageView.image viewcontroller:self finishBlock:^(NSDictionary *data) {
        if ([data[@"code"] intValue] == 200) {
            
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提示" detailTitle:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}


-(void)changImg
{
    
//    [UITools selectImageFrom:self complete:^(UIImage *img) {
//        
////        _titleImageView.image = img;
//        
//        [_titleImageView setImage:img];
//        
//    }];
 
    
    [UITools selectImageForEditFrom:self complete:^(UIImage *origionImg, UIImage *editedImage) {
        _model.areaImg = editedImage;
        _titleImageView.image = editedImage;

    }];
    
    
}


//地区按钮事件
-(void)AreaBtn
{
    
    AddressManagerVC  *vc = [[AddressManagerVC alloc]init];
    [vc setCallback:^(AddressModel *model) {
//        _model.AddressModel = model;//在地址管理中点击某个地址 / 删除的地址与该页地址不一致
//        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
//    AddressPickView *areaPick = [AddressPickView shareInstance];
//    [[[UIApplication sharedApplication] keyWindow]addSubview:areaPick];
//    areaPick.block = ^(NSString *province,NSString *city,NSString *town){
//        _model.address =[NSString stringWithFormat:@"%@%@%@",province,city,town];
//      
//        [_tableview reloadData];
//    };
}
-(void)nameAction
{
    NameChangeVC *vc = [[NameChangeVC alloc]init];
    vc.name = _model.name;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)phoneAction
{
    BindingPhoneVC *vc = [[BindingPhoneVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark --tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PersonalCell *cell= [[PersonalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalCell" InspectModel:_model IndexPath:indexPath VC:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.nameBtn addTarget:self action:@selector(nameAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.phoneBtn addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];

    [cell.addressBtn addTarget:self action:@selector(AreaBtn) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
    
    
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
    return 44;
}


@end
