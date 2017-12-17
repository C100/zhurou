//
//  ChooseCompanyViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/15.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ChooseCompanyViewController.h"

@interface ChooseCompanyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSArray *companys;
@property(nonatomic, strong) NSDictionary *companyNumDic;

@end

@implementation ChooseCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"物流公司";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    self.companys = @[@"顺丰速运",@"百世快递",@"中通快递",@"申通快递",@"圆通速递",@"韵达速递",@"邮政快递包裹",@"EMS",@"天天快递",@"京东物流",@"全峰快递",@"国通快递",@"优速快递",@"德邦",@"快捷快递",@"亚马逊",@"宅急送"];
    self.companyNumDic = @{@"顺丰速运":@"SF",
                           @"百世快递":@"HTKY",
                           @"中通快递":@"ZTO",
                           @"申通快递":@"STO",
                           @"圆通速递":@"YTO",
                           @"韵达速递":@"YD",
                           @"邮政快递包裹":@"YZPY",
                           @"EMS":@"EMS",
                           @"天天快递":@"HHTT",
                           @"京东物流":@"JD",
                           @"全峰快递":@"QFKD",
                           @"国通快递":@"GTO",
                           @"优速快递":@"UC",
                           @"德邦":@"DBL",
                           @"快捷快递":@"FAST",
                           @"亚马逊":@"AMAZON",
                           @"宅急送":@"ZJS"
                           
                           };
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.companys.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.textLabel.textColor = k888888Color;
        cell.textLabel.font = kFont(14);
    }
    cell.textLabel.text = self.companys[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *company = self.companys[indexPath.row];
    NSString *num = self.companyNumDic[company];
    _callBack(company,num);
    [self.navigationController popViewControllerAnimated:YES];
}


@end
