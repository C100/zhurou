//
//  GoodsDetailCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/10/15.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "GoodsDetailCell.h"
#import "CommonModel.h"
#import "GoodsVC.h"
//#import "MBProgressHUD.h"
#import <Lottie/Lottie.h>

@interface GoodsDetailCell()
{
    GoodsDetailModel *_model;
    UIViewController *_vc ;
    CGSize _firstSize;
    CGSize _secondSize;
    CGSize _thirdSize;
    NSString *_firstLoad;
    NSString *_SecLoad;
    NSString *_ThirLoad;
}

@end

@implementation GoodsDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(GoodsDetailModel *)model index:(NSIndexPath *)index uiviewcontroller:(UIViewController *)vc
{
    
    _model = model;
    _vc = vc;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (index.section == 0) {
            [self configTitleView];
        }else if (index.section == 1)
        {
            
            CommonModel *commomModel = _model.goodsArr[index.row];
            [self configGoodsView:commomModel];
            
        }else if (index.section == 2)
        {
            [self configSizeView];
        }else if (index.section == 3)
        {
            [self configParamsView];
        }else if (index.section == 4)
        {
            [self configTuijianView];
        }
        
        
    }
    
    
    return self;
    
}


-(void)configTitleView
{
    UIImageView *titleImg = [[UIImageView alloc]init];
    [Tool setImgurl:titleImg imgurl:_model.titleImg];
    [self.contentView addSubview:titleImg];
    
    
        
    CGSize imageSize = _model.firstSize;
    if (imageSize.width!=0&&imageSize.height!=0) {
        [titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.centerX.mas_equalTo(0);
            if (imageSize.width>KHScreenW) {
                make.height.mas_equalTo(KHScreenW/imageSize.width*imageSize.height);
                make.width.mas_equalTo(KHScreenW);
            }else{
                if (_model) {
                    make.width.mas_equalTo(KHScreenW);
                    make.height.mas_equalTo(KHScreenW/imageSize.width*imageSize.height);
                }else{
                    make.height.mas_equalTo(imageSize.height);
                    make.width.mas_equalTo(imageSize.width);
                }
                
            }
        }];
    }
    
        //    titleImg.image
    NSString *title = _model.title;
    if ([_model.detailTitle isEqualToString:@" "]||_model.detailTitle==nil||[_model.detailTitle isEqualToString:@""]) {
        
    }else{
//        title = [NSString stringWithFormat:@"%@\n%@",_model.title,_model.detailTitle];
    }
    UILabel *titleLab = [Tool labelWithTitle:title color:The_TitleColor fontSize:16 alignment:0];
    self.titleLab = titleLab;
    [self.contentView addSubview:titleLab];
    titleLab.numberOfLines = 0;
    [titleLab sizeToFit];
        [titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.mas_equalTo(titleImg.mas_bottom).offset(0);
            make.height.mas_equalTo(titleLab.bounds.size.height);
            make.width.mas_equalTo(KHScreenW - 60);
//            if ([_model.detailTitle isEqualToString:@" "]||_model.detailTitle==nil||[_model.detailTitle isEqualToString:@""]) {
//                make.bottom.mas_equalTo(-40);
//            }
//            }else{
//                [self.goodsDetailCellDelegate refreshTableView];
//            }
        }];
    
        
        
        _collectBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_collectBtn];
        
        
        if ([_model.isCollection intValue] == 1) {
            
            [_collectBtn setImage:[UIImage imageNamed:@"yishoucang@2x.png"] forState:UIControlStateNormal];
            
        }else
        {
            [_collectBtn setImage:[UIImage imageNamed:@"weishoucang@2x.png"] forState:UIControlStateNormal];
            
        }
    
    
        [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(36, 36));
            make.right.mas_offset(0);
            make.top.mas_equalTo(titleImg.mas_bottom).offset(0);
        }];
        
    
            UILabel *detailLab = [Tool labelWithTitle:_model.detailTitle color:The_wordsColor fontSize:13 alignment:0];
            [self.contentView addSubview:detailLab];
    self.detailLab = detailLab;
            CGSize titlesize =   [_model.detailTitle sizeWithFont:[UIFont fontWithName:The_titleFont size:13] maxSize:CGSizeMake(KHScreenW - 70 , MAXFLOAT)];
    detailLab.numberOfLines = 0;
    [detailLab sizeToFit];
            [detailLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(10);
                make.top.mas_equalTo(titleLab.mas_bottom).offset(5);
                make.right.mas_offset(-60);
                if (![_model.detailTitle isEqualToString:@" "]&&_model.detailTitle&&![_model.detailTitle isEqualToString:@""]) {
                make.height.mas_equalTo(titlesize.height + 5);
                    
                }else{
                    make.height.mas_equalTo(1);
                }
//                make.bottom.mas_equalTo(-40);
            }];

//            [self.goodsDetailCellDelegate refreshTableView];
    
[self setPriceViewWithPrice:_model.price andSclaPrice:_model.scleprice];
    UILabel *sellerNumLabel = [Tool labelWithTitle:[NSString stringWithFormat:@"已售%ld件",_model.sellCommodityNum.integerValue] color:k888888Color fontSize:14 alignment:2];
    [self.contentView addSubview:sellerNumLabel];
    [sellerNumLabel sizeToFit];
    [sellerNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(_collectBtn.mas_bottom).mas_equalTo(3);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(sellerNumLabel.bounds.size.width);
//        make.bottom.mas_equalTo(-15);
    }];
        
        
        
        
        
//    }];
    
    
    
    
}

-(void)setPriceViewWithPrice:(NSString *)price andSclaPrice:(NSString *)sclaPrice{
    NSNumber *pnum = @(price.floatValue);
    NSNumber *scNum = @(sclaPrice.floatValue);
    if ([pnum isEqual:scNum]) {
        self.Lab1 = [Tool labelWithTitle:@"￥0.00" color:The_TitlePayColor fontSize:17 alignment:1];
        self.Lab1.textAlignment = 1;
        
        NSString *titleZongStr = [[NSString alloc]initWithFormat:@"%@￥%@",@"",[Tool priceChange:price] ];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleZongStr];
        [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,@"".length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(@"".length,1)];
        self.Lab1.attributedText = str;
        
        [self.contentView addSubview:self.Lab1];
        [self.Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-10);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.detailLab.mas_bottom).mas_equalTo(10);
//            make.right.mas_equalTo(self.btn2.mas_left);
        }];
        [self.Lab1 sizeToFit];
    }else{
        
        UILabel *scaleLabel = [Tool labelWithTitle:[NSString stringWithFormat:@"￥%@",[Tool priceChange:sclaPrice]] color:[Tool getColorFromHex:@"#CC9C5C"] fontSize:15 alignment:1];
        [self.contentView addSubview:scaleLabel];
        self.scaleLabel = scaleLabel;
        
        NSString *titleZongStr = [[NSString alloc]initWithFormat:@"￥%@",[Tool priceChange:sclaPrice] ];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleZongStr];
        [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,@"".length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(@"".length,1)];
        scaleLabel.attributedText = str;
        [scaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-10);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.detailLab.mas_bottom).mas_equalTo(10);
            //            make.right.mas_equalTo(self.btn2.mas_left);
        }];
        
        
        self.Lab1 = [Tool labelWithTitle:[NSString stringWithFormat:@"%@",[Tool priceChange:price]] color:k888888Color fontSize:13 alignment:1];
        self.Lab1.textAlignment = 1;
        
        [self.contentView addSubview:self.Lab1];
        [self.Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-13);
            make.left.mas_equalTo(scaleLabel.mas_right).offset(5);
            make.height.mas_equalTo(20);
            //            make.right.mas_equalTo(self.btn2.mas_left);
        }];
        
        
        UIView *horView = [[UIView alloc]init];
        horView.backgroundColor = k888888Color;
        [self.Lab1 addSubview:horView];
        [horView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.height.mas_equalTo(1);
            make.left.offset(-2);
            make.right.mas_equalTo(2);
        }];
    }
}

-(void)configGoodsView:(CommonModel *)commonModel
{
    
    self.contentView.backgroundColor = The_list_light_backgroundColor;;
   
    UILabel *titleLab = [Tool labelWithTitle:commonModel.title1 color:The_wordsColor fontSize:13 alignment:0];
    if (![commonModel.title1 isEqualToString:@" "]&&commonModel.title1&&![commonModel.title1 isEqualToString:@""]) {
        [self.contentView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(10);
            make.height.mas_equalTo(commonModel.height + 5);
            make.right.mas_offset(-10);
        }];
    }
    
    UIImageView *titleImg = [[UIImageView alloc]init];
    self.titleImg = titleImg;
//    titleImg.contentMode = 1;
    [Tool setImgurl:titleImg imgurl:commonModel.imgUrl];
    [self.contentView addSubview:titleImg];
     CGSize imageSize = commonModel.secSize;
    if (imageSize.width!=0&&imageSize.height!=0) {
        [titleImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            //        make.left.mas_equalTo(0);
            //        make.right.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            //        make.height.mas_equalTo(ScalePx(195));
            if (imageSize.width>KHScreenW) {
                make.height.mas_equalTo(KHScreenW/imageSize.width*imageSize.height);
                make.width.mas_equalTo(KHScreenW);
            }else{
                if (_model) {
                    make.height.mas_equalTo(KHScreenW/imageSize.width*imageSize.height);
                    make.width.mas_equalTo(KHScreenW);
                }else{
                    make.height.mas_equalTo(imageSize.height);
                    make.width.mas_equalTo(imageSize.width);
                }
                
            }
            
            if (![commonModel.title1 isEqualToString:@" "]&&commonModel.title1&&![commonModel.title1 isEqualToString:@""]) {
                make.top.mas_equalTo(titleLab.mas_bottom).mas_equalTo(10);
            }else{
                make.top.mas_equalTo(10);
            }
            
            make.bottom.mas_equalTo(0);
        }];
    }
    
    
//    }];
    
    
    
    
    
}


-(void)configSizeView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab = [Tool labelWithTitle:@"产品尺寸" color:The_TitleColor fontSize:16 alignment:1];
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    
    UIImageView *sizeimage = [[UIImageView alloc]init];
//    sizeimage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:sizeimage];
    [Tool setImgurl:sizeimage imgurl:_model.chicunImg];
    
    
    
//    if (_ThirLoad==nil) {
//        NSMutableString *tempStr =[[NSMutableString alloc]init];
//        if ( [_model.titleImg hasPrefix:@"http"]) {
//            [tempStr appendFormat:@"%@",_model.chicunImg];
//            
//        }else
//        {
//            [tempStr appendFormat:@"%@%@",ImgBase_Url,_model.chicunImg];
//            
//        }
//        
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:tempStr]];
//        UIImage *image = [UIImage imageWithData:data];
// 
//        _thirdSize = image.size;
//        _ThirLoad = @"";
//    }
//    [self setImgurl:sizeimage imgurl:_model.chicunImg WithFinishBlock:^(CGSize imageSize) {
    CGSize imageSize = _model.thirdSize;
    if (imageSize.width!=0&&imageSize.height!=0) {
        [sizeimage mas_makeConstraints:^(MASConstraintMaker *make) {
            //        make.left.right.mas_offset(0);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(titleLab.mas_bottom).offset(20);
            //        make.height.mas_equalTo(ScalePx(152));
            if (imageSize.width>KHScreenW) {
                make.height.mas_equalTo(KHScreenW/imageSize.width*imageSize.height);
                make.width.mas_equalTo(KHScreenW);
            }else{
                if (_model) {
                    make.height.mas_equalTo(KHScreenW/imageSize.width*imageSize.height);
                    make.width.mas_equalTo(KHScreenW);
                }else{
                    make.height.mas_equalTo(imageSize.height);
                    make.width.mas_equalTo(imageSize.width);
                }
                
            }
            make.bottom.mas_equalTo(-20);
        }];
    }
    

//    }];
    
    
    
    
    
    
}

-(void)configParamsView
{
    UILabel *titleLab = [Tool labelWithTitle:@"产品参数" color:The_TitleColor fontSize:16 alignment:1];
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(10);
        make.height.mas_equalTo(18);
    }];
    
//    if (_model.canshuArr.count == 0) {
//        titleLab.hidden =YES;
//    }
    
    
    CGFloat leftHeight = 0;
    CGFloat rightHeight = 0;
    CGFloat lastHeight = 100;
    CGFloat width = (KHScreenW - 30)/2;
    CGFloat lastY = 0;

    for (int i = 0; i < _model.canshuArr.count; i++) {
        
        CommonModel *model = _model.canshuArr[i];
        
        CGSize titleSize = [model.title2 sizeWithFont:[UIFont fontWithName:@"STHeitiSC-Light" size:13] maxSize:CGSizeMake(KHScreenW/2 - 30, MAXFLOAT)];
        UIView *backView = [[UIView alloc]init];
        [self.contentView addSubview:backView];

        
        [self canshuView:model view:backView];
        
        
        
        if (i%2 == 0) {
            
            leftHeight =titleSize.height;
            
            if (leftHeight > rightHeight) {
                lastHeight = 100 + leftHeight ;
            }else
            {
                lastHeight = 100 + rightHeight ;
 
            }
            
            
            leftHeight = 0;
            rightHeight = 0;
        }else
        {
            rightHeight =titleSize.height;
            
            if (i ==  _model.canshuArr.count - 1) {
               lastHeight =100 + rightHeight ;
            }

        }
        
        backView.frame = CGRectMake(10 + (i%2) * (width + 10), lastY + 38 ,width, lastHeight );

        if (i%2 == 0) {

        }else
        {
            lastY += lastHeight + 10 ;
  
        }

//        backView.backgroundColor = [UIColor yellowColor];
        NSLog(@"%f",CGRectGetMaxY(backView.frame));
        _model.canshuCellHeight = CGRectGetMaxY(backView.frame) + 20 ;
        
    }
    
    
    
}


-(void)canshuView:(CommonModel *)commonModel  view:(UIView *)backView
{
   UIImageView *_iconView = [[UIImageView alloc]init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
//    _iconView.backgroundColor = [UIColor redColor];
    [backView addSubview:_iconView];
    _iconView.contentMode = 1;
    
    if ([commonModel.imgUrl isEqualToString:@""]||commonModel.imgUrl==nil) {
        _iconView.image = [UIImage imageNamed:@"iconLoading"];
    }else{
        [Tool setImgurl:_iconView imgurl:commonModel.imgUrl];
    }
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScalePx(30), ScalePx(30)));
        make.top.mas_offset(10);
        make.centerX.mas_equalTo(backView);
    }];
    
   UILabel *_titleLab = [Tool labelWithTitle:commonModel.title1 color:The_TitleColor fontSize:13 alignment:1];
    _titleLab.font = kLightFont(13);
    [backView addSubview:_titleLab];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(_iconView.mas_bottom).offset(9);
    }];
    
     UILabel *_detailTitleLab = [Tool labelWithTitle:commonModel.title2 color:The_wordsColor fontSize:13 alignment:1];
    [backView addSubview:_detailTitleLab];
    
    CGSize titleSize = [commonModel.title2 sizeWithFont:[UIFont fontWithName:The_titleFont size:13] maxSize:CGSizeMake(KHScreenW/2 - 30, MAXFLOAT)];

    [_detailTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
//        make.bottom.offset(-10);
        make.height.mas_equalTo(titleSize.height + 20);
        make.top.mas_equalTo(_titleLab.mas_bottom).offset(0);
    }];
    

}

-(void)configTuijianView
{
    
    UILabel *titleLab = [Tool labelWithTitle:@"相关推荐" color:The_TitleColor fontSize:16 alignment:1];
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(10);
        make.height.mas_equalTo(18);
    }];
    
//    if (_model.tuijianArr.count == 0) {
//        titleLab.hidden = YES;
//    }
    
    CGFloat width = (KHScreenW - 40)/3;
    for (int i = 0; i < _model.tuijianArr.count; i++) {
        
        CommonModel *commomMond = _model.tuijianArr[i];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [Tool setImgurl:imageView imgurl:commomMond.imgUrl];
        [self.contentView addSubview:imageView];
//        imageView.frame = CGRectMake(10 + (i%3) * (width + 10), 38 + (i/3) * (width + 10), width, width);
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10 + (i%3) * (width + 10));
            make.top.mas_equalTo(38 + (i/3) * (width + 10));
            make.size.mas_equalTo(CGSizeMake(width, width));
            if (i == _model.tuijianArr.count-1) {
                make.bottom.mas_equalTo(0);
            }
        }];
        
        
        imageView.tag = 10000 + i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(tuijianImgAction:)];
        self.userInteractionEnabled = YES;
        imageView.userInteractionEnabled = YES;
        self.contentView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];

        
    }
    
    
}

-(void)tuijianImgAction:(UITapGestureRecognizer *)tap
{
   
    CommonModel *commomMond = _model.tuijianArr[ tap.view.tag - 10000];
    
   
    GoodsVC *vc = [[GoodsVC alloc]init];
    vc.goodIds = commomMond.ID;
    [_vc.navigationController pushViewController:vc animated:YES];

    
}


-(void)setImgurl:(UIImageView *)imgview imgurl:(NSString *)imgurl WithFinishBlock: (void(^)(CGSize))_finshcallback;
{
    NSMutableString *tempStr =[[NSMutableString alloc]init];
    if ( [imgurl hasPrefix:@"http"]) {
        [tempStr appendFormat:@"%@",imgurl];
        
    }else
    {
        [tempStr appendFormat:@"%@/%@",ImgBase_Url,imgurl];
        
    }
//    [imgview sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"wutu@2x.png"]];
    
    [imgview sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"wutu@2x.png"] options:SDWebImageRetryFailed completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType,NSURL *imageUrl){
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        LOTAnimationView *animationView = [LOTAnimationView animationNamed:@"data"];
        animationView.contentMode = UIViewContentModeScaleAspectFit;
        animationView.frame = CGRectMake(0, 200, ScalePx(100), ScalePx(100));
        [[UIApplication sharedApplication].keyWindow addSubview:animationView];
        animationView.center = [UIApplication sharedApplication].keyWindow.center;
        animationView.loopAnimation = YES;
        animationView.animationProgress = 0;
        [animationView play];
        
        CGSize size = image.size;
        _finshcallback(size);
//        [hud hideAnimated:YES];
        animationView.hidden = YES;
        
    }];
    
}

@end
