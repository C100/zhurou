//
//  AboutMeVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/21.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "AboutMeVC.h"
#import "XiJuIntroduceVC.h"
#import "GongzhonhaoVC.h"
@interface AboutMeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_tableViewDataArray;
    UIImageView *_titleImageView;
    NSString *_phoneNum;
    
}


@end

@implementation AboutMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    
    
    [HttpRequestManager postGetGongzhonghaoRequest:nil viewcontroller:self finishBlock:^(NSDictionary *data) {
        
        NSDictionary *infoDic = data[@"info"];
        
        //        NSString *ID = infoDic[@"id"];
                NSString *phoneNum = infoDic[@"kfMobile"];
        //        NSString *spreadUrl = infoDic[@"spreadUrl"];
//        NSString *wxPubPic = infoDic[@"wxPubPic"];
//        NSString *wxPubUrl = infoDic[@"wxPubUrl"];
        
        
        _phoneNum = phoneNum;
        
    } andIsShowLoading:YES];

    
}

-(void)configUI
{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
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
    _titleImageView.image = [UIImage imageNamed:@"iicon"];
    [titleView addSubview:_titleImageView];

//    _titleImageView.cornerRadius = 50;
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(40);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_equalTo(titleView.mas_centerX);
    }];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *banben =  [[NSString alloc]initWithFormat:@"壹筑e家 %@",appCurVersion];
    
    UILabel *nameLab = [Tool labelWithTitle:banben color:The_wordsColor fontSize:13 alignment:1];
    [titleView addSubview:nameLab];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(_titleImageView.mas_bottom).mas_offset(10);
    }];

    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"fenxiang@2x.png"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
}

#pragma mark buttonAction

-(void)shareAction
{
    BXLog(@"分享");
    [[Tool tools] appShare:self];

}

#pragma mark --tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.textColor = The_wordsColor;
    
    cell.textLabel.font = [UIFont fontWithName:The_titleFont size:15];
    cell.separatorInset = UIEdgeInsetsMake(10,10,20,0);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"壹筑e家介绍";
                
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"壹筑e家客服";
                
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"壹筑e家公众号";
                
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"壹筑e家微博";
                
            }
                break;
            default:
                break;
        }
    
    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    switch (indexPath.row) {
            case 0:
            {
                XiJuIntroduceVC *vc = [[XiJuIntroduceVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 1:
            {
                
                
                                
              [[MyAlert manage] showBtnAlertWithTitle:@"电话号码" detailTitle:_phoneNum button1Title:@"取消" button2Title:@"拨打" confirm:^{
                  
                  NSString *phone = [[NSString alloc]initWithFormat:@"tel://%@",_phoneNum];
                  
                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];

              }];
                
                

            }
                break;
            case 2:
            {
                GongzhonhaoVC *vc = [[GongzhonhaoVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                
            }
                break;
            default:
                break;
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
    return 44;
}



@end
