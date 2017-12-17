//
//  ZHScreenAdaptation.h
//  showki
//
//  Created by Rain Day on 2017/11/16.
//  Copyright © 2017年 Hangzhou Zhi Han Science and Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

extern CGFloat const ZH4Point7InchScreenFactor;
extern CGFloat const ZH5Point5InchScreenFactor;
extern CGFloat const ZH4Point7To4InchFactor;
extern CGFloat const ZH4Point7To5Point5InchFactor;

@interface ZHScreenAdaptation : NSObject

+ (BOOL)deviceHas3Point5InchScreen;
+ (BOOL)deviceHas4InchScreen;
+ (BOOL)deviceHas4Point7InchScreen;
+ (BOOL)deviceHas5Point5InchScreen;

+ (CGFloat)adaptFloatIn4Point7InchScreen:(CGFloat)floatValue;

@end
