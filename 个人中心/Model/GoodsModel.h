//
//  GoodsModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/27.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property(nonatomic,copy) NSString *imgUrl;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *scalePrice;

@property(nonatomic,copy) NSString *number;
@property(nonatomic,copy) NSString *leftNumber;  //库存

@property(nonatomic,copy) NSString *color;
@property(nonatomic,copy) NSString *colorName;

@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *goodsId;      //产品总id
@property(nonatomic,copy) NSString *detailId;      //具体产品id（选择颜色，产品之后）


@property(nonatomic,copy) NSString *commentStr;    //产品评论
@property(nonatomic,copy) NSString *commentImgurl;  //评论图片url
@property(nonatomic,strong) NSMutableArray *commentImgArr;  //评论图片url
@property(nonatomic,copy) NSString *timeStr;  //下单时间


//优惠码
@property (nonatomic,strong) NSString *promotionCode;

@property(nonatomic, strong) NSNumber *returnStatus;
@property(nonatomic, strong) NSNumber *returnType;



@end
