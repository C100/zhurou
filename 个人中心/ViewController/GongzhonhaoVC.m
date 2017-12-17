//
//  GongzhonhaoVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/25.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "GongzhonhaoVC.h"
#import "AlertVC.h"
@interface GongzhonhaoVC ()<UIActionSheetDelegate>
{
    UIImageView * _titleImageView ;
    NSString *_urlStr;
}

@end

@implementation GongzhonhaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    self.title = @"壹筑e家公众号";
    self.view.backgroundColor = The_list_backgroundColor;
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    
    _urlStr = @"http://mp.weixin.qq.com/mp/getmasssendmsg?__biz=MzI3MTM1MTgzMQ==#wechat_webview_type=1&wechat_redirect";
    
    [HttpRequestManager postGetGongzhonghaoRequest:nil viewcontroller:self finishBlock:^(NSDictionary *data) {
        
        NSDictionary *infoDic = data[@"info"];
        
        //        NSString *ID = infoDic[@"id"];
        //        NSString *phoneNum = infoDic[@"kfMobile"];
//        NSString *spreadUrl = infoDic[@"spreadUrl"];
                NSString *wxPubPic = infoDic[@"wxPubPic"];
                NSString *wxPubUrl = infoDic[@"wxPubUrl"];
        
        [Tool setImgurl:_titleImageView imgurl:wxPubPic];
        
        _urlStr = wxPubUrl;
    } andIsShowLoading:YES];
    
}

-(void)configUI
{
    
    _titleImageView = [[UIImageView alloc]init];
//    _titleImageView.image = [UIImage imageNamed:@"erweima2.png"];
    _titleImageView.userInteractionEnabled = YES;
    [self.view addSubview:_titleImageView];
    
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    [_titleImageView addGestureRecognizer:longPress];

    
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UILabel *nameLab = [Tool labelWithTitle:@"长按二维码，将壹筑e家官方公众号分享给你的好友！" color:The_wordsColor fontSize:13 alignment:1];
    [self.view addSubview:nameLab];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(_titleImageView.mas_bottom).mas_offset(30);
    }];
    
}

#pragma mark buttonAction

-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{

    
    
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"发送给微信朋友",@"保存图片",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        //        [actionSheet setValue:[UIColor redColor] forKey:@"_titleTextColor"];
        [actionSheet showInView:self.view];
        
    }else {
//        NSLog(@”long pressTap state :end”);
    }
    
    
}



-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        NSArray *imgArr = @[_titleImageView.image];
//        NSString *url = _urlStr;
//        [[Tool tools] myshare:self title:@"壹筑e家" detailTitle:@"壹筑e家公众号" imgArr:imgArr url:url];
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"壹筑e家公众号"
                                         images:imgArr
                                            url:nil
                                          title:@"壹筑e家"
                                           type:SSDKContentTypeImage];
        
        
        
        [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                default:
                    break;
            }
            
        }];
        
           }
    if(buttonIndex == 1){
        
        [self saveImageToPhotos: _titleImageView.image ];
        
          }
    return;
}



//实现该方法
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
}
//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    
    
    [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:msg];
    
}


@end
