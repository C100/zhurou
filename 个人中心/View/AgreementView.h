//
//  AgreementView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface AgreementView : UIView<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong) WKWebView *myWebView;
@property(nonatomic, strong) UIButton *sureButton;
@property(nonatomic, strong) UIButton *chooseButton;
@property(nonatomic, strong) UIButton *cancelButton;

@end
