//
//  LoginView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/30.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property(nonatomic, strong) NSArray *contents;
@property(nonatomic, strong) NSArray *images;

@property(nonatomic, strong) UIView *lastView;
@property(nonatomic, strong) UIButton *eyeButton;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UIButton *registerButton;
@property(nonatomic, strong) UIButton *forgetButton;

@end
