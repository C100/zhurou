//
//  ShoppingCarUnderView.m
//  XiJuOBJ
//
//  Created by james on 16/9/10.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "ShoppingCarUnderView.h"

@implementation ShoppingCarUnderView

-(void)configview1
{
    
    
    
    self.allSelectBtn = [[UIButton alloc]init];
//    self.allSelectBtn.backgroundColor = [UIColor greenColor];
    [self addSubview:self.allSelectBtn];
    

    self.priceLab = [[UILabel alloc]init];
    self.priceLab.textAlignment = 2;
    [self addSubview:self.priceLab];

    self.orderBtn = [[UIButton alloc]init];
    self.orderBtn.backgroundColor = The_MainColor;
    [self addSubview:self.orderBtn];

    UIView *lineVIew = [[UIView alloc]init];
    lineVIew.backgroundColor =[Tool getColorFromHex:@"#f4f4f4"];
    [self addSubview:lineVIew];
    [lineVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.width.mas_equalTo(@70);
        make.top.mas_equalTo(1);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(1);
        make.right.mas_equalTo(self.orderBtn.mas_left).mas_offset(-10);
        make.left.mas_equalTo(self.allSelectBtn.mas_right).mas_offset(0);
    }];

    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(0);
        make.width.mas_equalTo(@80);
        make.top.mas_equalTo(1);
    }];

    
    self.allSelectImg = [[UIImageView alloc]init];
    [self.allSelectBtn addSubview:self.allSelectImg];

    UILabel *selectLab = [Tool labelWithTitle:@"全选" color:The_wordsColor fontSize:13 alignment:1];
    [self.allSelectBtn addSubview:selectLab];

    self.allSelectImg.image = [UIImage imageNamed:@"yigouxuan@2x.png"];

    
    [self.allSelectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.centerY.mas_equalTo(self.allSelectBtn.mas_centerY);
        make.left.mas_offset(10);
    }];
    
    [selectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.mas_equalTo(self.allSelectImg.mas_right);
        make.right.mas_equalTo(self.allSelectBtn.mas_right);
        make.top.mas_equalTo(1);

    }];

    self.orderLab = [Tool labelWithTitle:@"" color:[UIColor whiteColor] fontSize:15 alignment:1];
    [self.orderBtn addSubview:self.orderLab];

    
    [self.orderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.top.mas_equalTo(1);
    }];
    

    [self updateView1WithSelect:NO money:0 count:0];
    
    
}

-(void)updateView1WithSelect:(BOOL)select  money:(CGFloat)sum count:(int)count
{
    
    
    if (select) {
        self.allSelectImg.image = [UIImage imageNamed:@"yigouxuan@2x.png"];
    }else
    {
        self.allSelectImg.image = [UIImage imageNamed:@"wancheng@2x.png"];
    }
    
  
    NSString *priceStr = [[NSString alloc]initWithFormat:@"合计：￥%0.2f ",sum];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:priceStr];
    self.priceLab.font = [UIFont fontWithName:The_titleFont size:15];
    self.priceLab.textColor = The_TitlePayColor;
    //设置：在0-3个单位长度内的内容显示成红色
    [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0, 3)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(3, 1)];
    //[str addAttribute:NSFontAttributeName value:[UIFont fontWithName:The_titleFont size:13] range:NSMakeRange(priceStr.length-4, 4)];

    
    self.priceLab.attributedText =str;
    
    self.orderLab.text = [[NSString alloc]initWithFormat:@"下单(%d)",count];

    
}


-(void)configview3withpriceTitle:(NSString *)title priceTitle:(NSString *)price btnTitle:(NSString *)BtnTitle{
    
    UIView *lineVIew = [[UIView alloc]init];
    lineVIew.backgroundColor =[Tool getColorFromHex:@"#f4f4f4"];
    [self addSubview:lineVIew];
    [lineVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *titleLabel = [UILabel labelWithTitle:@"免运费" color:k888888Color font:kLightFont(14)];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 14));
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    
    UILabel *stateLabel = [Tool labelWithTitle:@"等待卖家发货" color:k888888Color fontSize:16 alignment:2];
    if ([BtnTitle isEqualToString:@"等待卖家发货"]) {
        [self addSubview:stateLabel];
        [stateLabel sizeToFit];
        [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.width.mas_equalTo(stateLabel.bounds.size.width);
            make.top.mas_equalTo(0);
            make.right.mas_offset(-5);
        }];
    }else{
        self.btn1 = [Tool buttonWithTitle:@"确认" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:nil];
        self.btn1.backgroundColor = The_MainColor;
        [self addSubview:self.btn1];
        [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_offset(0);
            make.width.mas_equalTo(80);
            make.top.mas_equalTo(1);
        }];
        
        self.btn2 = [Tool buttonWithTitle:@"" titleColor:k797979Color font:14 imageName:nil target:nil action:nil];
        self.btn2.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.btn2];
        [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.btn1.mas_left).mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(1);
            make.width.mas_equalTo(80);
        }];
    }
    
    
    self.priceLab = [Tool labelWithTitle:@"￥0.00" color:The_TitlePayColor fontSize:17 alignment:1];
    self.priceLab.textAlignment = 0;
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        if (self.btn2) {
            make.right.mas_equalTo(self.btn2.mas_left).mas_offset(-10);
        }else{
            make.right.mas_equalTo(stateLabel.mas_left).mas_offset(-10);
        }
        
        make.left.mas_equalTo(titleLabel.mas_right).mas_offset(0);
        make.top.mas_equalTo(1);
    }];
    NSString *titleZongStr = [[NSString alloc]initWithFormat:@"%@￥%@",title,price ];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleZongStr];
    [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,title.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(title.length, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:The_titleFont size:17] range:NSMakeRange(title.length+2, 3)];
    self.priceLab.attributedText = str;
    
    
    
}


/**
 * 创建产品详情下面只有金额view
 */

-(void)configview2WithPrice:(NSNumber *)price andScalePrice:(NSNumber *)sclaPrice;
{
    
    UIView *lineVIew = [[UIView alloc]init];
    lineVIew.backgroundColor =[Tool getColorFromHex:@"#f4f4f4"];
    [self addSubview:lineVIew];
    [lineVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.btn1 = [Tool buttonWithTitle:@"确定" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:nil];
    self.btn1.backgroundColor = The_MainColor;
    [self addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(1);
    }];

    
//    self.Lab1 = [Tool labelWithTitle:[NSString stringWithFormat:@"￥%.2f",price.floatValue] color:The_TitlePayColor fontSize:17 alignment:1];
//    self.Lab1.textAlignment = 1;
//    [self addSubview:self.Lab1];
//    [self.Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.mas_offset(0);
//        make.right.mas_equalTo(self.btn1.mas_left);
//        make.top.mas_equalTo(1);
//    }];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.Lab1.text];
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,1)];
//    self.Lab1.attributedText = str;
    
    
    NSNumber *pnum = @(price.floatValue);
    NSNumber *scNum = @(sclaPrice.floatValue);
    if ([pnum isEqual:scNum]) {
        self.Lab1 = [Tool labelWithTitle:[NSString stringWithFormat:@"￥%.2f",price.floatValue] color:The_TitlePayColor fontSize:15 alignment:1];
        self.Lab1.textAlignment = 1;
        self.Lab1.font = kFont(15);
        [self.Lab1 sizeToFit];
        NSString *titleZongStr = [[NSString alloc]initWithFormat:@"%@￥%@",@"",[Tool priceChange:price] ];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleZongStr];
        [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,@"".length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(@"".length,1)];
        self.Lab1.attributedText = str;
        
        [self addSubview:self.Lab1];
        [self.Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.btn1.mas_left);
        }];
    }else{
        
        UILabel *scaleLabel = [Tool labelWithTitle:[NSString stringWithFormat:@"￥%@",[Tool priceChange:sclaPrice]] color:[Tool getColorFromHex:@"#CC9C5C"] fontSize:15 alignment:1];
        [self addSubview:scaleLabel];
        self.scaleLabel = scaleLabel;
        self.scaleLabel.font = [UIFont systemFontOfSize:15];
        [scaleLabel sizeToFit];
        NSString *titleZongStr = [[NSString alloc]initWithFormat:@"￥%@",[Tool priceChange:sclaPrice] ];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleZongStr];
        [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,@"".length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(@"".length,1)];
        scaleLabel.attributedText = str;
        [scaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_offset(0);
            make.bottom.mas_equalTo(-13);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(scaleLabel.bounds.size.width+5);
            make.height.mas_equalTo(20);
            //            make.right.mas_equalTo(self.btn2.mas_left);
        }];
        
        
        self.Lab1 = [Tool labelWithTitle:[NSString stringWithFormat:@"%@",[Tool priceChange:price]] color:k888888Color fontSize:13 alignment:1];
        self.Lab1.textAlignment = 1;
        [self.Lab1 sizeToFit];
        [self addSubview:self.Lab1];
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

/**
 * 创建产品详情下面只有金额view
 *
 *自定义金额title，和按钮文字
 */

-(void)configview2withpriceTitle:(NSString *)title  priceTitle:(NSString *)price btnTitle:(NSString*)BtnTitle
{
    
    UIView *lineVIew = [[UIView alloc]init];
    lineVIew.backgroundColor =[Tool getColorFromHex:@"#f4f4f4"];
    [self addSubview:lineVIew];
    [lineVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.btn1 = [Tool buttonWithTitle:BtnTitle titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:nil];
    self.btn1.backgroundColor = The_MainColor;
    [self addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(1);
    }];
    
    
    self.Lab1 = [Tool labelWithTitle:@"￥0.00" color:The_TitlePayColor fontSize:17 alignment:1];
    self.Lab1.textAlignment = 1;
    
    NSString *titleZongStr = [[NSString alloc]initWithFormat:@"%@￥%@",title,price ];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleZongStr];
    [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,title.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(title.length, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:The_titleFont size:17] range:NSMakeRange(title.length+2, 3)];
    self.Lab1.attributedText = str;

    [self addSubview:self.Lab1];
    [self.Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_offset(0);
        make.right.mas_equalTo(self.btn1.mas_left);
        make.top.mas_equalTo(1);
    }];
    
}



-(void)configGoodsDetailView:(NSString *)price andSclaPrice:(NSString *)sclaPrice
{
    CGFloat width = (KHScreenW-2)/3;
    UIView *lineVIew = [[UIView alloc]init];
    lineVIew.backgroundColor =[Tool getColorFromHex:@"#f4f4f4"];
    [self addSubview:lineVIew];
    [lineVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.btn1 = [Tool buttonWithTitle:@"" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:nil];
    [self.btn1 setTitle:@"联系客服" forState:UIControlStateNormal];
    [self.btn1 setTitleColor:k888888Color forState:UIControlStateNormal];
//    self.btn1.backgroundColor = [];
    [self.btn1 setImage:[UIImage imageNamed:@"zaixiankefu@2x.png"] forState:UIControlStateNormal];
    [self addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_offset(0);
        make.width.mas_equalTo(width);
        make.top.mas_equalTo(1);
    }];

    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = The_line_Color_grary;
    [self addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btn1.mas_right).offset(0);
        make.centerY.mas_equalTo(self.btn1);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(1);
    }] ;
    
    
    self.btn3 = [Tool buttonWithTitle:@"立即购买" titleColor:[UIColor whiteColor] font:15 imageName:nil target:self action:nil];
    self.btn3.backgroundColor = The_MainColor;
    [self addSubview:self.btn3];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.width.mas_equalTo(width);
        make.top.mas_equalTo(1);
    }];

    self.btn2 = [Tool buttonWithTitle:@"加入购物车" titleColor:The_wordsColor font:15 imageName:nil target:self action:nil];
//    self.btn2.backgroundColor = The_MainColor;
    [self addSubview:self.btn2];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.right.mas_equalTo(self.btn3.mas_left).offset(0);
        make.width.mas_equalTo(width);
        make.top.mas_equalTo(1);
    }];

    
    
//    UIView *line2 = [[UIView alloc]init];
//    line2.backgroundColor = The_line_Color_grary;
//    [self addSubview:line2];
//    
//    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.btn2.mas_left).offset(-5);
//        make.centerY.mas_equalTo(self.btn1);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(1);
//    }] ;

//    NSNumber *pnum = @(price.floatValue);
//    NSNumber *scNum = @(sclaPrice.floatValue);
//    if ([pnum isEqual:scNum]) {
//        self.Lab1 = [Tool labelWithTitle:@"￥0.00" color:The_TitlePayColor fontSize:17 alignment:1];
//        self.Lab1.textAlignment = 1;
//
//        NSString *titleZongStr = [[NSString alloc]initWithFormat:@"%@￥%@",@"",[Tool priceChange:price] ];
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleZongStr];
//        [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,@"".length)];
//        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(@"".length,1)];
//        self.Lab1.attributedText = str;
//
//        [self addSubview:self.Lab1];
//        [self.Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.mas_offset(0);
//            make.left.mas_equalTo(self.btn1.mas_right).offset(5);
//            make.right.mas_equalTo(self.btn2.mas_left);
//        }];
//    }else{
//
//        UILabel *scaleLabel = [Tool labelWithTitle:[NSString stringWithFormat:@"￥%@",[Tool priceChange:sclaPrice]] color:[Tool getColorFromHex:@"#CC9C5C"] fontSize:15 alignment:1];
//        [self addSubview:scaleLabel];
//        self.scaleLabel = scaleLabel;
//
//        NSString *titleZongStr = [[NSString alloc]initWithFormat:@"￥%@",[Tool priceChange:sclaPrice] ];
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleZongStr];
//        [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,@"".length)];
//        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(@"".length,1)];
//        scaleLabel.attributedText = str;
//        [scaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.mas_offset(0);
//            make.left.mas_equalTo(self.btn1.mas_right).offset(14);
////            make.right.mas_equalTo(self.btn2.mas_left);
//        }];
//
//
//        self.Lab1 = [Tool labelWithTitle:[NSString stringWithFormat:@"%@",[Tool priceChange:price]] color:k888888Color fontSize:13 alignment:1];
//        self.Lab1.textAlignment = 1;
//
//        [self addSubview:self.Lab1];
//        [self.Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_offset(-13);
//            make.left.mas_equalTo(scaleLabel.mas_right).offset(5);
//            make.height.mas_equalTo(20);
////            make.right.mas_equalTo(self.btn2.mas_left);
//        }];
//
//
//        UIView *horView = [[UIView alloc]init];
//        horView.backgroundColor = k888888Color;
//        [self.Lab1 addSubview:horView];
//        [horView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_offset(0);
//            make.height.mas_equalTo(1);
//            make.left.offset(-2);
//            make.right.mas_equalTo(2);
//        }];
//    }
//
    
}



@end
