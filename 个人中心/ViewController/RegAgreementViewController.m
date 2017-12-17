//
//  RegAgreementViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "RegAgreementViewController.h"
#import <WebKit/WebKit.h>

@interface RegAgreementViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong) WKWebView *webView;

@end

@implementation RegAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.topTitle;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, KHScreenW, 64)];
    topView.backgroundColor = The_MainColor;
    [self.view addSubview:topView];
    
    //进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [WKUserContentController new];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    //    preferences.minimumFontSize = 100.0;
    configuration.preferences = preferences;
    //判断是否是首页的webview，如果是首页的webview，需要减去顶栏和底栏的高度；如果不是首页的webview，只需要减去顶栏的高度
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64) configuration:configuration];
    
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView setOpaque:NO];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
}


@end
