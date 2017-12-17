//
//  OrderDetailCell2.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/18.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "OrderDetailCell2.h"
#import "OrderDetailCell.h"
#import "AddressModel.h"
#import "GoodsModel.h"
#import "AddressManagerVC.h"

@interface OrderDetailCell2()<UITextFieldDelegate>
{
    OrderDetailModel *_model;
}
@end


@implementation OrderDetailCell2



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(OrderDetailModel *)model IndexPath:(NSIndexPath *)indexPath
{
    
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
            
            lastView = [ self creatGoodTitleView];
            
            
            
            for (int i = 0; i < model.goodsArr.count; i++) {
                
                GoodsModel *goodModel = model.goodsArr[i];
                commonView.hidden = YES;
                UIView *goodView = [[UIView alloc]init];
                [self.contentView addSubview:goodView];
                goodView.userInteractionEnabled = YES;
                [goodView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.offset(0);
//                    make.bottom.mas_equalTo(0);
//                    make.height.mas_equalTo(70);
                    if (!lastView) {
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
                
//                goodView.backgroundColor = [UIColor redColor];
                lastView = goodView;
            }
        }else
        {
            switch (indexPath.row ) {
                    
                case 0:
                {
                    
                    CGFloat baseOrdelEdit = 10000000 + [model.receiptId floatValue];
                    if (_model.refundOrExchangeStatusNum.intValue==0||_model.refundOrExchangeStatusNum==nil) {//不是退货
                        baseOrdelEdit = 10000000 + [model.receiptId floatValue];
                    }
//                    CGFloat *string = baseOrdelEdit
                    
                    [commonView labelLeftConfig:@"订单编号" vauleTitle:[[NSString alloc]initWithFormat:@"%0.0f",baseOrdelEdit]];
                    self.commonCellView = commonView;
                    commonView.vauleLab.textAlignment = 2;

                }
                    break;

                case 1:
                {
                    NSString *string = @"未使用";
                    if (![model.coupons isEqualToString:@"0.00"]) {
                        string = [[NSString alloc]initWithFormat:@"-￥%@",[Tool priceChange:model.coupons]];
                    }
                    
                    [commonView labelLeftConfig:@"优惠券" vauleTitle:string];
                    _couponsBtn = commonView.btn1;
                    commonView.vauleLab.textAlignment = 2;
                }
                    break;
                case 2:
                    
                {
                    NSString *vauleTitle = @"未填写";
                    if (![model.code isEqualToString:@""]&&model.code) {
                        //                        model.code = @"";
                        vauleTitle = model.code;
                    }
                    
                    [commonView labelLeftConfig:@"优惠码" vauleTitle:vauleTitle];
                    commonView.vauleLab.textAlignment = 2;
                }
                    break;
                case 3:
                    
                {
                    NSString *value = @"暂无减免";
                    if (model.discount) {
                        value = model.discount;
                    }
                    [commonView labelLeftConfig:@"折扣优惠" vauleTitle:value];
                    commonView.vauleLab.textAlignment = 2;
                    
                }
                    break;
                case 4:
                    
                {
                    NSString *fapiaoStr = @"未填写";
                    NSDictionary *fapiaoDic = [[Tool tools]dictionaryWithJsonString:model.billInfo];
                    if (fapiaoDic) {
                        NSNumber *type = fapiaoDic[@"type"];
                        if (type.intValue==0) {//个人
                            fapiaoStr = [NSString stringWithFormat:@"个人 %@",fapiaoDic[@"orderCheck"]];
                        }else{
                            fapiaoStr = [NSString stringWithFormat:@"公司 %@ %@",fapiaoDic[@"orderCheck"],fapiaoDic[@"code"]];
                        }
                        
                    }
                    [commonView labelLeftConfig:@"发票信息" vauleTitle:fapiaoStr];
                    _billInfoBtn = commonView.btn1;
                    commonView.vauleLab.textAlignment = 2;
                    
                }
                    break;
                case 5:
                    
                {
                    NSString *value = @"未填写";
                    if (![model.remark isEqualToString:@""]) {
                        value = model.remark;
                    }
                    [commonView labelLeftConfig:@"备注" vauleTitle:value];
                    _remarkBtn = commonView.btn1;
                    commonView.vauleLab.textAlignment = 2;
                }
                    break;
                case 6:
                    
                {
                    
                    [commonView labelLeftConfig:@"退货信息" vauleTitle:@""];
                    _backInfoButton = commonView.btn1;
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
 * 产品抬头绘制
 */


-(UIView *)creatGoodTitleView
{
    UIView *titleView = [[UIView alloc]init];
    [self.contentView addSubview: titleView];
    titleView.backgroundColor = [UIColor whiteColor];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(35);
    }];

//    _model.timeStr
//   NSString *tempTime = [NSDate dateStrFromCstampTime:[_model.] withDateFormat:<#(NSString *)#>]
    NSString *timeStr = [[NSString alloc] initWithFormat:@"下单时间：%@",_model.timeStr];
    UILabel *timeLab = [Tool labelWithTitle:timeStr color:The_wordsColor fontSize:13 alignment:0];
    [titleView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.mas_equalTo(titleView);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(150);
    }];
    
    
    
//    NSString *type;
//    NSString *status = @"";
//    if (_model.refundOrExchangeTypeNum==nil||_model.refundOrExchangeTypeNum.intValue==0) {
//        status = _model.type;
//    }else{
//        if (_model.refundOrExchangeTypeNum.intValue==1) {//退货
//            type = @"退货";
//        }else{
//            type = @"换货";
//        }
//
//        switch (_model.statusNum.intValue) {
//            case 1://申请
//                status = [NSString stringWithFormat:@"申请%@",type];
//                break;
//            case 2://中
//                status = [NSString stringWithFormat:@"%@中",type];
//                break;
//            case 3://拒绝
//                status = [NSString stringWithFormat:@"%@失败",type];
//                break;
//            case 4:
//                status = [NSString stringWithFormat:@"%@成功",type];
//                break;
//
//            default:
//                break;
//        }
//    }
//
    switch (_model.statusNum.intValue) {
        case 1:
            _model.type = @"待付款";
            break;
        case 2:
            _model.type = @"待发货";
            break;
        case 4:
            _model.type = @"待评价";
            break;
        case 5:
            _model.type = @"已完成";
            break;
        case 6:
            _model.type = @"待收货";
            break;
        default:
            break;
    }
    
    
   UILabel *  _TypeLab = [Tool labelWithTitle:_model.type color:The_wordsColor fontSize:13 alignment:2];
    [self.contentView addSubview:_TypeLab];
    
    [_TypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.right.mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(65, 15));
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
    
    
    
    if ([_TypeLab.text isEqualToString:@"待付款"]) {
     
        _TypeLab.textColor = The_TitlePayColor;
        
        
    }else if ([_TypeLab.text isEqualToString:@"待收货"]){
      
        _TypeLab.textColor = BXColor(152, 187, 227);
    }else if ([_TypeLab.text isEqualToString:@"待评价"]){
       
        _TypeLab.textColor = BXColor(148, 192, 188);
        
    }else if ([_TypeLab.text isEqualToString:@"已完成"]){
      
            _TypeLab.textColor = BXColor(152, 238, 179);
        
    }
    
    return titleView;
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
        make.height.mas_equalTo(12);
//        make.size.mas_equalTo(CGSizeMake(self.singleProductMoneyLabel.bounds.size.width, 12));
    }];
    
    self.detailBackButton = [Tool buttonWithTitle:@"申请售后" titleColor:k888888Color font:12 imageName:nil target:nil action:nil];
    [goodView addSubview:self.detailBackButton];
    [self.detailBackButton addTarget:self action:@selector(detailBackAction:) forControlEvents:UIControlEventTouchUpInside];
    self.detailBackButton.userInteractionEnabled = YES;
    self.detailBackButton.layer.borderColor = kDDDDDDColor.CGColor;
    self.detailBackButton.layer.borderWidth = 1;
    [self.detailBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.top.mas_equalTo(lineView3.mas_bottom).mas_equalTo(12);
    }];
    if ([_model.type isEqualToString:@"待发货"]) {
        [self.detailBackButton setTitle:@"申请退款" forState:UIControlStateNormal];
        self.detailBackButton.hidden = NO;
    }else if ([_model.type isEqualToString:@"待收货"]||[_model.type isEqualToString:@"待评价"]) {
        [self.detailBackButton setTitle:@"申请售后" forState:UIControlStateNormal];
        self.detailBackButton.hidden = NO;
    }else{
        self.detailBackButton.hidden = YES;
    }
    
    NSInteger index = [_model.goodsArr indexOfObject:model];
    self.detailBackButton.tag = 100+index;
    
    if (model.returnStatus.intValue==0||model.returnType==nil) {
        //没有退货
        self.detailBackButton.userInteractionEnabled = YES;
    }else{
        NSString *type;
        NSString *status;
        self.detailBackButton.userInteractionEnabled = NO;
        if (model.returnType.intValue==1) {//退货
            type = @"退货";
        }else{
            type = @"换货";
        }
        
        switch (model.returnStatus.intValue) {
            case 1://申请
                status = [NSString stringWithFormat:@"申请%@",type];
                break;
            case 2://中
                status = [NSString stringWithFormat:@"%@中",type];
                break;
            case 3://拒绝
                status = [NSString stringWithFormat:@"%@失败",type];
                break;
            case 4:
                status = [NSString stringWithFormat:@"%@成功",type];
                break;
                
            default:
                break;
        }
        
        
        self.detailBackButton.layer.borderWidth = 0;
        [self.detailBackButton setTitle:status forState:UIControlStateNormal];
    }
    
    return goodView;
    
}


-(void)detailBackAction:(UIButton *)sender{
    [self.orderDetailCell2Delegate applyForWithTag:sender.tag-100 andTitle:sender.titleLabel.text];
}

//地址绘制
-(void)addressConfig
{
    AddressModel* addressModel = _model.AddressModel;
    
    
//    //当没有地址时
//    if (addressModel == nil) {
//        
//        UIButton *addAddressBtn = [Tool buttonWithTitle:@"" titleColor:The_wordsColor font:18 imageName:nil target:self action:@selector(addAressAction)];
//        addAddressBtn.borderWidth = 1;
//        addAddressBtn.borderColor = The_line_Color_grary;
//        [self.contentView addSubview:addAddressBtn];
//        [addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.mas_offset(20);
//            make.right.bottom.mas_offset(-20);
//        }];
//        
//        [addAddressBtn setImage:[UIImage imageNamed:@"bi@2x.png"] forState:UIControlStateNormal];
//        [addAddressBtn setTitle:@"   添加地址" forState:UIControlStateNormal];
//        addAddressBtn.titleLabel.textAlignment = 0;
//        return;
//    }
    
    UIImageView *dizhiImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dizhi@2x.png"]];
    [self.contentView addSubview:dizhiImg];
    [dizhiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(18, 20));
        //        make.centerY.mas_equalTo(self.contentView.centerY);
        make.top.mas_offset(38);
    }];

    
    UILabel *phoneLab = [Tool labelWithTitle:addressModel.phone color:The_TitleColor fontSize:15 alignment:2];
    [self.contentView addSubview:phoneLab];
    
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(biImg.mas_left).mas_offset(-10);
        make.right.mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 16));
        make.top.mas_offset(10);
    }];
    
    if (!addressModel) {
        addressModel = [[AddressModel alloc ]init];
    }
    
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
//        make.right.mas_equalTo(biImg.mas_left).mas_offset(-10);
        make.height.mas_equalTo(50);
        make.right.mas_offset(-10);

        make.top.mas_equalTo(phoneLab.mas_bottom).offset(0);
    }];
    
    
    
}


@end
