//
//  AgreementView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AgreementView.h"

@implementation AgreementView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        //进行配置控制器
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        //实例化对象
        configuration.userContentController = [WKUserContentController new];
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        //    preferences.minimumFontSize = 100.0;
        configuration.preferences = preferences;
        //判断是否是首页的webview，如果是首页的webview，需要减去顶栏和底栏的高度；如果不是首页的webview，只需要减去顶栏的高度
        self.myWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        
        self.myWebView.backgroundColor = [UIColor whiteColor];
        [self.myWebView setOpaque:NO];
        self.myWebView.UIDelegate = self;
        self.myWebView.navigationDelegate = self;
        [self addSubview:self.myWebView];
        [self.myWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).with.offset(10);
            make.right.mas_equalTo(self.mas_right).with.offset(-10);
            make.top.equalTo(self).with.offset(10);
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(-110);
        }];
        
        self.chooseButton = [[UIButton alloc]init];
        [self addSubview:self.chooseButton];
        [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).with.offset(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.myWebView.mas_bottom);
            make.height.mas_equalTo(60);
        }];
        self.chooseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.chooseButton.titleLabel.font = kFont(14);
        [self.chooseButton setTitleColor:k555555Color forState:UIControlStateNormal];
        [self.chooseButton setTitle:@"我已阅读并同意此份协议" forState:UIControlStateNormal];
        [self.chooseButton setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
        [self.chooseButton setImage:[UIImage imageNamed:@"勾"] forState:UIControlStateSelected];
        self.chooseButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        [self.chooseButton addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.sureButton = [[UIButton alloc]init];
        [self addSubview:self.sureButton];
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(50);
        }];
        [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sureButton.titleLabel.font = kFont(18);
        [self.sureButton setBackgroundColor:The_MainColor];
        self.sureButton.alpha = .5;
        self.sureButton.enabled = NO;
        
    }
    return self;
}

-(void)chooseAction{
    self.chooseButton.selected = !self.chooseButton.selected;
    if (self.chooseButton.selected==YES) {
        self.sureButton.alpha = 1;
        self.sureButton.enabled = YES;
    }else{
        self.sureButton.alpha = .5;
        self.sureButton.enabled = NO;
    }
}

@end

