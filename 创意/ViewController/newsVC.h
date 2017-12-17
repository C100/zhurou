//
//  newsVC.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/5.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "BaseViewController.h"

#import "HomeModel.h"

@interface newsVC : BaseViewController


@property(nonatomic,strong) HomeModel *homemodel;

@property(nonatomic,copy) NSString *chuanyiId;

@property(nonatomic,copy) NSString *pageTitle;
@property(nonatomic,copy) NSString *resourceUrl;
//@property(nonatomic,copy) NSString *url;
@property(nonatomic,assign) BOOL  isComment;




@end
