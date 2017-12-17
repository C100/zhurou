//
//  OrderDetailCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/28.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "OrderDetailCell.h"
#import "AddressModel.h"
#import "GoodsModel.h"
#import "AddressManagerVC.h"

@interface OrderDetailCell()<UITextFieldDelegate>
{
    OrderDetailModel *_model;
    UIViewController *_vc;
}
@end


@implementation OrderDetailCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(OrderDetailModel *)model IndexPath:(NSIndexPath *)indexPath VC:(UIViewController *)vc
{
    
    
    _vc=vc;
    _model=model;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CommonCellView*commonView= [[CommonCellView alloc] init];
    [self addSubview:commonView];
    [commonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
    if (self) {        
        if (indexPath.section == 0) {
            [self addressConfig];
            
        }else if (indexPath.section == 1)
        {
            
            UIView *lastView=nil;
            for (int i = 0; i < model.goodsArr.count; i++) {
                
                GoodsModel *goodModel = model.goodsArr[i];
                
                UIView *goodView = [[UIView alloc]init];
                [self.contentView addSubview:goodView];
                
                [goodView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.offset(0);
//                    make.height.mas_equalTo(70);
                    if (i==0) {
                        make.top.offset(0);
                    }else
                    {
                        make.top.mas_equalTo(lastView.mas_bottom);
                        
                    }
                    
                    if (i==model.goodsArr.count-1) {
                        make.bottom.mas_equalTo(0);
                    }
                }];
                [self creatGoodView:goodModel partentView:goodView];
                
                
                lastView = goodView;
            }
        }else
        {
            switch (indexPath.row ) {
                case 0:
                {
//                    CGFloat allPrice = 0;
//                    for (int i = 0; i < model.goodsArr.count; i++) {
//                        
//                        GoodsModel *goodsModel = model.goodsArr[i];
//                        
//                      allPrice = [goodsModel.scalePrice floatValue] * [goodsModel.number floatValue] + allPrice;
//                    }
                    
                    NSString *value = @"未使用";
                    if (![model.coupons isEqualToString:@""]&&model.coupons) {
                        value = model.coupons;
                    }
                    [commonView buttonLeftConfig:@"优惠券" vauleTitle:value];
                    _couponsBtn = commonView.btn1;
                    commonView.vauleLab.textAlignment = 2;

                }
                    break;
                case 1:
    
                {
//                    NSString *vauleTitle = [[NSString alloc]initWithFormat:@"%@",model.transportFare];
                    NSString *vauleTitle = @"未填写";
                    if (![model.code isEqualToString:@""]&&model.code) {
//                        model.code = @"";
                        vauleTitle = model.code;
                    }
                    [commonView buttonLeftConfig:@"优惠码" vauleTitle:vauleTitle];
                    commonView.vauleLab.textAlignment = 2;
                    _codeButton = commonView.btn1;
                }
                    break;
                case 2:
    
                {
                    NSString *value = @"暂无减免";
                    if (model.discount) {
                        value = model.discount;
                    }
                    [commonView labelLeftConfig:@"折扣优惠" vauleTitle:value];
                    commonView.vauleLab.textAlignment = 2;

                }
                    break;
                case 3:
                    
                {
                    NSString *value = @"未填写";
                    if (![model.billInfo isEqualToString:@""]) {
                        value = model.billInfo;
                    }
                    [commonView buttonLeftConfig:@"发票信息" vauleTitle:value];
                    _billInfoBtn = commonView.btn1;
                    commonView.vauleLab.textAlignment = 2;

                }
                    break;
                case 4:
                    
                {
                    NSString *value = @"未填写";
                    if (![model.remark isEqualToString:@""]) {
                        value = model.remark;
                    }
                    [commonView buttonLeftConfig:@"备注" vauleTitle:value];
                    _remarkBtn = commonView.btn1;
                    commonView.vauleLab.textAlignment = 2;

                }
                    break;
                default:
                    break;
            }
        }
        

        
        
    }
    return self;
    
}
//绘制产品信息

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
    
    NSString *priceStr = [[NSString alloc]initWithFormat:@"￥%0.2f",[model.scalePrice floatValue]];
    UILabel *priceLab = [Tool labelWithTitle:priceStr color:The_TitleDeepColor fontSize:16 alignment:2];
    [goodView addSubview:priceLab];
    
    NSString *typeStr =[ [NSString alloc]initWithFormat:@"%@ | %@",model.colorName,model.type ];
    
    UILabel *typeLab = [Tool labelWithTitle:typeStr color:The_wordsColor fontSize:12 alignment:0];
    [goodView addSubview:typeLab];
    
    //    UILabel *typeLab = [Tool labelWithTitle:model.color color:The_wordsColor fontSize:12 alignment:0];
    //    [goodView addSubview:typeLab];
    //
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
    
    UIView *lineView3 = [[UIView alloc]init];
    lineView3.backgroundColor = The_line_Color_grary;
    [goodView addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleImgView.mas_bottom).mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    
    self.singleProductMoneyLabel = [Tool labelWithTitle:[NSString stringWithFormat:@"总金额：￥%.2f",[model.scalePrice floatValue]*model.number.intValue] color:k888888Color fontSize:12 alignment:0];
    [self.singleProductMoneyLabel sizeToFit];
    [goodView addSubview:self.singleProductMoneyLabel];
    [self.singleProductMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(lineView3.mas_bottom).mas_equalTo(17);
        make.bottom.mas_equalTo(-13);
        //make.size.mas_equalTo(CGSizeMake(self.singleProductMoneyLabel.bounds.size.width, 12));
        make.right.mas_equalTo(-10);
    }];
    
    
    
    return goodView;
    
}

//地址绘制
-(void)addressConfig
{
    AddressModel* addressModel = _model.AddressModel;
    
    
    //当没有地址时
    if (addressModel == nil) {
        
        UIButton *addAddressBtn = [Tool buttonWithTitle:@"" titleColor:The_wordsColor font:18 imageName:nil target:self action:@selector(addAressAction)];
        addAddressBtn.borderWidth = 1;
        addAddressBtn.borderColor = The_line_Color_grary;
        [self.contentView addSubview:addAddressBtn];
        [addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(20);
            make.right.bottom.mas_offset(-20);
        }];
        
        [addAddressBtn setImage:[UIImage imageNamed:@"bi@2x.png"] forState:UIControlStateNormal];
        [addAddressBtn setTitle:@"   添加地址" forState:UIControlStateNormal];
        addAddressBtn.titleLabel.textAlignment = 0;
        return;
    }
    
    UIImageView *dizhiImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dizhi@2x.png"]];
    [self.contentView addSubview:dizhiImg];
    [dizhiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(18, 20));
//        make.centerY.mas_equalTo(self.contentView.centerY);
        make.top.mas_offset(38);

    }];
    UIImageView *biImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiayibu@2x.png"]];
    biImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:biImg];
    [biImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
//        make.centerY.mas_equalTo(self.contentView.centerY);
        make.top.mas_offset(38);
    }];
    
    
    UILabel *phoneLab = [Tool labelWithTitle:addressModel.phone color:The_TitleColor fontSize:15 alignment:2];
    [self.contentView addSubview:phoneLab];
    
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(biImg.mas_left).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 16));
        make.top.mas_offset(10);
    }];
    
    NSString *titleStr = [[NSString alloc]initWithFormat:@"收件人：%@",addressModel.title];
    
    UILabel *titleLab = [Tool labelWithTitle:titleStr color:The_TitleColor fontSize:15 alignment:0];
    [self.contentView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dizhiImg.mas_right).mas_offset(10);
        make.right.mas_equalTo(phoneLab.mas_left).mas_offset(-10);
        make.height.mas_equalTo(16);
//        make.size.mas_equalTo(CGSizeMake(85, 16));
        make.top.mas_offset(10);
    }];
    
    NSString *addressStr =[ [NSString alloc]initWithFormat:@"收货地址：%@%@",addressModel.address,addressModel.detailAddress];
    UILabel *addressLab = [Tool labelWithTitle:addressStr color:The_TitleColor fontSize:15 alignment:0];
    addressLab.numberOfLines = 2;
    [self.contentView addSubview:addressLab];
    
    [addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dizhiImg.mas_right).mas_offset(10);
        make.right.mas_equalTo(biImg.mas_left).mas_offset(-10);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(phoneLab.mas_bottom).offset(0);
    }];

    
    
}

-(void)addAressAction
{
    
}

//绘制产品
//-(void)
//
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    _model.name = _nameTextFild.text;
//    
//}



@end
