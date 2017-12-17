//
//  DepositAuthenView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DepositAuthenView : UIView<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong) WKWebView *myWebView;
@property(nonatomic, strong) UIButton *authenButton;

@end
