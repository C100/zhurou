//
//  NewsReplyVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "NewsReplyVC.h"

#import "HBTextView.h"
#import "PlaceholderTextView.h"
#import "PhotoBrowerViewController.h"
#import "UITools.h"

@interface NewsReplyVC ()
{
    HBTextView *textView;
}

@end

@implementation NewsReplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加评论";
    self.view.backgroundColor = The_list_backgroundColor;
    [self configUI];
}
#pragma mark intviewcontroller
-(void)configUI
{
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *titleLab = [Tool labelWithTitle:_detailTitle color:The_TitleColor fontSize:16 alignment:0];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(50);
    }];
    
    textView = [[HBTextView alloc]init];
    textView.borderColor = The_line_Color_grary;
    textView.placeholder = @"请输入评论内容";
    textView.borderWidth = 1;
    textView.origianlOffset = CGPointMake(10, 10);
    textView.font = [UIFont fontWithName:The_titleFont size:15];;
    textView.placeholderColor = The_placeholder_Color_grary;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(ScaleY(130));
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
    }];
    UIBarButtonItem *item = [Tool BarButtonItemWithName:@"提交" font:15 target:self action:@selector(fabuActon)];
    self.navigationItem.rightBarButtonItem = item;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.mas_equalTo(textView.mas_bottom).offset(10);
    }];
 
}

#pragma mark buttonAction

-(void)fabuActon
{
    NSLog(@"发布");
    
    
    if (textView.text.length > 255) {
        
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:[[NSString alloc]initWithFormat:@"最多输入255个文字！当前字数%lu",(unsigned long)textView.text.length]];
        return;
    }
    
    if (textView.text.length == 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请填写评论内容"];
        return;
    }
    
    
    NSDictionary *dic = @{@"commentTypeId":_chuanyiId,
                          @"commentContent":textView.text
                          };
    
    [HttpRequestManager postchuanyiCommentRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
        
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
