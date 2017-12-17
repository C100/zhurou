//
//  XiJuIntroduceVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/12.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "XiJuIntroduceVC.h"

@interface XiJuIntroduceVC ()
{
    UILabel *_textLab;
    UIScrollView *_scrollView;
}

@end

@implementation XiJuIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"壹筑e家介绍";
    
    if (_isxieyi) {
        self.title = @"用户协议";
    }else
    {
        self.title = @"壹筑e家介绍";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    _scrollView = scrollView;
    scrollView.layer.borderWidth = 1;
    scrollView.layer.borderColor = [The_line_Color_grary CGColor];
    [self.view addSubview:scrollView];
    
    scrollView.frame = CGRectMake(20, 20, KHScreenW - 40, KHScreenH-125-64);
    NSString *txt =@"壹筑e家，一个立足于线上经营的新锐个性化创意化柜类家具品牌，融合潮流与居家的概念，打造极具自我风格的柜类产品。产品涵 盖卧室、客厅、书房、餐厅等多个空间配套，跨越多种风格，融合当代潮流元素，透过每一件家具产品，传递“因创意而时尚”的家居主张，唤醒当代年轻人对生活的品位和追求。壹筑e家APP，是一款购物分享APP，汇聚了符合当下时代审美的个性化柜类家具单品，为20-30岁的年轻群体带来高性价比的创意家具产品。壹筑e家APP将互联网+的理念、技术、体验完美连接，去掉中间渠道的冗余和成本，在为您带来更快捷更省钱的网络购物体验，让更多的人感受到壹筑e家的美好。";
    
    if (_isxieyi) {
        [HttpRequestManager getUserAgreementWithFinishBlock:^(NSDictionary *dataDic) {
            if (dataDic) {
                _textLab.text = dataDic[@"info"];
                CGSize maxSize = [_textLab.text sizeWithFont:[UIFont fontWithName:The_titleFont size:16] maxSize:CGSizeMake(KHScreenW-60, CGFLOAT_MAX)];
                
                _textLab.frame = CGRectMake(10, 10,KHScreenW - 60, maxSize.height);
                _scrollView.contentSize = CGSizeMake(0, maxSize.height+15);
                
            }
        }];
    }else{
        [HttpRequestManager aboutUsWithFinishBlock:^(NSDictionary *dataDic) {
            if (dataDic) {
                _textLab.text = dataDic[@"info"];
                CGSize maxSize = [_textLab.text sizeWithFont:[UIFont fontWithName:The_titleFont size:16] maxSize:CGSizeMake(KHScreenW-60, CGFLOAT_MAX)];
                
                _textLab.frame = CGRectMake(10, 10,KHScreenW - 60, maxSize.height);
                _scrollView.contentSize = CGSizeMake(0, maxSize.height+15);
            }
        }];
    }
    
    
    _textLab = [Tool labelWithTitle:@"" color:The_TitleColor fontSize:16 alignment:0];
    _textLab.numberOfLines = 0;
    [scrollView addSubview:_textLab];
    
    CGSize maxSize = [txt sizeWithFont:[UIFont fontWithName:The_titleFont size:16] maxSize:CGSizeMake(KHScreenW-60, CGFLOAT_MAX)];
    
    _textLab.frame = CGRectMake(10, 10,KHScreenW - 60, maxSize.height);
    scrollView.contentSize = CGSizeMake(KHScreenW - 40,maxSize.height + 40 );


    UILabel *underLab = [Tool labelWithTitle:@"杭州同富家居有限公司\n copyright@2016" color:The_TitleColor fontSize:15 alignment:1];
    [self.view addSubview:underLab];
    
    underLab.frame = CGRectMake(10, KHScreenH - 80-64, KHScreenW - 20, 40);
    
    
}

-(void)configUI
{
    
}

#pragma mark buttonAction

@end
