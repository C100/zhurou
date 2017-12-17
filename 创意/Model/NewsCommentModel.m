//
//  NewsCommentModel.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "NewsCommentModel.h"

@implementation NewsCommentModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _replyModelArr = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
