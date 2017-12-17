//
//  FindDetailCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/10/18.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "FindDetailCell.h"
#import "GoodsVC.h"

@interface FindDetailCell()
{
    FindDetailModel *_model;
    UIViewController *_vc;
}

@end

@implementation FindDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(FindDetailModel *)model index:(NSIndexPath *)index uiviewcontroller:(UIViewController *)vc
{
    _model = model;
    _vc = vc;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (index.section == 0) {
            [self configTitleView];
        }else if (index.section == 1)
        {
            CommonModel *commomModel = _model.contentArr[index.row];
            [self configGoodsView:commomModel];
            
        }else if (index.section == 2)
        {
            self.contentView.backgroundColor = The_list_backgroundColor;
            [self configGoodsList];
        }
        
    }
    return self;
    

}


-(void)configTitleView
{
    UIImageView *titleImg = [[UIImageView alloc]init];
    [Tool setImgurl:titleImg imgurl:_model.titleImg];
    [self.contentView addSubview:titleImg];
    [titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.height.mas_equalTo(ScalePx(220));
    }];
    
    
    UILabel *titleLab = [Tool labelWithTitle:_model.Title color:The_TitleColor fontSize:16 alignment:0];
    [self.contentView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.mas_equalTo(titleImg.mas_bottom).offset(10);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(KHScreenW - 60);
    }];
    
    
//    _collectBtn = [[UIButton alloc]init];
//    [self.contentView addSubview:_collectBtn];
//    
//    [_collectBtn setImage:[UIImage imageNamed:@"weishoucang@2x.png"] forState:UIControlStateNormal];
//    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(36, 36));
//        make.right.mas_offset(0);
//        make.top.mas_equalTo(titleImg.mas_bottom).offset(0);
//    }];
    
    
    UILabel *detailLab = [Tool labelWithTitle:_model.detailTitle color:The_wordsColor fontSize:13 alignment:0];
    [self.contentView addSubview:detailLab];
    
    CGSize titlesize =   [_model.detailTitle sizeWithFont:[UIFont fontWithName:The_titleFont size:13] maxSize:CGSizeMake(KHScreenW - 20 , MAXFLOAT)];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(5);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(titlesize.height + 5);
    }];
    
    UILabel *priceLabel = [Tool labelWithTitle:_model.price color:The_TitleColor fontSize:16 alignment:0];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(titleImg.mas_bottom).offset(10);
        make.height.mas_equalTo(18);
    }];
    
}

-(void)configGoodsView:(CommonModel *)commonModel
{
    
    self.contentView.backgroundColor = The_list_light_backgroundColor;;
    UILabel *titleLab = [Tool labelWithTitle:commonModel.title1 color:The_wordsColor fontSize:13 alignment:0];
    [self.contentView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.height.mas_equalTo(commonModel.height + 5);
        make.right.mas_offset(-10);
    }];
    
    UIImageView *titleImg = [[UIImageView alloc]init];
    [Tool setImgurl:titleImg imgurl:commonModel.imgUrl];
    [self.contentView addSubview:titleImg];
    
    [titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(ScalePx(195));
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
    }];
    
    
}


-(void)configGoodsList
{
    
    CommonModel *commonModel = [[CommonModel alloc]init];
    
    CGFloat width = (KHScreenW - 30)/2;
    CGFloat height = ScalePx(228) ;

    UIView *goodView = nil;
    
    
    for (int i = 0; i < _model.googsArr.count; i++) {
        commonModel = _model.googsArr[i];
        UIView *goodBackView = [[UIView alloc]init];
        [self.contentView addSubview:goodBackView];
        goodBackView.backgroundColor = [UIColor whiteColor];
        
        if (i == 0) {
            
                [goodBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(10 + (i%2) * (width + 10));
                    make.width.mas_equalTo(width);
                    make.height.mas_equalTo(height);
                    make.top.mas_offset(10);
                }];
            
        }else
        {
            if (i%2==0) {
                [goodBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(10 + (i%2) * (width + 10));
                    make.width.mas_equalTo(width);
                    make.height.mas_equalTo(height);
                    make.top.mas_equalTo(goodView.mas_bottom).offset(10);
                }];

            }else
            {
                [goodBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(10 + (i%2) * (width + 10));
                    make.width.mas_equalTo(width);
                    make.height.mas_equalTo(height);
                    make.centerY.mas_equalTo(goodView);
                    //                    make.top.mas_offset(10);
                }];
            }
        }
        goodView = goodBackView;
        [self CreateUI:goodBackView model:commonModel  index:i];
    }
    
    
    
}

- (void)CreateUI:(UIView *)backView model:(CommonModel *)model index:(int)tag
{
    
    CGFloat offset = 35;
    
      UIImageView * _headImageView = [[UIImageView alloc]init];
        _headImageView.frame = CGRectMake(0, offset, ScalePx(172), ScalePx(172) - offset);
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        [Tool setImgurl:_headImageView imgurl:model.imgUrl];
        [backView addSubview:_headImageView];
    
    _headImageView.tag = 10 + tag;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(imgAction:)];
    
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:tap];

//    [_headImageView addTarget:self action:@selector(imgAction:)];
    
      UILabel * nameLable = [Tool labelWithTitle:model.title1 color:The_TitleColor fontSize:15 alignment:1];
        nameLable.frame = CGRectMake(0,CGRectGetMaxY(_headImageView.frame) + 10,ScalePx(172),16);
        [backView addSubview:nameLable];
    self.nameLable = nameLable;

    
    //原价
     UILabel *  priceLab = [Tool labelWithTitle:[[NSString alloc]initWithFormat:@"￥%@",[Tool priceChange:model.price] ]  color:The_wordsColor fontSize:13 alignment:1];
        priceLab.frame = CGRectMake(0,CGRectGetMaxY(_nameLable.frame) + 6,ScalePx(172),16);
    self.priceLab = priceLab;
    [backView addSubview:priceLab];
    
    
    
//    if (!_salePriceLab) {
        _salePriceLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:11 alignment:1];
        [backView addSubview:_salePriceLab];
        _salePriceLab.hidden = YES;
//    }
//    
//    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        [_priceLab addSubview:_lineView];
        _lineView.backgroundColor = k888888Color;
        _lineView.hidden = YES;
//    }
    
    [self setPriceViewWithCommentModel:model];
    
    
    
    /**
     * 当是收藏时显示
     */
    

    UIImageView *heartView = [[UIImageView alloc]init];
    heartView.image = [UIImage imageNamed:@"yishoucang@2x.png"];
    heartView.frame = CGRectMake(CGRectGetWidth(_headImageView.frame)-24, 10, 14, 14);
    [backView addSubview:heartView];
    _headImageView.userInteractionEnabled = YES;
    UIButton *_collectionBtn = [[UIButton alloc]init];
    [backView addSubview:_collectionBtn];
    _collectionBtn.frame = CGRectMake(CGRectGetWidth(_headImageView.frame)-44, 0, 44, 44);
  
    if ([model.type intValue] == 1) {
        heartView.image = [UIImage imageNamed:@"yishoucang@2x.png"];

    }else
    {
        heartView.image = [UIImage imageNamed:@"weishoucang@2x.png"];
    }
    _collectionBtn.tag = 100 + tag;
    [_collectionBtn addTarget:self action:@selector(collectAcstion:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *carView = [[UIImageView alloc]init];
    carView.image = [UIImage imageNamed:@"jiarugouwuche@2x.png"];
    carView.frame = CGRectMake(10, 10, 14, 14);
    [backView addSubview:carView];
    carView.userInteractionEnabled = YES;
    UIButton *carBtn = [[UIButton alloc]init];
    [backView addSubview:carBtn];
    carBtn.frame = CGRectMake(0, 0, 44, 44);
    carBtn.tag = 1000 + tag;
    [carBtn addTarget:self action:@selector(carAction:) forControlEvents:UIControlEventTouchUpInside];

}


-(void)imgAction:(UITapGestureRecognizer *)tap
{
    
    BXLog(@"==%ld",tap.view.tag);
    
    
  CommonModel *  commonModel = _model.googsArr[tap.view.tag - 10];

    GoodsVC *vc = [[GoodsVC alloc]init];
    vc.goodIds = commonModel.ID;
    vc.title = commonModel.title1;
    [_vc.navigationController pushViewController:vc animated:YES];
    
}

-(void)carAction:(UIButton *)btn
{
    _shoppingCarCallback(btn.tag - 1000);
}
-(void)collectAcstion:(UIButton *)btn
{
    _CollectCallback(btn.tag - 100);
}


-(void)setPriceViewWithCommentModel:(CommonModel *)Model{
    NSNumber *pNum = @(Model.price.floatValue);
    NSNumber *scaleNum = @(Model.salePrice.floatValue);
    if ([pNum isEqual:scaleNum]) {
        //原价
        NSString *priceText = [Tool priceChange:Model.price];
        NSMutableAttributedString *symbolStr = [[NSMutableAttributedString alloc]initWithString:@"￥" attributes:@{NSFontAttributeName:kLightFont(13)}];
        NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc]initWithString:priceText attributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:13]}];
        [symbolStr appendAttributedString:moneyStr];
        _priceLab.attributedText = symbolStr;
        
        _priceLab.frame = CGRectMake(0,CGRectGetMaxY(_nameLable.frame) + 6,ScalePx(172),16);
//        _priceLab.textColor = k888888Color;
        
        self.salePriceLab.hidden = YES;
        _lineView.hidden = YES;
        
    }else{
        
        self.salePriceLab.hidden = NO;
//        _priceLab.textColor = The_wordsColor;
        
        //折扣价
        self.salePriceLab.font = [UIFont fontWithName:The_titleFont size:13];
        self.salePriceLab.textColor = [Tool getColorFromHex:@"#CC9C5C"];
        
        //动态获取两个字符串的宽度(原价)
        CGFloat initalPriceWidth = [[NSString stringWithFormat:@"￥%@",[Tool priceChange:Model.price]] boundingRectWithSize:CGSizeMake(1000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:11]} context:nil].size.width;
        
        //折扣价
        CGFloat currentPriceWidth = [[NSString stringWithFormat:@"￥%@",[Tool priceChange:Model.salePrice]] boundingRectWithSize:CGSizeMake(1000, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:13]} context:nil].size.width;
        
        [self.priceLab sizeToFit];
        [self.salePriceLab sizeToFit];
        
        CGFloat margin = (ScalePx(172)-initalPriceWidth-currentPriceWidth-5)/2;
        
        self.salePriceLab.frame = CGRectMake(margin,CGRectGetMaxY(_nameLable.frame) + 6,currentPriceWidth,16);
        self.priceLab.frame = CGRectMake(CGRectGetMaxX(self.salePriceLab.frame)+5, CGRectGetMaxY(_nameLable.frame) + 8, initalPriceWidth, 13);
        
        
        
        //赋值
        NSString *priceText = [Tool priceChange:Model.salePrice];
        NSMutableAttributedString *symbolStr = [[NSMutableAttributedString alloc]initWithString:@"￥" attributes:@{NSFontAttributeName:kLightFont(13)}];
        NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc]initWithString:priceText attributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:13]}];
        [symbolStr appendAttributedString:moneyStr];
        self.salePriceLab.attributedText = symbolStr;
        
        
        
        NSString *initalPriceText = [Tool priceChange:Model.price];
        NSMutableAttributedString *symbolStr2 = [[NSMutableAttributedString alloc]initWithString:@"￥" attributes:@{NSFontAttributeName:kLightFont(11)}];
        NSMutableAttributedString *moneyStr2 = [[NSMutableAttributedString alloc]initWithString:initalPriceText attributes:@{NSFontAttributeName:[UIFont fontWithName:The_titleFont size:11]}];
        [symbolStr2 appendAttributedString:moneyStr2];
        self.priceLab.attributedText = symbolStr2;
        
        _lineView.hidden = NO;
        _lineView.frame = CGRectMake(0, _priceLab.bounds.size.height/2, _priceLab.bounds.size.width, 1);
    }
}


@end

