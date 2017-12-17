//
//  ZHPigBannerView.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHPigBannerView : UIView

@property (nonatomic, copy) NSArray *dataSource;

- (void)manageExceptionWhenAutoScroll;

@end
