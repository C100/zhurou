//
//  FeedbackVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/9.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "FeedbackVC.h"
#import "HBTextView.h"
#import "PlaceholderTextView.h"
#import "PhotoBrowerViewController.h"
#import "UITools.h"

@interface FeedbackVC ()
{
    NSMutableArray *_imagsArray;
    UIView *_ImageBackView;
}

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = The_list_backgroundColor;
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    _imagsArray = [[NSMutableArray alloc]init];
}

-(void)configUI
{
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *titleLab = [Tool labelWithTitle:@"我们重视您的每一个反馈，您的建议和批评是对壹筑e家最大的支持，是我们对产品的优化改造的方向和动力！" color:The_TitleColor fontSize:14 alignment:0];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(50);
    }];
    
    HBTextView *textView = [[HBTextView alloc]init];

    textView.borderColor = The_line_Color_grary;
    textView.placeholder = @"请输入评论内容";
    textView.borderWidth = 1;
    textView.origianlOffset = CGPointMake(10, 10);

    textView.font = [UIFont fontWithName:The_titleFont size:13];;
    textView.placeholderColor = The_placeholder_Color_grary;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(ScaleY(130));
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
    }];
    
    _ImageBackView = [[UIView alloc]init];
    [self.view addSubview:_ImageBackView];
    [_ImageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textView.mas_bottom).offset(10);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(100);
    }];
    
    int width = (KHScreenW - scale_X * 200 ) / 3;
    if (KHScreenW ==414 ) {
        width = 100;
    }
    
    NSLog(@"%f",KHScreenW);
    for (int i = 0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10 + (width + scale_X * 60)* i,0, width, width)];
        [btn setImage:[UIImage imageNamed:@"xiangji.png"] forState:UIControlStateNormal];
        [_ImageBackView addSubview:btn];
        btn.tag = 1000 + i;
        //        [self adddottedLine:btn];
        [btn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = i != 0;
    }

  
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.mas_equalTo(_ImageBackView.mas_bottom).offset(10);
    }];
    
}

#pragma mark buttonAction
#pragma mark buttonAction

-(void)sancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
//选中图片开启图片浏览
-(void)selectImage:(UIButton *)btn
{
    
    [self.view endEditing:YES];
    NSInteger index = btn.tag - 1000;
    if (index < _imagsArray.count) {
        PhotoBrowerViewController *vc = [[PhotoBrowerViewController alloc]init];
        vc.index = index;
        vc.imagesArray = _imagsArray;
        vc.canDelete = YES;
        [vc setDeleteBlock:^(NSInteger index) {
            [self refreshImagesView];
        }];
        
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    [UITools selectImageFrom:self complete:^(UIImage *img) {
        [btn setImage:img forState:UIControlStateNormal];
        [_imagsArray addObject:img];
        [self refreshImagesView];
    }];
    
}
-(void)refreshImagesView
{
    for (int i = 0; i<3; i++) {
        UIButton *btn = _ImageBackView.subviews[i];
        
        btn.hidden =  btn.tag - 1000 > _imagsArray.count;
        UIImage *img;
        if (i >= _imagsArray.count) {
            img = [UIImage imageNamed:@"xiangji.png"];
        }
        else
        {
            img = _imagsArray[i];
        }
        [btn setImage:img forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
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
