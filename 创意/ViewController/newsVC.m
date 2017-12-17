//
//  newsVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/5.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "newsVC.h"
#import "NewsCommentVC.h"

@interface newsVC ()<UIWebViewDelegate>


@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIButton *commentBtn;


@end



@implementation newsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareData];
//    [self configUI];
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"fenxiang@2x.png"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
}



-(void)viewDidDisappear:(BOOL)animated
{
    _webView.delegate = nil;
}

#pragma mark buttonAction

-(void)shareAction
{
    BXLog(@"分享");
    
    NSString *imgUrl = [[NSString alloc]initWithFormat:@"%@%@",ImgBase_Url,_homemodel.titleImgUrl];
    [[Tool tools]myshare:self title:_homemodel.title detailTitle:_homemodel.detailTitle imgArr:@[imgUrl] url:_resourceUrl];
    
}

#pragma mark intviewcontroller
-(void)prepareData
{
    NSDictionary *dic = @{@"id":_chuanyiId,
                          };
    
    [HttpRequestManager postChuanyiDeatailRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data ,NSMutableArray *arr) {
        
        NSDictionary *infoDic = data[@"info"];
        _resourceUrl = infoDic[@"chuanyiContent"];
        self.title = infoDic[@"chuanyiName"];
        
        
//        _resourceUrl = @"http://m.toutiao.com/profile/54336770531/";
        
        [self configUI];
    }];
    
}

-(void)configUI
{
    NSString *tmpUrl = self.resourceUrl;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KHScreenW,KHScreenH-64)];
//    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    
    NSURL *url = [NSURL URLWithString:tmpUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];

    
    _commentBtn  = [[UIButton alloc]init];
    [_commentBtn setBackgroundImage:[UIImage imageNamed:@"pinglun@3x.png"] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(pingLunAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commentBtn];
    [self.view bringSubviewToFront:_commentBtn];

    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_offset(-10);
        make.top.mas_offset(10);
    }];
    
  
    
    
    
    
}

#pragma mark buttonAction

-(void)pingLunAction
{
    
    NewsCommentVC *vc = [[NewsCommentVC alloc]init];
    vc.chuanyiId = _chuanyiId;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - UIWebViewDelegate

//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//}
//
//-(void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    
//}
//
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    
//}
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    
//    return YES;
//}





@end
