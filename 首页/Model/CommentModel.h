//
//  CommendModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/11.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject


@property(nonatomic,copy) NSString *nameImgUrl;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *timeint;

@property(nonatomic,copy) NSString *detailTitle;
@property(nonatomic,copy) NSString *replyTitle;
@property(nonatomic,copy) NSString *commentNumber;

@property(nonatomic,strong) NSMutableArray *imgArr;

@property(nonatomic,assign) CGFloat detailTitleHeight;
@property(nonatomic,assign) CGFloat replyTitleHeight;
@property(nonatomic,assign) CGFloat index;


@property(nonatomic,assign) BOOL havePingLunTitle;

@end
