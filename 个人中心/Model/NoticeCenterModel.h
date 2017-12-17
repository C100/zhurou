//
//  NoticeCenterModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/11.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeCenterModel : NSObject


@property(nonatomic,assign) BOOL isOpen;
@property(nonatomic,copy) NSString *isRead;

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *timeStr;

@property(nonatomic,copy) NSString *imgUrl;
@property(nonatomic,copy) NSString *detailStr;
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *turnID;


@property(nonatomic,assign) CGFloat detailStrHeight;

-(NSComparisonResult)compareByTime:(NoticeCenterModel *)model;

@end
