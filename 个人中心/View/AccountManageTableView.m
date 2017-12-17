//
//  AccountManageTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/29.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AccountManageTableView.h"

@implementation AccountManageTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.tableFooterView = [[UIView alloc]init];
        self.contents = @[@"手机号", @"邀请码"];
        
        self.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contents.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.textColor = k4D4D4DColor;
        cell.textLabel.font = kFont(15);
        cell.detailTextLabel.textColor = kADADADColor;
        cell.detailTextLabel.font = kFont(15);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.contents[indexPath.row];
    switch (indexPath.row) {
        case 0:
            if (self.personModel.phone) {
                cell.detailTextLabel.text = @"已绑定";
            }else{
                cell.detailTextLabel.text = @"未绑定";
            }
            break;
        case 1:
            if (self.personModel.useInvitationCode&&![self.personModel.useInvitationCode isEqualToString:@""]) {
                cell.detailTextLabel.text = @"已完善";
            }else{
                cell.detailTextLabel.text = @"待完善";
            }
            break;
        default:
            break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.accountManageTableViewDelegate selectIndex:indexPath.row];
}

-(void)setPersonModel:(PersonalInfoModel *)personModel{
    _personModel = personModel;
    [self reloadData];
}

@end
