//
//  ShoppingCartCell.m
//  XiJuOBJ
//
//  Created by james on 16/9/9.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "ShoppingCartCell.h"

@implementation ShoppingCartCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.selectImgView];
        
        
        self.selectBtn = [[UIButton alloc]init];
        [self.contentView addSubview:self.selectBtn];
        
        self.titleImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.titleImgView];

        self.titleLab = [Tool labelWithTitle:@"" color:The_TitleColor fontSize:16 alignment:0];
        [self.contentView addSubview:self.titleLab];

        self.priceLab = [Tool labelWithTitle:@"" color:The_TitleDeepColor fontSize:16 alignment:2];
        [self.contentView addSubview:self.priceLab];
        
        self.typeLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:12 alignment:0];
        [self.contentView addSubview:self.typeLab];

        self.numberLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:12 alignment:2];
        [self.contentView addSubview:self.numberLab];

        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = The_line_Color_grary;
        [self.contentView addSubview:lineView];

        
        UIView *lineView2 = [[UIView alloc]init];
        lineView2.backgroundColor = The_list_backgroundColor;
        [self.contentView addSubview:lineView2];


        self.editButton = [Tool buttonWithTitle:@"" titleColor:[UIColor clearColor] font:0 imageName:nil target:self action:nil];
        [self.contentView addSubview:self.editButton];

        self.deletButton = [Tool buttonWithTitle:@"" titleColor:[UIColor clearColor] font:0 imageName:nil target:self action:nil];
        [self.contentView addSubview:self.deletButton];

        
        [self.selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(14, 14));
            make.top.mas_offset(28);
            make.left.mas_offset(10);
        }];
        
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
            make.width.mas_equalTo(40);
        }];
        
       
        [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(34);
            make.top.mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleImgView.mas_right).offset(10);
            make.top.mas_offset(10);
            make.height.mas_equalTo(@18);
//            make.size.mas_equalTo(CGSizeMake(150, 18));
            make.right.mas_equalTo(self.priceLab.left).offset(-5);
        }];

        WS(ws);
        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(ws.contentView.mas_right).offset(-10);
            make.top.mas_offset(10);
//            make.left.mas_equalTo(ws.titleLab.mas_right);
            make.height.mas_equalTo(@18);
            make.width.mas_equalTo(@100);

        }];

        [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleImgView.mas_right).offset(10);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10);
            make.right.mas_equalTo(self.numberLab.left).offset(-5);
            make.height.mas_equalTo(16);
            
        }];

        [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(ws.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10);
            make.height.mas_equalTo(@18);
            make.width.mas_equalTo(@50);
        }];
//
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.typeLab.mas_bottom).offset(10);
            make.left.mas_equalTo(self.titleImgView.mas_right).offset(15);
            make.height.mas_equalTo(1);
            make.right.mas_offset(-10);
        }];
//
//        self.editButton.backgroundColor = [UIColor redColor];
        [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(ws.contentView.mas_bottom).offset(0);
            make.right.mas_equalTo(self.deletButton.mas_left);
            make.width.mas_equalTo(60);
        }];

//        self.deletButton.backgroundColor = [UIColor yellowColor];
        [self.deletButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(ws.contentView.mas_bottom).offset(0);
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



- (void)setModel:(ShoppingCartModel *)model
{
    _model = model;
    
    if (model.isSelect) {
        self.selectImgView.image = [UIImage imageNamed:@"yigouxuan@2x.png"];
    }else
    {
        self.selectImgView.image = [UIImage imageNamed:@"wancheng@2x.png"];
    }
    [Tool setImgurl:self.titleImgView imgurl:model.titleImgUrl];
    _titleLab.text = model.titleText;
    _priceLab.text = [[NSString alloc] initWithFormat:@"￥%@", model.price ];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_priceLab.text];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,1)];
    _priceLab.attributedText = str;
    
    _typeLab.text = model.type;
    _numberLab.text = [[NSString alloc] initWithFormat:@"x%@", model.number ];
    
    
    
}
@end
