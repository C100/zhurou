//
//  BackProductTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/6.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProductTableView.h"
#import "BackProductHeadCell.h"
#import "BackProductOrderNumCell.h"
#import "BackProductInstructCell.h"

@implementation BackProductTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
        
        self.tableFooterView = [[UIView alloc]init];
        self.estimatedRowHeight = 60;
        
        //注册
        [self registerClass:[BackProductHeadCell class] forCellReuseIdentifier:@"BackProductHeadCell"];
        [self registerClass:[BackProductOrderNumCell class] forCellReuseIdentifier:@"BackProductOrderNumCell"];
        [self registerClass:[BackProductInstructCell class] forCellReuseIdentifier:@"BackProductInstructCell"];
        self.isNeedLogNum = NO;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isNeedLogNum == YES) {
        return 5;
    }else{
        return 3;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isNeedLogNum==YES) {
        if (indexPath.row==0) {
            BackProductHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackProductHeadCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.goodsModel = self.goodsModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }else if (indexPath.row == 1){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell1"];
                cell.textLabel.font = kFont(14);
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = k888888Color;
                cell.detailTextLabel.textColor = k888888Color;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textLabel.text = @"物流公司";
            
            return cell;
        }else if (indexPath.row==2){
            BackProductOrderNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackProductOrderNumCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }else if (indexPath.row==3){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
                cell.textLabel.font = kFont(14);
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = k888888Color;
                cell.detailTextLabel.textColor = k888888Color;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.textLabel.text = @"退款金额";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2f",self.backPrice];
            
            return cell;
        }else{
            BackProductInstructCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackProductInstructCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }
    }else{
        if (indexPath.row==0) {
            BackProductHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackProductHeadCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.goodsModel = self.goodsModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row==1){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
                cell.textLabel.font = kFont(14);
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = k888888Color;
                cell.detailTextLabel.textColor = k888888Color;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor whiteColor];
            }
            cell.textLabel.text = @"退款金额";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2f",self.backPrice];
            
            return cell;
        }else{
            BackProductInstructCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackProductInstructCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, 100)];
    bgView.backgroundColor = [UIColor clearColor];
    UILabel *insLabel = [Tool labelWithTitle:@"退换货说明\n1.商品寄回地址\n2.退换货说明" color:k888888Color fontSize:12 alignment:0];
    [bgView addSubview:insLabel];
    insLabel.frame = CGRectMake(15, 18, KHScreenW-20, 80);
    
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    [self reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isNeedLogNum==YES) {
        if (indexPath.row==1) {//物流公司
            [self.backProductTableViewDelegate chooseCompany];
        }
    }
}

@end
