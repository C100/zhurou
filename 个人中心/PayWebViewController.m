//
//  PayWebViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/7/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "PayWebViewController.h"
//#import "MBProgressHUD.h"
#import <Lottie/Lottie.h>

@interface PayWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
//@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong) LOTAnimationView *animationView;

@end

@implementation PayWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    self.hud.mode = MBProgressHUDModeIndeterminate;
//    self.hud.label.text = @"加载中";
    
    self.animationView = [LOTAnimationView animationNamed:@"data"];
    self.animationView.contentMode = UIViewContentModeScaleAspectFit;
    self.animationView.frame = CGRectMake(0, 200, ScalePx(100), ScalePx(100));
    [[UIApplication sharedApplication].keyWindow addSubview:self.animationView];
    self.animationView.center = [UIApplication sharedApplication].keyWindow.center;
    
    self.animationView.loopAnimation = YES;
    self.animationView.animationProgress = 0;
    [self.animationView play];
    
    
  
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    
    NSString *url = [self.html componentsSeparatedByString:@"?"].firstObject;
    NSString *params = [self.html componentsSeparatedByString:@"?"].lastObject;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
//    NSDictionary *dictionnary = @{@"UserAgent":@"Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)",@"Content-type":@"application/x-www-form-urlencoded"};
//    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    
    
    [self.webView loadRequest:request];
//    [self.webView loadHTMLString:self.html baseURL:nil];
    self.webView.delegate = self;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    if ([self.isFirst isEqualToString:@"first"]) {
//        self.isFirst = @"second";
//        return YES;
//    }else if([self.isFirst isEqualToString:@"second"]){
//        NSString *url = request.URL.absoluteString;
//        PayWebViewController *vc = [[PayWebViewController alloc]init];
//        vc.html = url;
//        [self.navigationController pushViewController:vc animated:YES];
//        return NO;
//
//    }else{
//        return YES;
//    }
    return YES;
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    [self.hud hideAnimated:YES];
    self.animationView.hidden = YES;
}



@end
