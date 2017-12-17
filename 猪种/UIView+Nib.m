//
//  UIView+Nib.m
//  showki
//
//  Created by Rain Day on 2017/11/14.
//  Copyright © 2017年 Hangzhou Zhi Han Science and Technology Co., Ltd. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)

- (UIView *)zhAddNibNamed:(NSString *)nibName {
    UIView *view = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil][0];

    return [self zhAddSubviewToFillContent:view];
}

- (UIView *)zhAddSubviewToFillContent:(UIView *)view {
    NSDictionary *viewsDictionary = @{ @"view" : view };

    view.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:view];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:viewsDictionary]];
    return view;
}

@end
