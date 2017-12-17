//
//  NoticeCenterCell2.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/15.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "NoticeCenterCell2.h"

@implementation NoticeCenterCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(NoticeCenterModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *lab = [Tool labelWithTitle:model.title color:The_TitleColor fontSize:18 alignment:0];
        [self.contentView addSubview:lab];
        
//        CGSize replyTitleSize = [model.detailStr sizeWithFont:[UIFont fontWithName:The_titleFont size:18] maxSize:CGSizeMake(KHScreenW - 120, 20)];

        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(10);
            //make.right.mas_equalTo(-120);
            make.height.mas_equalTo(21);
            make.width.mas_lessThanOrEqualTo(KHScreenW-120);
        }];
        
        
        UIView *yuanView = [[UIView alloc]init];
        [self.contentView addSubview:yuanView];
        [yuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.left.mas_equalTo(lab.mas_right).offset(10);
            make.centerY.mas_equalTo(lab);
        }];
        if ([model.isRead integerValue] == 1) {
            yuanView.backgroundColor = The_list_backgroundColor;
        }else{
            yuanView.backgroundColor = [UIColor redColor];
        }
        yuanView.layer.cornerRadius = 5.0;
        
        
        _timeLab = [Tool labelWithTitle:model.timeStr color:The_wordsColor fontSize:13 alignment:2];
        [self.contentView addSubview:_timeLab];

        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.centerY.mas_equalTo(lab);
            make.right.mas_equalTo(-10);
        }];
        
        _detailLabTitle = [Tool labelWithTitle:model.detailStr color:The_wordsColor fontSize:13 alignment:0];
        
        CGFloat detailHeight = 0;
        detailHeight = model.detailStrHeight;
        [self.contentView addSubview:_detailLabTitle];
        
        if (detailHeight > 35) {
            detailHeight = 35;
        }else
        {
        }
        [_detailLabTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_equalTo(lab.mas_bottom).mas_offset(20);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(detailHeight);
        }];
        
        
        
        
        
        _detailInfoBtn = [UIButton buttonWithTitle:@"查看详情>>>" titleColor:The_MainColor font:[UIFont fontWithName:The_titleFont size:12] target:self action:nil];
        [self.contentView addSubview:_detailInfoBtn];
//        [_detailInfoBtn setImage:[UIImage imageNamed:@"chakanxiangqing.png"] forState:UIControlStateNormal];
//        _detailInfoBtn setTitle:@"cha'kna" forState:<#(UIControlState)#>
        
        [_detailInfoBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_detailInfoBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.height.mas_equalTo(31);
            make.bottom.mas_equalTo(0);
        }];
        
        
      
        
        
        
    }
    
    
    return self;
}


-(void)buttonAction
{
    
}

//- (void)setModel:(QuestionnaireInvestigationModel *)model
//{
//    _model = model;
//    
//}

@end
