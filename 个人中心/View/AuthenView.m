//
//  AuthenView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/22.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AuthenView.h"
#define kMargin (KHScreenW-70*3-30*2)/2

@implementation AuthenView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kF5F5F5Color;
        [self setupTopView];
        [self setupApplyButtonView];
    }
    return self;
}

-(void)setupApplyButtonView{
    self.applyButton = [UIButton buttonWithTitle:@"提交申请" titleColor:[UIColor whiteColor] font:kLightFont(14) target:nil action:nil];
    self.applyButton.backgroundColor = The_MainColor;
    [self addSubview:self.applyButton];
    [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-80);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(280, 40));
    }];
}

-(void)setupTopView{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(130);
    }];
    
    
    NSArray *arr = @[@"设计师证书",@"设计师名片",@"营业执照"];
    for (int i = 0; i<arr.count; i++) {
        UIImageView *photoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiangji"]];
        photoImageView.tag = 100+i;
        photoImageView.contentMode = UIViewContentModeScaleAspectFit;
        photoImageView.userInteractionEnabled = YES;
        [bgView addSubview:photoImageView];
        [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30+(70+kMargin)*i);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(70, 60));
        }];
        
        UIButton *deleteButton = [UIButton buttonWithTitle:@"" titleColor:nil font:nil imageName:@"close" target:self action:@selector(deleteImageView:)];
        [bgView addSubview:deleteButton];
        deleteButton.hidden = YES;
        deleteButton.tag = 200+i;
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.size.mas_equalTo(CGSizeMake(14, 14));
            make.left.mas_equalTo(photoImageView.mas_left).mas_equalTo(62);
        }];
        deleteButton.backgroundColor = [UIColor blackColor];
        deleteButton.alpha = .6;
        deleteButton.layer.cornerRadius = 7;
        deleteButton.layer.masksToBounds = YES;
        
        UILabel *titleLabel = [UILabel labelWithTitle:arr[i] color:k888888Color font:kLightFont(14)];
        [bgView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(photoImageView.mas_bottom).mas_equalTo(12);
            make.left.mas_equalTo(photoImageView.mas_left).mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(70, 14));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [photoImageView addGestureRecognizer:tap];
    }

}

-(void)deleteImageView:(UIButton *)sender{
    
}

-(void)tapAction:(UITapGestureRecognizer *)gesture{
    UIImageView *photoImageView = (UIImageView *)gesture.view;
    NSInteger index = photoImageView.tag;
    [self.authenViewDelegate tapImageViewWithTag:index];
    
}

@end
