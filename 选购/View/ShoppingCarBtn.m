//
//  ShoppingCarBtn.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/10/29.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "ShoppingCarBtn.h"

@implementation ShoppingCarBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}


-(void)configUI
{
    

    
    [self setBackgroundImage:[UIImage imageNamed:@"gouwuche@2x.png"] forState:UIControlStateNormal];
    
//    [self setImage:[UIImage imageNamed:@"gouwuche@2x.png"] forState:UIControlStateNormal];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _numLab = [[UILabel alloc]init];
    _numLab.textColor = [UIColor whiteColor];
    _numLab.cornerRadius = 2;
    _numLab.frame = CGRectMake(15, 0, 8, 8);
    _numLab.backgroundColor = [UIColor redColor];
    _numLab.textAlignment = NSTextAlignmentCenter;
    _numLab.font = [UIFont systemFontOfSize:7];
    _numLab.hidden = YES;
    [self addSubview:_numLab];
      //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(perpareData) name:@"shoppingCarChange" object:nil];
    [self perpareData];
    
}

-(void)perpareData
{
    
    [HttpRequestManager postShoppingCarGetRequest:nil viewcontroller:nil finishBlock:^(NSMutableArray *data) {
        
        NSString *num = [[NSString alloc]initWithFormat:@"%lu",(unsigned long)data.count ];
        _numLab.hidden = NO;
        _numLab.text = num;
        if (data.count >= 10) {
            _numLab.frame = CGRectMake(15, 0, 12, 8);
        }else
        {
            _numLab.frame = CGRectMake(15, 0, 8, 8);
        }
        if (data.count == 0) {
            _numLab.hidden = YES;
        }
        
        
    }];

}



@end
