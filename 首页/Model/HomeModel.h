//
//  HomeModel.h
//  XiJuOBJ
//
//  Created by james on 16/9/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject


@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* titleImgUrl;
@property(nonatomic,copy) NSString* detailTitle;
@property(nonatomic,copy) NSString* Price;
@property(nonatomic,copy) NSString* type;
@property(nonatomic,strong) NSArray* colorArr;
@property(nonatomic,copy) NSArray* imgArr;
@property(nonatomic,copy) NSString* ID;



@property(nonatomic,assign) BOOL isOpen ;

@end
