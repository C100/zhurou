//
//  ZHScreenAdaptation.m
//  showki
//
//  Created by Rain Day on 2017/11/16.
//  Copyright © 2017年 Hangzhou Zhi Han Science and Technology Co., Ltd. All rights reserved.
//

#import "ZHScreenAdaptation.h"
#import <sys/utsname.h>

CGFloat const ZH4Point7InchScreenFactor = 375.0f / 320.0f;
CGFloat const ZH5Point5InchScreenFactor = 1242.0f / 3.0f / 320.0f;
CGFloat const ZH4Point7To4InchFactor = 320.0f / 375.0f;
CGFloat const ZH4Point7To5Point5InchFactor = 1242.0f / 3.0f / 375.0f;

@implementation ZHScreenAdaptation

+ (CGFloat)adaptFloatIn4Point7InchScreen:(CGFloat)floatValue {
    CGFloat actualFloatValue = floatValue;
    if ([self deviceHas4InchScreen] || [self deviceHas3Point5InchScreen]) {
        actualFloatValue = floatValue * ZH4Point7To4InchFactor;
    } else if ([self deviceHas4Point7InchScreen]) {
        actualFloatValue = floatValue;
    } else if ([self deviceHas5Point5InchScreen]) {
        actualFloatValue = floatValue * ZH4Point7To5Point5InchFactor;
    }
    return actualFloatValue;
}

+ (BOOL)deviceHas3Point5InchScreen
{
    return [self deviceHasScreenWithIdiom:UIUserInterfaceIdiomPhone scale:2.0 height:480.0];
}

+ (BOOL)deviceHas4InchScreen
{
    return [self deviceHasScreenWithIdiom:UIUserInterfaceIdiomPhone scale:2.0 height:568.0];
}

+ (BOOL)deviceHas4Point7InchScreen
{
    return [self deviceHasScreenWithIdiom:UIUserInterfaceIdiomPhone scale:2.0 height:667.0];
}

+ (BOOL)deviceHas5Point5InchScreen
{
    return [self deviceHasScreenWithIdiom:UIUserInterfaceIdiomPhone scale:3.0 height:736.0];
}

+ (BOOL)deviceHasScreenWithIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom scale:(CGFloat)scale height:(CGFloat)height
{
    CGRect mainScreenBounds = [[UIScreen mainScreen] bounds];
    CGFloat mainScreenHeight;
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    UIDeviceOrientation deviceOrientation;

    switch (statusBarOrientation) {
        case UIInterfaceOrientationPortrait:
            deviceOrientation = UIDeviceOrientationPortrait;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            deviceOrientation= UIDeviceOrientationPortraitUpsideDown;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            deviceOrientation= UIDeviceOrientationLandscapeRight;
            break;
        case UIInterfaceOrientationLandscapeRight:
            deviceOrientation= UIDeviceOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationUnknown:
        default:
            deviceOrientation = UIDeviceOrientationUnknown;
            break;
    }

    if ([self operatingSystemVersionLessThan:@"8.0"]) {
        mainScreenHeight = mainScreenBounds.size.height;
    } else {
        mainScreenHeight = (UIDeviceOrientationIsLandscape)(deviceOrientation) ? mainScreenBounds.size.width : mainScreenBounds.size.height;
    }

    if ([[UIDevice currentDevice] userInterfaceIdiom] == userInterfaceIdiom && [[UIScreen mainScreen] scale] == scale && mainScreenHeight == height) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)operatingSystemVersionLessThan:(NSString *) operatingSystemVersionToCompare
{
    return [[UIDevice currentDevice].systemVersion compare:operatingSystemVersionToCompare options:NSNumericSearch] == NSOrderedAscending;
}

@end
