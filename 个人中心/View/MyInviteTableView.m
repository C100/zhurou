//
//  MyInviteTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyInviteTableView.h"
#import "MyInvitionModel.h"
#import "UIImageView+WebCache.h"

@implementation MyInviteTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.tableFooterView = [[UIView alloc]init];
        
        self.headView = [[MyInviteHeadView alloc]initWithFrame:CGRectMake(0, 0, 0, 493+64)];
        self.tableHeaderView = self.headView;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *infos = self.infoDic[@"info"];
    return infos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = [UIImage imageNamed:@"我的资金头像"];
        [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        NSArray *infos = self.infoDic[@"info"];
        NSDictionary *infoDic = infos[indexPath.row];
        MyInvitionModel *model = [[MyInvitionModel alloc]initWithInfoDic:infoDic];
        cell.textLabel.text = [NSString stringWithFormat:@"%@(%ld)",model.username,infos.count];
        cell.textLabel.textColor = k404040Color;
        cell.textLabel.font = kFont(16);
        cell.detailTextLabel.textColor = k282828Color;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"加入时间：%@",[LUtils stringToDate:model.ctime]];
        cell.detailTextLabel.font = kFont(14);
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgBase_Url,model.headUrl]] placeholderImage:[UIImage imageNamed:@"我的资金头像"]];
        [Tool setImgurl:cell.imageView imgurl:model.headUrl];
        [cell.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.imageView.mas_right).mas_equalTo(28);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(22);
        }];
        [cell.detailTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.imageView.mas_right).mas_equalTo(28);
            make.top.mas_equalTo(cell.textLabel.mas_bottom).mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(22);
            
        }];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, 25)];
    
    NSArray *infos = self.infoDic[@"info"];
    NSString *title = [NSString stringWithFormat:@"我的邀请人 %ld个",infos.count];
    UILabel *titleLabel = [Tool labelWithTitle:title color:k282828Color fontSize:18 alignment:0];
    [titleLabel sizeToFit];
    [bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(titleLabel.bounds.size.width, 25));
        make.centerY.mas_equalTo(0);
    }];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = kA8A8A8Color;
    [bgView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(titleLabel.mas_left).mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(74, .5));
        make.centerY.mas_equalTo(0);
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = kA8A8A8Color;
    [bgView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_right).mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(74, .5));
        make.centerY.mas_equalTo(0);
    }];
    
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    self.headView.code = infoDic[@"userCode"];
    [self reloadData];
}

-(void)setPersonModel:(PersonalInfoModel *)personModel{
    _personModel = personModel;
    self.headView.personModel = personModel;
    [self reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *infos = self.infoDic[@"info"];
    NSDictionary *infoDic = infos[indexPath.row];
    [self.myInviteTableViewDelegate invitationDetailWithInfos:infoDic];
}

@end
