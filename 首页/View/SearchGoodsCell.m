//
//  SearchGoodsCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/19.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "SearchGoodsCell.h"

@interface SearchGoodsCell()
{
    UIImageView *heartView;
}





@end


@implementation SearchGoodsCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self CreateUI];
    }
    return self;
}

//-(void)layoutSubviews{
- (void)CreateUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    if(!_headImageView){
        _headImageView = [[UIImageView alloc]init];
        _headImageView.frame = CGRectMake(0, 10, ScalePx(172), ScalePx(172));
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_headImageView];
    }
    if(!_nameLable){
        _nameLable = [Tool labelWithTitle:@"" color:The_TitleColor fontSize:15 alignment:1];
        _nameLable.frame = CGRectMake(0,CGRectGetMaxY(_headImageView.frame) + 10,ScalePx(172),16);
        [self.contentView addSubview:_nameLable];
    }
    
    if (!_priceLab) {
        _priceLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:13 alignment:1];
        _priceLab.frame = CGRectMake(0,CGRectGetMaxY(_nameLable.frame) + 6,ScalePx(172),16);
        [self.contentView addSubview:_priceLab];
    }
    
    if (!_initalPriceLab) {
        _initalPriceLab = [Tool labelWithTitle:@"" color:k888888Color fontSize:11 alignment:1];
        [self addSubview:_initalPriceLab];
        _initalPriceLab.hidden = YES;
    }
    
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        [_initalPriceLab addSubview:_lineView];
        _lineView.backgroundColor = k888888Color;
        _lineView.hidden = YES;
    }
    
    /**
     * 当是收藏时显示
     */
    
//    if (_isCollection) {
    
    heartView = [[UIImageView alloc]init];
    heartView.image = [UIImage imageNamed:@"yishoucang@2x.png"];
    heartView.frame = CGRectMake(CGRectGetWidth(_headImageView.frame)-24, 5, 14, 14);
    [self addSubview:heartView];
    heartView.hidden = YES;
    _headImageView.userInteractionEnabled = YES;
    _collectionBtn = [[UIButton alloc]init];
    [self addSubview:_collectionBtn];
    _collectionBtn.frame = CGRectMake(CGRectGetWidth(_headImageView.frame)-44, 0, 44, 44);
    _collectionBtn.hidden = YES;
    
//    }
    
}




-(void)setModel:(SearchGoodsModel *)Model
{
    
    [Tool setImgurl:_headImageView imgurl:Model.imgUrl];
    
    NSNumber *pNum = @(Model.price.floatValue);
    NSNumber *scaleNum = @(Model.initalPrice.floatValue);
    if ([pNum isEqual:scaleNum]) {
        NSString *priceText = [Tool priceChange:Model.price];
        NSMutableAttributedString *symbolStr = [[NSMutableAttributedString alloc]initWithString:@"￥" attributes:@{NSFontAttributeName:kLightFont(13)}];
        NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc]initWithString:priceText attributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:13]}];
        [symbolStr appendAttributedString:moneyStr];
        _priceLab.attributedText = symbolStr;
        
        _priceLab.frame = CGRectMake(0,CGRectGetMaxY(_nameLable.frame) + 6,ScalePx(172),16);
        _priceLab.textColor = k888888Color;
        
        self.initalPriceLab.hidden = YES;
        _lineView.hidden = YES;
        
    }else{
        
        self.initalPriceLab.hidden = NO;
        _priceLab.textColor = The_wordsColor;
        
        //折扣价
        self.priceLab.font = [UIFont fontWithName:The_titleFont size:13];
        self.priceLab.textColor = [Tool getColorFromHex:@"#CC9C5C"];
        
        //动态获取两个字符串的宽度(原价)
        CGFloat initalPriceWidth = [[NSString stringWithFormat:@"￥%@",[Tool priceChange:Model.initalPrice]] boundingRectWithSize:CGSizeMake(1000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:11]} context:nil].size.width;
        
        //折扣价
        CGFloat currentPriceWidth = [[NSString stringWithFormat:@"￥%@",[Tool priceChange:Model.price]] boundingRectWithSize:CGSizeMake(1000, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:13]} context:nil].size.width;
        
        [self.priceLab sizeToFit];
        [self.initalPriceLab sizeToFit];
        
        CGFloat margin = (ScalePx(172)-initalPriceWidth-currentPriceWidth-5)/2;
        
        self.priceLab.frame = CGRectMake(margin,CGRectGetMaxY(_nameLable.frame) + 6,currentPriceWidth,16);
        self.initalPriceLab.frame = CGRectMake(CGRectGetMaxX(self.priceLab.frame)+5, CGRectGetMaxY(_nameLable.frame) + 8, initalPriceWidth, 13);
        
        
 
        //赋值
        NSString *priceText = [Tool priceChange:Model.price];
        NSMutableAttributedString *symbolStr = [[NSMutableAttributedString alloc]initWithString:@"￥" attributes:@{NSFontAttributeName:kLightFont(13)}];
        NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc]initWithString:priceText attributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:13]}];
        [symbolStr appendAttributedString:moneyStr];
        self.priceLab.attributedText = symbolStr;
    
    
        
        NSString *initalPriceText = [Tool priceChange:Model.initalPrice];
        NSMutableAttributedString *symbolStr2 = [[NSMutableAttributedString alloc]initWithString:@"￥" attributes:@{NSFontAttributeName:kLightFont(11)}];
        NSMutableAttributedString *moneyStr2 = [[NSMutableAttributedString alloc]initWithString:initalPriceText attributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:11]}];
        [symbolStr2 appendAttributedString:moneyStr2];
        self.initalPriceLab.attributedText = symbolStr2;
        
        _lineView.hidden = NO;
        _lineView.frame = CGRectMake(0, _initalPriceLab.bounds.size.height/2, _initalPriceLab.bounds.size.width, 1);
    }
    
    
    
    
    _nameLable.text = Model.name;

    if (Model.isCollection) {
        _collectionBtn.hidden = NO;
        heartView.hidden = NO;

    }
    
}



@end
