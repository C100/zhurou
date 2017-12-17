//
//  SearchGoodsModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/19.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchGoodsModel : NSObject

//判断是不是搜索页面（搜索和收藏公用一个cell）
@property(nonatomic,assign) BOOL isCollection;

@property(nonatomic,copy) NSString *imgUrl;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *isCollect;

@property(nonatomic,copy) NSString *initalPrice;






@end
