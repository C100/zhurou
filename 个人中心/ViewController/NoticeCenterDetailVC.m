//
//  NoticeCenterDetailVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/15.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "NoticeCenterDetailVC.h"

@interface NoticeCenterDetailVC ()

@end

@implementation NoticeCenterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"壹筑e家系统消息";
    if (_noticeModel.title ) {
        self.title =_noticeModel.title;

    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    
}

-(void)configUI
{
    UILabel *timeLab = [Tool labelWithTitle:_noticeModel.timeStr color:The_wordsColor fontSize:13 alignment:1];
    [self.view addSubview:timeLab];
    
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(15);
    }];
    
//    UILabel *titleLab = [Tool labelWithTitle:@"尊敬的柚元，您好:" color:The_wordsColor fontSize:13 alignment:0];
//    
//    [self.view addSubview:titleLab];
//    
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.mas_equalTo(timeLab.mas_bottom).offset(10);
//        make.right.mas_offset(-10);
//        make.height.mas_equalTo(15);
//    }];
    
    
    NSString *detailStr = _noticeModel.detailStr;
    UILabel *detailLab = [Tool labelWithTitle:detailStr  color:The_wordsColor fontSize:14 alignment:0];
    
    [self.view addSubview:detailLab];
    
    CGSize replyTitleSize = [detailStr sizeWithFont:[UIFont fontWithName:The_titleFont size:14] maxSize:CGSizeMake(KHScreenW-20, CGFLOAT_MAX)];

    
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_equalTo(timeLab.mas_bottom).offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(replyTitleSize.height + 10);
    }];

    
}

#pragma mark buttonAction
@end
