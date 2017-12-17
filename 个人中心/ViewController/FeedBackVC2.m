//
//  FeedBackVC2.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/12.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "FeedBackVC2.h"
#import "HBTextView.h"
#import "PlaceholderTextView.h"
#import "PhotoBrowerViewController.h"
#import "UITools.h"
@interface FeedBackVC2 ()<UITextViewDelegate>
{
    HBTextView *mytextView;
    UILabel *textNumLabel;
}
@end

@implementation FeedBackVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = The_list_backgroundColor;
    [self configUI];
}

#pragma mark UITextView
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length<=200) {
        textNumLabel.text = [NSString stringWithFormat:@"%ld/200",textView.text.length];
    }else{
        textView.text = [textView.text substringToIndex:200];
    }
    
}

#pragma mark intviewcontroller
-(void)configUI
{
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *titleLab = [Tool labelWithTitle:@"我们重视您的每一个反馈，您的建议和批评是对壹筑e家最大的支持，是我们对产品的优化改造的方向和动力！" color:The_TitleColor fontSize:16 alignment:0];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(60);
    }];
    
    mytextView = [[HBTextView alloc]init];
    
    mytextView.borderColor = The_line_Color_grary;
    mytextView.placeholder = @"请输入评论内容";
    mytextView.delegate = self;
    mytextView.borderWidth = 1;
    mytextView.origianlOffset = CGPointMake(10, 10);
    
    mytextView.font = [UIFont fontWithName:The_titleFont size:15];;
    mytextView.placeholderColor = The_placeholder_Color_grary;
    [self.view addSubview:mytextView];
    mytextView.backgroundColor = [UIColor clearColor];
    [mytextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(ScaleY(130));
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
    }];
    
    
    textNumLabel = [UILabel labelWithTitle:@"0/200" color:kccccccColor font:kLightFont(12)];
//    textNumLabel.backgroundColor = [UIColor redColor];
    [backView addSubview:textNumLabel];
    [textNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(-25);
        make.height.mas_equalTo(12);
//        make.width.mas_equalTo(100);
    }];
    
    [backView bringSubviewToFront:textNumLabel];
    
    UIBarButtonItem *item = [Tool BarButtonItemWithName:@"提交" font:15 target:self action:@selector(fabuActon)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.mas_equalTo(mytextView.mas_bottom).offset(10);
    }];
    
    
    
    
    
    
}

#pragma mark buttonAction

-(void)fabuActon
{
    NSLog(@"发布");
    if (mytextView.text.length==0) {
//        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"反馈内容不能为空！"];
        return;
    }
    if (mytextView.text.length > 200) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"反馈内容字数不能超过200个！"];
        return;
    }
    NSDictionary *dic = @{@"content":mytextView.text,
                          };
    
    [HttpRequestManager postFeedBackAddRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"反馈提交成功！"];

        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

@end
