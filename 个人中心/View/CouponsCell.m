//
//  CouponsCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/22.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "CouponsCell.h"

@implementation CouponsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _CouponsImageView = [[UIImageView alloc]init];
        _CouponsImageView.image = [UIImage imageNamed:@"youxiaoyouhuiquan@2x.png"];
        [self.contentView addSubview:_CouponsImageView];
        [_CouponsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);

            make.size.mas_equalTo( CGSizeMake( ScalePx(355),ScalePx(82)) );
        }];
        
        
        
        _selectImageView = [[UIImageView alloc]init];
        _selectImageView.image = [UIImage imageNamed:@"xuanzhong3@2x.png"];
        [self.contentView addSubview:_selectImageView];
        [_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            
            make.size.mas_equalTo( CGSizeMake( ScalePx(355),ScalePx(82)) );
        }];
        
        
        _priceLab = [[UILabel alloc]init];
        _priceLab.textAlignment = 1;
        _priceLab.textColor = The_TitleColor;
        [_CouponsImageView addSubview:_priceLab];
        [_priceLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];

        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.top.mas_offset(ScalePx(23));
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(25);
        }];
        
        
        _priceDetailLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:12 alignment:1];
        [_CouponsImageView addSubview:_priceDetailLab];

        [_priceDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.top.mas_equalTo(_priceLab.mas_bottom).offset(5);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(14);
        }];
        
        
        _titleLab = [Tool labelWithTitle:@"" color:The_TitleColor fontSize:15 alignment:1];
        [_CouponsImageView addSubview:_titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(0);
            make.left.mas_offset(20);
            make.top.mas_offset(8);
            make.height.mas_equalTo(17);
        }];
        
        
        
        _timeLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:13 alignment:2];
        [_CouponsImageView addSubview:_timeLab];
        
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.width.mas_equalTo(200);
//            make.top.mas_equalTo(_typeLab.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(15);
            make.bottom.offset(-10);
        }];
        
        _typeLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:13 alignment:2];
        [_CouponsImageView addSubview:_typeLab];
        
        [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.width.mas_equalTo(200);
            make.bottom.mas_equalTo(_timeLab.mas_top).mas_offset(ScalePx(-10));
            make.height.mas_equalTo(15);
        }];


        
        _expireView = [[UIView alloc]init];
        _expireView.backgroundColor = BXAlphaColor(0, 0, 0, 0.1);
        [_CouponsImageView addSubview:_expireView];
        [_expireView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];

        
        _expireIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yiguoqi@2x.png"]];
        [_CouponsImageView addSubview:_expireIconView];
        
        [_expireIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_CouponsImageView);
            make.size.mas_equalTo(CGSizeMake(64, 40));
            make.left.mas_offset(100);
        }];
        
        
        
    }
    
    
    
    
    
    return self;
}


- (void)setModel:(CouponsModel *)model
{
    _model = model;
    NSString *price =[[ NSString alloc]initWithFormat:@"￥%@",model.price];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:price];
    //设置：在0-3个单位长度内的内容显示成红色
    //[str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:15 ] range:NSMakeRange(0, 1)];
    _priceLab.attributedText = str;
    
//    _priceLab.text = model.price;
    _priceDetailLab.text = model.detailPrice;
    
    
    if ([model.detailPrice containsString:@"￥"]) {
        //获取￥所在位置
        NSInteger index = 0;
        for(int i =0; i < [model.detailPrice length]; i++)
        {
            if([[model.detailPrice substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"￥"]){
                index = i;
                break;
            }
            
        }
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"￥" attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        NSString *otherTitle = [model.detailPrice substringFromIndex:index+1];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:otherTitle attributes:@{ NSFontAttributeName:kLightFont(12)}];
        //进行拼接
        if (index>0) {
            NSString *otherTitle2 = [model.detailPrice substringToIndex:index];
            NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:otherTitle2 attributes:@{ NSFontAttributeName:kLightFont(12)}];
            [str3 appendAttributedString:str1];
            [str3 appendAttributedString:str2];
            _priceDetailLab.attributedText = str3;
            
        }else{
            [str1 appendAttributedString:str2];
            _priceDetailLab.attributedText = str1;
        }
        
        
    }

    
    
    
    
    _timeLab.text = model.time;
    _titleLab.text = model.title;
    _typeLab.text = model.type;
    
    if (model.isSelect) {
        _selectImageView.hidden = NO;
    }else
    {
        _selectImageView.hidden = YES;
 
    }
    
    
    //判断是否过期
    if ([_model.voucherStatus integerValue] != 1) {
        
        _CouponsImageView.image = [UIImage imageNamed:@"shixiaoyouhuiquan@2x.png"];
        _expireIconView.hidden = NO;
        _expireView.hidden = NO;
        
    }else
    {
        _CouponsImageView.image = [UIImage imageNamed:@"youxiaoyouhuiquan@2x.png"];
        _expireIconView.hidden = YES;
        _expireView.hidden = YES;

    }
    
    
    //判断是否满足使用条件
    if (model.UnCanUser) {
        _CouponsImageView.image = [UIImage imageNamed:@"shixiaoyouhuiquan@2x.png"];

        _expireView.hidden = NO;
    }else
    {
        _CouponsImageView.image = [UIImage imageNamed:@"youxiaoyouhuiquan@2x.png"];

        _expireView.hidden = YES;
  
    }
    
    
}



@end
