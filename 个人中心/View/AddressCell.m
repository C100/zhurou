//
//  AddressCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.selectImgView];
        
        
        [self.selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.bottom.mas_offset(-20);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        
        _moRenAdressLab = [ Tool labelWithTitle:@"默认地址" color:The_wordsColor fontSize:13 alignment:0];
        [self.contentView addSubview:_moRenAdressLab];

        [_moRenAdressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectImgView.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(60, 15));
            make.bottom.offset(-20);
        }];
        
                
        self.titleLab = [Tool labelWithTitle:@"" color:The_TitleColor fontSize:15 alignment:0];
        [self.contentView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.mas_offset(10);
            make.height.mas_equalTo(@18);
            make.right.mas_equalTo(self.phoneLab.left).offset(-5);
        }];

        
        
        self.phoneLab = [Tool labelWithTitle:@"" color:The_TitleDeepColor fontSize:15 alignment:2];
        [self.contentView addSubview:self.phoneLab];
        [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(90);
            make.top.mas_offset(10);
            make.height.mas_equalTo(@18);
            make.right.mas_offset(-10);
        }];

        
        self.detailAddressLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:15 alignment:0];
        [self.contentView addSubview:self.detailAddressLab];
        [self.detailAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_equalTo(self.phoneLab.mas_bottom).offset(10);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(18);
        }];
        
        
       
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = The_line_Color_grary;
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.detailAddressLab.mas_bottom).offset(10);
            make.left.mas_offset(10);
            make.height.mas_equalTo(1);
            make.right.mas_offset(-10);
        }];

        
        
        
        UIView *lineView2 = [[UIView alloc]init];
        lineView2.backgroundColor = The_list_backgroundColor;
        [self.contentView addSubview:lineView2];
        
        
        self.editButton = [Tool buttonWithTitle:@"" titleColor:[UIColor clearColor] font:0 imageName:nil target:self action:nil];
        [self.contentView addSubview:self.editButton];
        
        self.deletButton = [Tool buttonWithTitle:@"" titleColor:[UIColor clearColor] font:0 imageName:nil target:self action:nil];
        [self.contentView addSubview:self.deletButton];
        
        
              //
        //        self.editButton.backgroundColor = [UIColor redColor];
        [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
            make.right.mas_equalTo(self.deletButton.mas_left);
            make.width.mas_equalTo(60);
        }];
        
        //        self.deletButton.backgroundColor = [UIColor yellowColor];
        [self.deletButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.width.mas_equalTo(60);
        }];
        
        
        UIImageView *editImgView = [[UIImageView alloc]init];
        editImgView.image = [UIImage imageNamed:@"bainji@2x.png"];
        [self.editButton addSubview:editImgView];
        
        UILabel *editLab = [Tool labelWithTitle:@"编辑" color:The_wordsColor fontSize:13 alignment:1];
        [self.editButton addSubview:editLab];
        
        [editImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(14, 14));
            make.top.mas_offset(10);
        }];
        
        
        [editLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(editImgView.mas_right);
            make.right.mas_equalTo( self.editButton.mas_right);
            make.height.mas_equalTo(14);
            make.top.mas_offset(10);
        }];
        
        
        
        UIImageView *deletImgView = [[UIImageView alloc]init];
        deletImgView.image = [UIImage imageNamed:@"shanchu@2x.png"];
        [self.deletButton addSubview:deletImgView];
        
        UILabel *deletLab = [Tool labelWithTitle:@"删除" color:The_wordsColor fontSize:13 alignment:1];
        [self.deletButton addSubview:deletLab];
        
        [deletImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.mas_offset(0);
            make.left.mas_equalTo(self.deletButton.mas_left);
            make.size.mas_equalTo(CGSizeMake(11, 14));
            make.top.mas_offset(10);
        }];
        
        
        [deletLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(deletImgView.mas_right);
            make.right.mas_equalTo(self.deletButton.mas_right);
            make.height.mas_equalTo(14);
            make.top.mas_offset(10);
        }];
        
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.right.mas_offset(0);
            make.top.mas_equalTo(self.deletButton.mas_bottom).mas_offset(-10);
            make.height.mas_equalTo(10);
        }];
        
        
    }
    
    
    return self;
}

- (void)setModel:(AddressModel *)model
{
    _model = model;
    
    
    _titleLab.text = model.title;
    
    if (model.address.length == 0) {
        model.address = @"";
    }
    if (model.detailAddress.length == 0) {
        model.detailAddress = @"";
    }
    _detailAddressLab.text =[ [NSString alloc ] initWithFormat:@"%@%@",model.address,model.detailAddress ];
    
    _phoneLab.text = model.phone;
    
    if (model.isSelect) {
        self.selectImgView.image = [UIImage imageNamed:@"yigouxuan@2x.png"];
        self.selectImgView.contentMode = UIViewContentModeScaleAspectFit;
        self.selectImgView.hidden = NO;
        _moRenAdressLab.hidden = NO;

    }else
    {
        self.selectImgView.image = [UIImage imageNamed:@"wancheng@2x.png"];
        self.selectImgView.hidden = YES;
        _moRenAdressLab.hidden = YES;

    }
    
    
    
    
}


@end
