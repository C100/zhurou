//
//  ServiceViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/6/29.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ServiceViewController.h"
#import <WebKit/WebKit.h>

@interface ServiceViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"壹筑e家客服";
    
    /*
     访问百度网桥 方法一：添加UserAgent
     方法二：先访问www.baidu.com 再访问百度网桥
     */
    
//    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
//    [self.view addSubview:self.webView];
    
//    NSString *originUA = [self.webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
//    
//    NSString *newUA = [NSString stringWithFormat:@"%@ %@",originUA,@"your userAgent"];       NSDictionary *dictionary = @{@"UserAgent":newUA};
//    
//    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    

    
    self.webView.backgroundColor = [UIColor whiteColor];
    
    NSString *url1 = @"http://www.baidu.com";
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url1]];
    self.webView.delegate = self;
    [self.webView loadRequest:request1];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if ([request.URL.absoluteString isEqualToString:@"http://www.baidu.com/"]) {
        NSString *url = @"http://p.qiao.baidu.com/cps/chat?siteId=9816277&userId=22130409";
        NSMutableURLRequest *requestUrl = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [webView loadRequest:requestUrl];
        
        return NO;
    }
    return YES;
}



@end
