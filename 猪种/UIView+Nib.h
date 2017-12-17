//
//  UIView+Nib.h
//  showki
//
//  Created by Rain Day on 2017/11/14.
//  Copyright © 2017年 Hangzhou Zhi Han Science and Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Nib)

- (UIView *)zhAddNibNamed:(NSString *)nibName;

- (UIView *)zhAddSubviewToFillContent:(UIView *)view;

@end
