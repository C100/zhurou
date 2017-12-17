//
//  HomeMultCell.m
//  XiJuOBJ
//
//  Created by james on 16/9/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "HomeMultCell.h"

@implementation HomeMultCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleImgView = [[UIImageView alloc]init];
        _titleImgView.frame = CGRectMake(0, 0, KHScreenW, 220);
        [self.contentView addSubview:_titleImgView];
        
        _titleLab = [Tool labelWithTitle:@"" color:The_TitleColor fontSize:16 alignment:0];
        _titleLab.frame = CGRectMake(10, CGRectGetMaxY(_titleImgView.frame) + 10, 200, 18);
        [self.contentView addSubview:_titleLab];
        
        _detailTitleLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:12 alignment:0];
        _detailTitleLab.frame = CGRectMake(10, CGRectGetMaxY(_titleLab.frame) + 10, KHScreenW - 20, 14);
        _detailTitleLab.numberOfLines = 1;
        [self.contentView addSubview:_detailTitleLab];
        
        
        _priceLab = [Tool labelWithTitle:@"" color:The_TitleDeepColor fontSize:16 alignment:2];
        _priceLab.frame = CGRectMake(KHScreenW - 150, CGRectGetMaxY(_titleImgView.frame) + 10, 140, 18);
        [self.contentView addSubview:_priceLab];


    }
    
    return self;
}
- (void)setModel:(HomeModel *)model
{
    _model = model;
    [Tool setImgurl:_titleImgView imgurl:model.titleImgUrl];
    _titleLab.text = model.title;
    _detailTitleLab.text = model.detailTitle;
    _priceLab.text = model.Price;
    
    if ([model.Price containsString:@"￥"]) {
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"￥" attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        NSString *otherTitle = [model.Price substringFromIndex:1];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:otherTitle attributes:@{ NSFontAttributeName:[UIFont fontWithName:The_titleFont size:16]}];
        //进行拼接
        [str1 appendAttributedString:str2];
        _priceLab.attributedText = str1;
    }
}


@end
