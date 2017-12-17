//
//  ShoppingCarDetailView.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/12.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "GoodsDetailView.h"
#import "PPNumberButton.h"
#import "ShoppingCarUnderView.h"
#import "ShoppingGoodsModel.h"
#import "GoodsModel.h"
#import "OrderVC.h"
#import "OrderDetailVC.h"
@interface GoodsDetailView()<UITextFieldDelegate>
{
    NSMutableArray *_ColorBtnArr;
    NSMutableArray *_typeBtnArr;
    UIImageView *_titleImageView;
    GoodsModel *_selectModel;
    ShoppingCarUnderView *underView;
    
    UIView *backView;
    BOOL _isSelectedColor;
    BOOL _isSelectedType;
    UILabel *_selectedColorLabel;
}

@end


@implementation GoodsDetailView

-(void)configUI
{
    _isSelectedType = NO;
    _isSelectedColor = NO;
    _ColorBtnArr = [[NSMutableArray alloc]init];
    _typeBtnArr = [[NSMutableArray alloc]init];
    
    if (!_selectModel) {
//        [[_Model.price integerValue]  * 0.01]
       _selectModel.price = [[NSString alloc]initWithFormat:@"%f",[_Model.originalPrice integerValue]  * 0.01 ];
        _selectModel.scalePrice = [[NSString alloc]initWithFormat:@"%f",[_Model.price integerValue]  * 0.01 ];
        _selectModel = [[GoodsModel alloc]init];
//        _selectModel.price = _Model.price[];
        _selectModel.number = @"1";
        _selectModel.title = _Model.titleText;
        _selectModel.goodsId = _Model.goodsId;
    }
//
//    
//    [backView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(176);
//        
//    }];
    
  
//    [backView layoutIfNeeded];

    
    
    UIButton *hiddenBtn = [[UIButton alloc]init];
    [hiddenBtn addTarget:self action:@selector(hiddenViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hiddenBtn];
    [hiddenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
//        make.bottom.mas_equalTo(backView.mas_top);
        make.height.mas_equalTo(176);
    }];
    
    
    backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.cornerRadius = 8;
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(0);
        
        make.size.mas_equalTo(CGSizeMake(KHScreenW, KHScreenH - 176));
        
        
        make.top.mas_equalTo(KHScreenH );
        
        
    }];
    
    [backView layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        backView.transform = CGAffineTransformMakeTranslation(0,  - KHScreenH + 176);//xy移动距离
        [backView layoutIfNeeded];
        
        
    }];
    
    _titleImageView = [[UIImageView alloc]init];
    _titleImageView.contentMode = 1;
    ShoppingGoodsModel *goodTempModel = [[ShoppingGoodsModel alloc]init];
    if (self.Model.modelArr.count >0) {
        goodTempModel= self.Model.modelArr[0];
    }

    //goodTempModel.titleImg
    if (self.shoppingCarEdit) {
        [Tool setImgurl:_titleImageView imgurl:goodTempModel.titleImg];
    }else{
        [Tool setImgurl:_titleImageView imgurl:self.Model.smallUrl];
    }
    
    [backView addSubview:_titleImageView];
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(81, 81));
    }];

    UILabel *titleLab = [Tool labelWithTitle:self.Model.titleText color:The_TitleColor fontSize:16 alignment:0];
    [backView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleImageView.mas_right).mas_offset(10);
        make.top.mas_offset(20);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(18);
    }];
    
    UILabel *detailTitleLab = [Tool labelWithTitle:self.Model.type color:The_wordsColor fontSize:13 alignment:0];
    [backView addSubview:detailTitleLab];
    [detailTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(18);
    }];

    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = The_line_Color_grary;
    [backView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_equalTo(_titleImageView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
        make.right.mas_offset(-10);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [backView addSubview:scrollView];
//    scrollView.frame = CGRectMake(0, 83 + 176, KHScreenW, backView.height-83-40);
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom);
        make.right.left.mas_offset(0);
        make.bottom.mas_offset(-40);
    }];
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    
    //scrollVie内部布局
    
    UILabel *shuliangLab = [Tool labelWithTitle:@"数量" color:The_TitleColor fontSize:15 alignment:0];
    [container addSubview:shuliangLab];
    
    [shuliangLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.mas_offset(20);
        make.height.mas_equalTo(16);
    }];
    
    PPNumberButton *numberButton = [[PPNumberButton alloc] initWithFrame: CGRectMake(10, CGRectGetMaxY(shuliangLab.frame) + 36, 160, 40)];
    numberButton.borderColor = The_line_Color_grary;
    numberButton.shakeAnimation = YES;
    numberButton.numberBlock = ^(NSString *num){
        _selectModel.number = num;
        CGFloat price = [_selectModel.price floatValue];
        CGFloat scaleprice = [_selectModel.scalePrice floatValue];
        //_selectedModel.scalePrice
        CGFloat tempprice = [_selectModel.number floatValue] * price ;
        if (tempprice > 0) {
            underView.Lab1.text = [[NSString alloc]initWithFormat:@"￥%0.2f",tempprice];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:underView.Lab1.text];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,1)];
            underView.Lab1.attributedText = str;
            underView.scaleLabel.text = [[NSString alloc]initWithFormat:@"￥%0.2f",scaleprice*[_selectModel.number floatValue]];
            [underView.scaleLabel sizeToFit];
            [underView.scaleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-13);
                make.left.mas_equalTo(15);
                make.width.mas_equalTo(underView.scaleLabel.bounds.size.width+40);
                make.height.mas_equalTo(20);
            }];
        }
    };
    NSNumber *num = @(_selectModel.number.integerValue);
    numberButton.textField.text = [num stringValue];
    
    numberButton.textField.delegate = self;
    
    
    [container addSubview:numberButton];

    
    UILabel *colorLab = [Tool labelWithTitle:@"颜色" color:The_TitleColor fontSize:15 alignment:0];
    [container addSubview:colorLab];
    [colorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
//        make.right.mas_offset(-10);
        make.top.mas_equalTo(shuliangLab.mas_bottom).mas_offset(70);
        make.height.mas_equalTo(16);
    }];
    
    
    _selectedColorLabel = [Tool labelWithTitle:@"" color:The_TitleColor fontSize:15 alignment:0];
    [container addSubview:_selectedColorLabel];
    [_selectedColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(colorLab.mas_right).mas_equalTo(10);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(shuliangLab.mas_bottom).mas_offset(70);
    }];
    
    
    if (self.shoppingCarEdit) {
        _selectedColorLabel.text = _selectModel.colorName;
    }

    
    /**
     * 颜色按钮布局
     */
    
    CGFloat colorWidth = 40 - 8;
//    CGFloat spaceWith = (KHScreenW-30-8-colorWidth*6)/5;
    
    UIView *lastView= nil;
    
    
    for (int i = 0; i < self.Model.colorArr.count; i++) {
        if (!self.Model.colorArr[i]) {
            return;
        }
        
        UIView *colorView = [[UIView alloc]init];
//        colorView.alpha = 0.4;
        colorView.backgroundColor = [Tool getColorFromHex:self.Model.colorArr[i]];
        [container addSubview:colorView];
        
        [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(colorWidth, colorWidth));
            make.top.mas_equalTo(colorLab.mas_bottom).with.offset(14 +(14 + colorWidth)*(i/6));
            if (i%6 == 0) {
                make.left.mas_offset(14);
            }else
            {
                make.left.mas_equalTo(lastView.mas_right).with.offset(18);
  
            }
        }];
        
        lastView =colorView;
        
        UIButton *colorBtn  = [UIButton buttonWithTitle:@"" titleColor:nil font:nil imageName:nil target:self action:nil backImageName:nil layerColor:@[@221,@221,@221] borderWidth:1 CornerRadius:0];
        colorBtn.tag = 100+i;
        [container addSubview:colorBtn];
//        colorBtn.alpha = 0.4;
        
        
        [colorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lastView.mas_left).mas_offset(-4);
            make.top.mas_equalTo(lastView.mas_top).mas_offset(-4);
            make.size.mas_equalTo(CGSizeMake(colorWidth + 8, colorWidth + 8));

        }];

        
        [_ColorBtnArr addObject:colorBtn];
        [colorBtn setBackgroundImage:[UIImage imageNamed:@"xuanzhong1@2x.png"] forState:UIControlStateSelected];
        [colorBtn addTarget:self action:@selector(colorSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if ([self.Model.colorArr[i] isEqualToString:_selectModel.color]) {
            //            colorBtn.selected = YES;
            [self btnIsSelect:colorBtn];
            _isSelectedColor = YES;
//            [self colorSelectAction:colorBtn];
        }
//        if (self.Model.colorArr.count==1) {
////            colorBtn.selected = YES;
//            
//            [self colorSelectAction:colorBtn];
//        }

    }
    

    
    
    /**
     * 类型按钮布局
     */
    
    UIButton *lastColorBtn = [_ColorBtnArr lastObject];

    UILabel *typeLab = [Tool labelWithTitle:@"类型" color:The_TitleColor fontSize:15 alignment:0];
    [container addSubview:typeLab];
    
    [typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        if (lastColorBtn) {
            make.top.mas_equalTo(lastColorBtn.mas_bottom).offset(20);
        }else{
            make.top.mas_equalTo(colorLab.mas_bottom).mas_offset(20);
        }
        
        make.height.mas_equalTo(16);
    }];

    
    CGFloat TypeWidth = 80;
    CGFloat TypeHeight = 40;
    UIButton *lastBtn = nil;
//    CGFloat typeSpaceWith = (KHScreenW-30-colorWidth*3)/2;
    
    for (int i = 0; i < self.Model.typeArr.count; i++) {
        UIButton *typeBtn  = [UIButton buttonWithTitle:nil titleColor:The_wordsColor font:nil imageName:nil target:self action:nil backImageName:nil layerColor:@[@221,@221,@221] borderWidth:1 CornerRadius:0];
        typeBtn.tag = 1000+i;
        [container addSubview:typeBtn];
        
        [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(TypeWidth, TypeHeight));
            make.top.mas_equalTo(typeLab.mas_bottom).with.offset(10 +(10 + TypeHeight)*(i/3));
            if (i%3 == 0) {
                make.left.mas_offset(10);
            }else
            {
                make.left.mas_equalTo(lastBtn.mas_right).with.offset(10);
            }
            
        }];
        
        UILabel *typeLab = [Tool labelWithTitle:self.Model.typeArr[i] color:The_wordsColor fontSize:15 alignment:1];
        
        [typeBtn addSubview:typeLab];
        
        [typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.edges.equalTo(typeBtn).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.left.equalTo(typeBtn);
            make.top.equalTo(typeBtn);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
            
        }];
        
        lastBtn =typeBtn;
        
        
        [_typeBtnArr addObject:typeBtn];
        typeBtn.selected = NO;
        if ([self.Model.typeArr[i] isEqualToString:_selectModel.type]) {
//            [self typeSelectAction:typeBtn];
            _isSelectedType = YES;
            [self btnIsSelect:typeBtn];
        }

//        if (self.Model.typeArr.count==1) {
////            typeBtn.selected = YES;
//            [self typeSelectAction:typeBtn];
//        }
        
        [typeBtn setBackgroundImage:[UIImage imageNamed:@"xuanzhong2@2x.png"] forState:UIControlStateSelected];
        [typeBtn setBackgroundImage:[UIImage imageNamed:@"noGoods@2x.png"] forState:UIControlStateDisabled];
        [typeBtn setTitleColor:The_placeholder_Color_grary forState:UIControlStateDisabled];

        //typeBtn.imageView.frame = CGRectMake(0, 0, 80, 40);
        [typeBtn addTarget:self action:@selector(typeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        if (lastBtn) {
            make.bottom.equalTo(lastBtn.mas_bottom).mas_offset(20);
        }else{
            make.bottom.equalTo(typeLab.mas_bottom).mas_offset(20);
        }
        
    }];

    underView = [[ShoppingCarUnderView alloc]init];
    underView.backgroundColor = [UIColor whiteColor];
    [self addSubview:underView];
//    underView.Lab1 =
    
    

    
    [underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(49);
    }];
    
//    if (_shoppingCareEdit) {
    [underView configview2WithPrice:@([_Model.originalPrice floatValue]*0.01 *[_selectModel.number intValue]) andScalePrice:@([_Model.price floatValue]*0.01 *[_selectModel.number intValue])];
        self.requestBtn = underView.btn1;
//        underView.Lab1.text = [[NSString alloc]initWithFormat:@"￥%0.2f",[_Model.originalPrice floatValue]*0.01 *[_selectModel.number intValue]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:underView.Lab1.text];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,1)];
    underView.Lab1.attributedText = str;

    

        [underView.btn1 addTarget:self action:@selector(requestAction) forControlEvents:UIControlEventTouchUpInside];

//    }
    
    

    if (self.Model.colorArr.count==1&&self.Model.typeArr.count==1) {
        if (_isSelectedColor == NO) {
            UIButton *colorButton = [container viewWithTag:100];
            [self colorSelectAction:colorButton];
        }
        if (_isSelectedType == NO) {
            UIButton *typeButton = [container viewWithTag:1000];
            [self typeSelectAction:typeButton];
        }
        
    }
    
}


-(void)colorSelectAction:(UIButton *)btn
{
    
    CGFloat count =btn.tag-100;
    if (btn.selected) {
        btn.selected = NO;
        [self isCanSelect:btn];
        count = -1;
    }else
    {
        for (UIButton *tempBtn in _ColorBtnArr) {
            tempBtn.selected = NO;
            [self isCanSelect:tempBtn];

        }
        btn.selected = !btn.selected;
        [self btnIsSelect:btn];
    }
    
   

    
    [self panduanSanping:count isColor:YES];
    
    [self updateTitleImg];
    
    
    
    
}

-(void)typeSelectAction:(UIButton *)btn
{
    CGFloat count =btn.tag-1000;
    if (btn.selected) {
        btn.selected = NO;
        [self isCanSelect:btn];
        count = -1;
    }else
    {
        for (UIButton *tempBtn in _typeBtnArr) {
            tempBtn.selected = NO;
            [self isCanSelect:tempBtn];
            
        }
        btn.selected = !btn.selected;
        [self btnIsSelect:btn];
    }
    
    
    
    
    [self panduanSanping:count isColor:NO];

    [self updateTitleImg];

}


//判断是否有该商品

-(void)panduanSanping:(NSInteger)tag  isColor:(BOOL)iscolor
{
    
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _Model.modelArr.count; i++) {
        ShoppingGoodsModel *tempModel = _Model.modelArr[i];
        
        if (iscolor) {
            
            if (tag == -1) {
                tempArr = _Model.modelArr;
                _selectedColorLabel.text = @"";
            }else
            {
                if ([tempModel.color isEqualToString:_Model.colorArr[tag]]) {
                    _selectedColorLabel.text = _Model.colorNameArr[tag];
                    [tempArr addObject:tempModel];
                }
 
            }
            
            
        }else
        {
            
            if (tag == -1) {
                tempArr = _Model.modelArr;
            }else
            {
                if ([tempModel.stytle isEqualToString:_Model.typeArr[tag]]) {
                    [tempArr addObject:tempModel];
                }
                
            }

        }

    }
    
    [self panduanBtnActive:tempArr isColor:iscolor];

}

-(void)panduanBtnActive:(NSMutableArray *)ModelArr  isColor:(BOOL)iscolor
{
    
    NSMutableArray *selectArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < ModelArr.count; i++) {
        ShoppingGoodsModel *shoppingModel = ModelArr[i];
        if (iscolor) {
        for (int j = 0 ; j < _Model.typeArr.count; j++) {
                if ([shoppingModel.stytle isEqualToString:_Model.typeArr[j]]) {
                    NSLog(@"这个颜色有%d型号",j);
                    ;
                    
                    [selectArr addObject:[[NSString alloc]initWithFormat:@"%d",j]];
//                    [tempBtn setUserInteractionEnabled:NO];
//                    tempBtn.backgroundColor = [UIColor grayColor];
                }else
                {
//                    [tempBtn setUserInteractionEnabled:YES];
//                    tempBtn.backgroundColor = [UIColor redColor];
                }
            }
        }else
        {
            for (int j = 0 ; j < _Model.colorArr.count; j++) {
                if ([shoppingModel.color isEqualToString:_Model.colorArr[j]]) {
                    NSLog(@"这个型号有%d颜色",j);
                    [selectArr addObject:[[NSString alloc]initWithFormat:@"%d",j]];

                }
                
            }
        }
    }

    
    
    
    if (iscolor) {
        for (UIButton *btn in _typeBtnArr) {
            [self isNoCanSelect:btn];

        }
    }else
    {
        for (UIButton *btn in _ColorBtnArr) {
            [self isNoCanSelect:btn];
        }
    }
    
    
    
    for (NSString *numStr in selectArr) {
        
        int num =[numStr intValue];
        if (iscolor) {
            UIButton *tempBtn =   _typeBtnArr[num];
            [self isCanSelect:tempBtn];

        }else
        {
            UIButton *tempBtn =   _ColorBtnArr[num];
            [self isCanSelect:tempBtn];
        }
    }
}



#pragma mark buttonActon

//确定按钮

-(void)requestAction
{
   
    if (_selectModel.color.length == 0) {
        [[MyAlert  manage] showNoBtnAlertWithTitle:@"警告" detailTitle:@"请选择颜色"];
        return;
    }
    if (_selectModel.type.length == 0) {
        [[MyAlert  manage] showNoBtnAlertWithTitle:@"警告" detailTitle:@"请选择类型"];
        return;
    }
    
    if (_isAddShoppingCare) {
        
//        NSDictionary *dic = @{@"goodsId":_selectModel.goodsId,
//                              @"goodsColor":_selectModel.color,
//                              @"goodsStyle":_selectModel.type,
//                              @"goodsAmount":_selectModel.number,
//                              };
        
        if ([_selectModel.leftNumber integerValue] < [_selectModel.number integerValue]) {
            
            [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:[[NSString alloc]initWithFormat:@"该商品没有库存不足！当前库存%d",[_selectModel.leftNumber intValue]]];
            return;
        }
        OrderDetailModel *orderModel = [[OrderDetailModel alloc]init];
        [orderModel.goodsArr  addObject:_selectModel];
        
        NSMutableArray *goodsArr = [[NSMutableArray alloc]init];
        
        for (int i = 0 ; i < orderModel.goodsArr.count; i++) {
            GoodsModel *goodModel = orderModel.goodsArr[i];

            if (goodModel.imgUrl==nil) {
                goodModel.imgUrl = self.Model.smallUrl;
            }
            NSDictionary *goodDic =@{@"goodsAmount":goodModel.number,
                                     @"goodsColor":goodModel.color,
                                     @"goodsId":goodModel.goodsId,
                                     @"goodsColorStyleId":goodModel.detailId,
                                     @"goodsStyle":goodModel.type,
                                     @"goodsName":goodModel.title,
                                     @"goodsSmallUrl":goodModel.imgUrl,
                                     @"colorName":goodModel.colorName,
                                     };
            [goodsArr addObject:goodDic];
        }
        
        NSDictionary *praramDic = @{@"payMsg":goodsArr,
                                    };
//        NSString *jsonStr =  [ self dictionaryToJson:praramDic];
        NSString *jsonStr = [self ObjectTojsonString:praramDic];
        NSDictionary *dic = @{@"goodsId":_selectModel.goodsId,
                              @"payMsg":jsonStr,
                              };
        
        if (_carId) {
            NSMutableDictionary *mulDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
            
            [mulDic setValue:_carId forKey:@"cartId"];
            dic = mulDic;
            
        }
        [HttpRequestManager postShoppingCarAddRequest:dic viewcontroller:nil finishBlock:^(NSDictionary *dic) {
            if ([dic[@"code"] intValue] == 200) {
                
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"shoppingCarChange" object:nil userInfo:nil];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                if (_carId) {
                    
                }else
                {
                    [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"加入购物车成功"];
 
                }
            }
            [self removeFromSuperview];

        }];
        
    }else
    {
        OrderDetailVC *vc = [[OrderDetailVC alloc]init];
        OrderDetailModel *orderModel = [[OrderDetailModel alloc]init];
        [orderModel.goodsArr  addObject:_selectModel];
        vc.model = orderModel;
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nav pushViewController:vc animated:YES];
        [self removeFromSuperview];
    }
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


//更新图片显示
-(void)updateTitleImg
{
    NSString *typeStr = nil;
    NSString *colorStr = nil;
    for (int i = 0; i < _typeBtnArr.count; i++) {
        UIButton *tyoeBtn = _typeBtnArr[i];
        if (tyoeBtn.selected && [tyoeBtn isEnabled]) {
            typeStr = _Model.typeArr[i];
        }
    }
    
    for (int i = 0; i < _ColorBtnArr.count; i++) {
        UIButton *tyoeBtn = _ColorBtnArr[i];
        if (tyoeBtn.selected && [tyoeBtn isEnabled]) {
            colorStr = _Model.colorArr[i];
        }
    }
    
    if (typeStr || colorStr) {
        for (int i = 0; i < _Model.modelArr.count; i ++) {
            ShoppingGoodsModel *model = _Model.modelArr[i];
            if ([model.color isEqualToString:colorStr] && [model.stytle isEqualToString:typeStr]) {
              
                [Tool setImgurl:_titleImageView imgurl:model.titleImg];
                if (model.titleImg==nil) {
                    model.titleImg = self.Model.smallUrl;
                }
                _selectModel.imgUrl = model.titleImg;
                _selectModel.leftNumber = model.leftCount;
                _selectModel.detailId = model.ID;
                _selectModel.colorName = model.colorName;
                _selectModel.price =[[NSString alloc]initWithFormat:@"%f",[model.price integerValue]  * 0.01 ];
                _selectModel.scalePrice =[[NSString alloc]initWithFormat:@"%f",[model.salePrice integerValue]  * 0.01 ];

//                _selectModel.scalePrice = model.salePrice;
                
//                _Model.price = model.salePrice;
                
                CGFloat tempprice = [_selectModel.number floatValue] * [_selectModel.price floatValue] ;
                underView.Lab1.text = [[NSString alloc]initWithFormat:@"￥%0.2f",tempprice];
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:underView.Lab1.text];
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,1)];
                underView.Lab1.attributedText = str;

                underView.scaleLabel.text = [[NSString alloc]initWithFormat:@"￥%0.2f",[_selectModel.number floatValue] * [_selectModel.scalePrice floatValue]];
                [underView.scaleLabel sizeToFit];
                [underView.scaleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(-13);
                    make.left.mas_equalTo(15);
                    make.width.mas_equalTo(underView.scaleLabel.bounds.size.width+40);
                    make.height.mas_equalTo(20);
                }];
 
            }
        }
        
    }
    _selectModel.color = colorStr;
    _selectModel.type = typeStr;

}

//按钮选中状态
-(void)btnIsSelect:(UIButton *)btn
{
    btn.selected = YES;
    btn.layer.borderWidth = 0;
}



//按钮普通状态可选中
-(void)isCanSelect:(UIButton *)btn
{
//    btn.backgroundColor = [UIColor whiteColor];
    [btn setEnabled:YES];

    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    [btn setTitleColor:The_wordsColor forState:UIControlStateNormal];
    
    if (btn.selected) {
        [self btnIsSelect:btn];
    }
    
}
//按钮不可选中状态


-(void)isNoCanSelect:(UIButton *)btn
{
    [btn setBackgroundImage:[UIImage imageNamed:@"noGoods.png"] forState:UIControlStateNormal];
    [btn setTitleColor:The_placeholder_Color_grary forState:UIControlStateNormal];
//    btn.selected = NO;
    btn.layer.borderWidth = 0;
    [btn setEnabled:NO];

   
   
}


//展示购买页面

-(void)showGoodsView:(GoodsDetailView *)view
{
  
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.backgroundColor = BXAlphaColor(0, 0, 0, 0.3);
    [view configUI];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(KHScreenH);
    }];
    
    [view layoutIfNeeded];
    
}

-(void)hiddenViewAction
{
    [self removeFromSuperview];;

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location>= 4)
    {
        return NO;

    }
    
    return YES;
}


-(NSString*)ObjectTojsonString:(id)object

{
    
    NSString *jsonString = [[NSString alloc]init];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                        
                                                      options:NSJSONWritingPrettyPrinted
                        
                                                        error:&error];
    
    if (! jsonData) {
        
        NSLog(@"error: %@", error);
        
    } else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}



@end
