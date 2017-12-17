//
//  LCYPreSureView.m
//  XiJuOBJ
//
//  Created by 刘岑颖 on 2017/12/16.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "LCYPreSureView.h"

@interface LCYPreSureView ()

@property (nonatomic, strong) NSArray *leftTitleArray;

@end

@implementation LCYPreSureView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftTitleArray = @[@"认购数量",@"认购月份/总月份",@"认购价格/当前价格",@"到期价格/到期总价格",@"提前交割比例",@"到期交割比例",@"提前交割总额",@"到期交割总额"];
        
        self.backgroundColor = [LUtils colorHex:@"#F5F5F5"];
        [self warningView];
        [self tipLabel];
        [self cancelButton];
        [self sureButton];
        [self contentTableView];
        [self addHeaderViewAction];
        
        [self.warningView.deleteButton addTarget:self action:@selector(deleteWarningViewAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.contentTableView reloadData];
}

- (LCYWarningView *)warningView{
    if (!_warningView) {
        _warningView = [[LCYWarningView alloc] init];
        [self addSubview:_warningView];
        [_warningView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(38);
        }];
    }
    return _warningView;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [self addSubview:_cancelButton];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(KHScreenW/2.0);
        }];
        [_cancelButton setBackgroundColor:[LUtils colorHex:@"#C7C7C7"]];
    }
    return _cancelButton;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        [self addSubview:_sureButton];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.width.mas_equalTo(KHScreenW/2.0);
            make.height.mas_equalTo(50);
        }];
        [_sureButton setBackgroundColor:The_MainColor];
    }
    return _sureButton;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        [self addSubview:_tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(self.warningView.mas_bottom).mas_equalTo(8);
            
        }];
        _tipLabel.text = @"您于2017年5月30日购买的猪种，将以信用额度的形式返回到您的账户中，明细如下";
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [LUtils colorHex:@"#888888"];
    }
    return _tipLabel;
}

- (UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self addSubview:_contentTableView];
        [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.right.mas_equalTo(-8);
            make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_equalTo(5);
            make.bottom.mas_equalTo(-50);
        }];
        _contentTableView.tableFooterView = [UIView new];
        [_contentTableView registerClass:[LCYNormalCell class] forCellReuseIdentifier:@"LCYNormalCell"];
        _contentTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.bounces = NO;
        _contentTableView.backgroundColor = [UIColor clearColor];
    }
    return _contentTableView;
}

- (void)addHeaderViewAction{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KHScreenW - 16, 38)];
    view.backgroundColor = [UIColor whiteColor];
    self.contentTableView.tableHeaderView = view;
    
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [LUtils colorHex:@"#555555"];
    label.text = @"产品名称";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(12);
    }];
    self.nameLabel = label;
    
    UIView *lineView = [[UIView alloc] init];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(2);
        make.right.mas_equalTo(-2);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    lineView.backgroundColor = [LUtils colorHex:@"#DDDDDD"];
}

#pragma mark - Methods ---------------

- (void)deleteWarningViewAction{
    self.warningView.hidden = YES;
    
    [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(0);
    }];
}

#pragma mark - UITableViewDelegate --------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LCYNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCYNormalCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[LCYNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LCYNormalCell"];
    }
    
    cell.leftLabel.text = self.leftTitleArray[indexPath.row];
    cell.rightLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

@end
