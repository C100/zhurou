//
//  GoodsDetailModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/10/15.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetailModel : NSObject

@property(nonatomic,copy) NSString *titleImg;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *detailTitle;
@property(nonatomic,assign) CGFloat detailHeight;
@property(nonatomic,assign) CGFloat canshuCellHeight;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *scleprice;
@property(nonatomic,copy) NSString *goodsId;
@property(nonatomic,copy) NSString *status;

@property(nonatomic, strong) NSNumber *sellCommodityNum;

@property(nonatomic,copy) NSString *isCollection;
@property(nonatomic,copy) NSString *chicunImg;
@property(nonatomic,strong) NSMutableArray *canshuArr;
@property(nonatomic,strong) NSMutableArray *tuijianArr;
@property(nonatomic,strong) NSMutableArray *commentArr;
@property(nonatomic,strong) NSMutableArray *goodsArr;
@property(nonatomic,strong) NSMutableArray *shoppingCareGoodsArr;

@property (nonatomic,strong) NSString *smallUrl;

@property (nonatomic,assign) CGSize firstSize;
@property (nonatomic,assign) CGSize secSize;
@property (nonatomic,assign) CGSize thirdSize;


@end
