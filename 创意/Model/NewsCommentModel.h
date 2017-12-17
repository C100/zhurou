//
//  NewsCommentModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsCommentModel : NSObject



@property(nonatomic,copy) NSString *nameImgUrl;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *detailTitle;
@property(nonatomic,assign) NSInteger num;


@property(nonatomic,strong) NSMutableArray *replyModelArr;

@property(nonatomic,assign) CGFloat detailTitleHeight;
@property(nonatomic,assign) CGFloat replyTitleHeight;


@property(nonatomic,assign) BOOL havePingLunTitle;


@end
