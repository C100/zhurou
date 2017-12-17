//
//  DepositAuthenView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "DepositAuthenView.h"

@implementation DepositAuthenView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //进行配置控制器
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        //实例化对象
        configuration.userContentController = [WKUserContentController new];
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        //    preferences.minimumFontSize = 100.0;
        configuration.preferences = preferences;
        //判断是否是首页的webview，如果是首页的webview，需要减去顶栏和底栏的高度；如果不是首页的webview，只需要减去顶栏的高度
        self.myWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH - 64 - 50) configuration:configuration];
        
        self.myWebView.backgroundColor = [UIColor whiteColor];
        [self.myWebView setOpaque:NO];
        self.myWebView.UIDelegate = self;
        self.myWebView.navigationDelegate = self;
        [self addSubview:self.myWebView];
        
        
        self.authenButton = [[UIButton alloc]init];
        [self addSubview:self.authenButton];
        [self.authenButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(50);
        }];
        [self.authenButton setTitle:@"我要申请" forState:UIControlStateNormal];
        [self.authenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.authenButton.titleLabel.font = kFont(18);
        [self.authenButton setBackgroundColor:The_MainColor];
    }
    return self;
}

@end

