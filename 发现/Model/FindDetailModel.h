//
//  FindDetailModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/10/18.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindDetailModel : NSObject

@property(nonatomic,copy) NSString *titleImg;
@property(nonatomic,copy) NSString *detailTitle;
@property(nonatomic,copy) NSString *Title;
@property(nonatomic,copy) NSString *titleImgType;
//@property(nonatomic,copy) NSString *Title;
//@property(nonatomic,copy) NSString *Title;



@property(nonatomic,strong) NSMutableArray *contentArr;
@property(nonatomic,strong) NSMutableArray *googsArr;

@property(nonatomic,assign) CGFloat detailHeight;

@property (nonatomic,strong) NSString *price;

@end
