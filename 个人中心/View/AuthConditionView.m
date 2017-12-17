//
//  AuthConditionTableView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AuthConditionView.h"

@implementation AuthConditionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
        
        self.myTableView = [[UITableView alloc]init];
        [self addSubview:self.myTableView];
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self;
        [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-50);
        }];
        self.myTableView.tableFooterView = [[UIView alloc]init];
        
        self.sureButton = [[UIButton alloc]init];
        [self.sureButton setTitle:@"确认申请" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sureButton.titleLabel.font = kFont(18);
        [self addSubview:self.sureButton];
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        [self.sureButton setBackgroundColor:The_MainColor];
        
        self.contents = @[@"下级购买猪种总额达到10w（11w）",@"自身购买猪种总额达到6w（4W）",@"直推下线人数达到10人（11人）"];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.font = kFont(15);
        cell.textLabel.textColor = k4D4D4DColor;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.contents[indexPath.row];
    NSNumber *isCondition = self.conditions[indexPath.row];
    if (isCondition.intValue==1) {//YES
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"满足"]];
        cell.accessoryView = imageView;
    }else{//NO
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"不满足"]];
        cell.accessoryView = imageView;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 37;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"申请条件";
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = k4D4D4DColor;
    //    view.backgroundColor = [Tool getColorFromHex:@"#f4f4f4"];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.contentView setBackgroundColor:[Tool getColorFromHex:@"#f4f4f4"]];
}

-(void)setAuthModel:(AuthConditionModel *)authModel{
    _authModel = authModel;
    
    self.contents = @[[NSString stringWithFormat:@"下级购买猪种总额达到%dw（%dw）",authModel.expenditureSubLimit.intValue,authModel.expenditureSub.intValue/10000],[NSString stringWithFormat:@"自身购买猪种总额达到%dw（%dW）",authModel.expenditureSelfLimit.intValue,authModel.expenditureSelf.intValue/10000],[NSString stringWithFormat:@"直推下线人数达到%d人（%d人）",authModel.directNuLimit.intValue,authModel.directNu.intValue]];
    
    self.conditions = [NSMutableArray array];
    if (authModel.expenditureSubLimit.intValue>authModel.expenditureSub.intValue/10000) {
        [self.conditions addObject:@(NO)];
    }else{
        [self.conditions addObject:@(YES)];
    }
    
    if (authModel.expenditureSelfLimit.intValue>authModel.expenditureSelf.intValue/10000) {
        [self.conditions addObject:@(NO)];
    }else{
        [self.conditions addObject:@(YES)];
    }
    
    if (authModel.directNuLimit.intValue>authModel.directNu.intValue) {
        [self.conditions addObject:@(NO)];
    }else{
        [self.conditions addObject:@(YES)];
    }
    
    if ([self.conditions containsObject:@(NO)]) {
        [self.sureButton setBackgroundColor:k888888Color];
        self.sureButton.enabled = NO;
    }else{
        [self.sureButton setBackgroundColor:The_MainColor];
        self.sureButton.enabled = YES;
    }
    
    
    [self.myTableView reloadData];
}

@end

