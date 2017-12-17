//
//  AuthenView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/22.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuthenViewDelegate <NSObject>

-(void)tapImageViewWithTag:(NSInteger)tag;

@end

@interface AuthenView : UIView

@property (nonatomic,strong) UIButton *applyButton;
@property (nonatomic,weak) id<AuthenViewDelegate> authenViewDelegate;

@end
