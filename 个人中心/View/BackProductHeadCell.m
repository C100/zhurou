//
//  BackProductHeadCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/6.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProductHeadCell.h"
#import "UIImageView+WebCache.h"

@implementation BackProductHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImageView = [[UIImageView alloc]init];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(11);
            make.bottom.mas_equalTo(-11);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        self.moneyLabel = [Tool labelWithTitle:@"" color:k3D3D3DColor fontSize:16 alignment:2];
        self.moneyLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.moneyLabel];
        [self.moneyLabel sizeToFit];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(self.moneyLabel.bounds.size.width, 16));
        }];
        
        self.productLabel = [Tool labelWithTitle:@"" color:k555555Color fontSize:16 alignment:0];
        [self addSubview:self.productLabel];
        [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(20);
            make.top.mas_equalTo(14);
            make.right.mas_equalTo(self.moneyLabel.mas_left).mas_equalTo(-5);
            make.height.mas_equalTo(16);
        }];
        
        self.numLabel = [Tool labelWithTitle:@"" color:k888888Color fontSize:12 alignment:2];
        [self.numLabel sizeToFit];
        [self addSubview:self.numLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.moneyLabel.mas_bottom).mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(self.numLabel.bounds.size.width, 12));
        }];
        
        self.attributeLabel = [Tool labelWithTitle:@"" color:k888888Color fontSize:12 alignment:0];
        [self addSubview:self.attributeLabel];
        [self.attributeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(20);
            make.top.mas_equalTo(self.productLabel.mas_bottom).mas_equalTo(10);
            make.right.mas_equalTo(self.numLabel.mas_left).mas_equalTo(-10);
            make.height.mas_equalTo(12);
        }];
    }
    return self;
}

-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ImgBase_Url,goodsModel.imgUrl]]];
    [Tool setImgurl:self.iconImageView imgurl:goodsModel.imgUrl];
    self.productLabel.text = goodsModel.title;
    self.numLabel.text = [NSString stringWithFormat:@"X%@",goodsModel.number];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[goodsModel.scalePrice floatValue]];
    self.attributeLabel.text = [NSString stringWithFormat:@"%@ | %@",goodsModel.colorName,goodsModel.type];
    [self.numLabel sizeToFit];
    [self.numLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.numLabel.bounds.size.width);
    }];
    [self.attributeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.numLabel.mas_left).mas_equalTo(-10);
    }];
    
    [self.moneyLabel sizeToFit];
    [self.moneyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.moneyLabel.bounds.size.width);
    }];
    [self.productLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.moneyLabel.mas_left).mas_equalTo(-10);
    }];
}

-(void)setBackProModel:(BackProductModel *)backProModel{
    _backProModel = backProModel;
    
    GoodsModel *goodsModel = backProModel.goodsModel;
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ImgBase_Url,goodsModel.imgUrl]]];
    [Tool setImgurl:self.iconImageView imgurl:goodsModel.imgUrl];
    self.productLabel.text = goodsModel.title;
    self.numLabel.text = [NSString stringWithFormat:@"X%@",goodsModel.number];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[goodsModel.scalePrice floatValue]];
    self.attributeLabel.text = [NSString stringWithFormat:@"%@ | %@",goodsModel.colorName,goodsModel.type];
    [self.numLabel sizeToFit];
    [self.numLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.numLabel.bounds.size.width);
    }];
    [self.attributeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.numLabel.mas_left).mas_equalTo(-10);
    }];
    
    [self.moneyLabel sizeToFit];
    [self.moneyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.moneyLabel.bounds.size.width);
    }];
    [self.productLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.moneyLabel.mas_left).mas_equalTo(-10);
    }];
}

@end
