//
//  ZHPigBuyView.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZHPigBuyViewDelegate;
@class ZHPigInfoModel;
@class ZHPigBuyModel;
@interface ZHPigBuyView : UIView

@property (nonatomic, weak) id <ZHPigBuyViewDelegate> delegate;

- (void)configureWithPigInfoModel:(ZHPigInfoModel *)pigInfoModel;

- (void)show;

@end

@protocol ZHPigBuyViewDelegate <NSObject>

- (void)pigBuyView:(ZHPigBuyView *)pigBuyView confirmWithModel:(ZHPigBuyModel *)model;

@end
