//
//  OrderCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/27.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "OrderCell.h"
#import "GoodsModel.h"

@interface OrderCell()<UITextFieldDelegate>
{
    OrderModel *_model;
    UIViewController *_vc;
}
@end


@implementation OrderCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(OrderModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSString *timeStr = [[NSString alloc]initWithFormat:@"下单时间：%@",model.time];
        _timeLab = [Tool labelWithTitle:timeStr color:The_wordsColor fontSize:13 alignment:0];
        [self.contentView addSubview:_timeLab];
        
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(KHScreenW-100, 15));
        }];
        
        _TypeLab = [Tool labelWithTitle:model.type color:The_wordsColor fontSize:13 alignment:0];
        [self.contentView addSubview:_TypeLab];
        
        [_TypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.right.mas_offset(-10);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];

        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = The_line_Color_grary;
        [self.contentView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(35);
            make.left.offset(10);
            make.right.offset(0);
            make.height.mas_equalTo(1);
        }];
        
        
        UIView *lastView=nil;
        
        CGFloat allPrice = 0;
        
        for (int i = 0; i < model.goodsArr.count; i++) {
            
            GoodsModel *goodModel = model.goodsArr[i];
            
            allPrice =  [goodModel.scalePrice floatValue] * [goodModel.number floatValue] + allPrice;
            
            
            
            UIView *goodView = [[UIView alloc]init];
            [self.contentView addSubview:goodView];
            
            [goodView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.offset(0);
                make.height.mas_equalTo(70);
                if (i==0) {
                    make.top.mas_equalTo(line1.mas_bottom);
                }else
                {
                    make.top.mas_equalTo(lastView.mas_bottom);
                }
            }];
            [self creatGoodView:goodModel partentView:goodView];
            

            lastView = goodView;
        }
        
        
        UIButton *btn2 = [Tool buttonWithTitle:@"" titleColor:The_wordsColor font:13 imageName:nil target:self action:nil];
        btn2.layer.borderWidth = 1;
        NSArray *RGBArr = @[@(205),@(205),@(205)];
        btn2.layer.borderColor = [Tool uicolorchange:RGBArr];
        btn2.hidden = YES;
        [self.contentView addSubview:btn2];
        
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastView.mas_bottom).offset(10);
            make.right.mas_offset(-10);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
        UIButton *btn1 = [Tool buttonWithTitle:@"" titleColor:The_wordsColor font:13 imageName:nil target:self action:nil];
        btn1.layer.borderWidth = 1;
        btn1.layer.borderColor = [Tool uicolorchange:RGBArr];
        btn1.hidden = YES;
        [self.contentView addSubview:btn1];
        
        
        
        
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastView.mas_bottom).offset(10);
            make.right.mas_equalTo(btn2.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
        UILabel *acountPrice = [Tool labelWithTitle:[[NSString alloc]initWithFormat:@"总金额：￥%0.2f",allPrice] color:The_TitleColor fontSize:13 alignment:0];
        [self.contentView addSubview:acountPrice];

        //acountPrice.text = [[NSString alloc]initWithFormat:@"总金额：￥%0.2f",allPrice];
        
        [acountPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastView.mas_bottom).offset(10);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(200, 20));
        }];
        
        if ([_TypeLab.text isEqualToString:@"待付款"]) {
            btn1.hidden = NO;
            btn2.hidden = NO;

            [btn1 setTitle:@"删除" forState:UIControlStateNormal];
            [btn2 setTitle:@"付款" forState:UIControlStateNormal];
            _delectBtn = btn1;
            _payBtn = btn2;
            _TypeLab.textColor = The_TitlePayColor;

            
        }else if ([_TypeLab.text isEqualToString:@"待收货"]){
            btn1.hidden = NO;
            btn2.hidden = NO;
            [btn1 setTitle:@"查看物流" forState:UIControlStateNormal];
            [btn2 setTitle:@"确认收货" forState:UIControlStateNormal];
            _logisticsButton = btn1;
            _confirmBtn = btn2;
            _TypeLab.textColor = BXColor(152, 187, 227);
        }else if ([_TypeLab.text isEqualToString:@"待评价"]){
            btn2.hidden = NO;
            [btn2 setTitle:@"评价" forState:UIControlStateNormal];
            _reviewBtn = btn2;
            _TypeLab.textColor = BXColor(148, 192, 188);

        }else if ([_TypeLab.text isEqualToString:@"已完成"]){
            btn2.hidden = NO;
            [btn2 setTitle:@"再次购买" forState:UIControlStateNormal];
            _buyAgainBtn = btn2;
//            _TypeLab.textColor = BXColor(152, 238, 179);

        }else if ([_TypeLab.text isEqualToString:@"待发货"]){
            btn2.hidden = NO;
            [btn2 setTitle:@"等待卖家发货" forState:UIControlStateNormal];
            btn2.layer.borderWidth = 0;
            [btn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView.mas_bottom).offset(10);
                make.right.mas_offset(-10);
//                make.size.mas_equalTo(CGSizeMake(60, 20));
                make.height.mas_equalTo(20);
            }];
        }
       
        
        
        
        UIView *lineView2 = [[UIView alloc]init];
        lineView2.backgroundColor = The_list_backgroundColor;
        [self.contentView addSubview:lineView2];
        
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.right.mas_offset(0);
            make.top.mas_equalTo(btn2.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(10);
        }];

        
    }
    return self;
}

/**
 * 创建商品view
 */
-(UIView *)creatGoodView:(GoodsModel *)model partentView:(UIView *)goodView
{
    
    
     UIImageView *titleImgView = [[UIImageView alloc]init];
    [Tool setImgurl:titleImgView imgurl:model.imgUrl];
    [goodView addSubview:titleImgView];
    
    UILabel *titleLab = [Tool labelWithTitle:model.title color:The_TitleColor fontSize:16 alignment:0];
    [goodView addSubview:titleLab];
    
    
//    NSString *priceStr = [model.price integerValue]/model.number integerValue
    NSString *priceStr = [[NSString alloc]initWithFormat:@"￥%@",model.price];
    UILabel *priceLab = [Tool labelWithTitle:priceStr color:The_TitleDeepColor fontSize:16 alignment:2];
    [goodView addSubview:priceLab];
    
    
    NSString *typeStr =[ [NSString alloc]initWithFormat:@"%@ | %@",model.colorName,model.type ];
    UILabel *typeLab = [Tool labelWithTitle:typeStr color:The_wordsColor fontSize:12 alignment:0];
    [goodView addSubview:typeLab];
    
    NSString *num = [[NSString alloc]initWithFormat:@"x%@",model.number];
    UILabel *numberLab = [Tool labelWithTitle:num color:The_wordsColor fontSize:12 alignment:2];
    [goodView addSubview:numberLab];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = The_line_Color_grary;
    [goodView addSubview:lineView];
    
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = The_list_backgroundColor;
    [goodView addSubview:lineView2];
    
    
    [titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleImgView.mas_right).offset(10);
        make.top.mas_offset(10);
        make.height.mas_equalTo(@18);
        //            make.size.mas_equalTo(CGSizeMake(150, 18));
        make.right.mas_equalTo(priceLab.left).offset(-5);
    }];
    
    WS(ws);
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.contentView.mas_right).offset(-10);
        make.top.mas_offset(10);
        //            make.left.mas_equalTo(ws.titleLab.mas_right);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@100);
        
    }];
    
    [typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleImgView.mas_right).offset(10);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
        make.right.mas_equalTo(numberLab.left).offset(-5);
        make.height.mas_equalTo(16);
        
    }];
    
    [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@50);
    }];
    //
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleImgView.mas_bottom).offset(10);
        make.left.offset(10);
        make.height.mas_equalTo(1);
        make.right.mas_offset(0);
    }];
    //

    return goodView;
    
}


@end
