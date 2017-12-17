//
//  LHeadButtonsView.m
//  Superlawyer-Lawyer
//
//  Created by 刘岑颖 on 17/2/8.
//  Copyright © 2017年 xiyoukeji. All rights reserved.
//

#import "WHeadButtonsView.h"

@implementation WHeadButtonsView
- (instancetype)initWithTitlesArray:(NSArray *)titlesArray with:(BOOL )needRename//按钮是否需要重新赋值默认为NO
{
    self = [super init];
    if (self) {
        
//        self.backgroundColor = k1E1E1EColor;
        
        UIView *linView = [[UIView alloc]init];
        self.bottomView = linView;
        linView.backgroundColor = kD6D6D6Color;
        [self addSubview:linView];
        [linView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(-1);
        }];
        
        self.titlesArray = titlesArray;
        self.buttonsArray = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = KHScreenW/titlesArray.count;
        for (int i = 0; i < titlesArray.count; i ++) {
            NSString *titleString = titlesArray[i];
            UIButton *button = [Tool buttonWithTitle:titleString titleColor:nil font:16 imageName:nil target:nil action:nil];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            button.titleLabel.font = UIFontMake(16);
            [button addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
            button.userInteractionEnabled = YES;
            button.frame = CGRectMake(width * i, 0, width, 39);
            button.tag = 10 + i;
            [self addSubview:button];
            [self.buttonsArray addObject:button];
            if (i == 0) {
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
            if (needRename) {
                switch (i) {
                    case 0:
                        _btn1 = button;
                        break;
                    case 1:
                        _btn2 = button;
                        break;
                    case 2:
                        _btn3 = button;
                        break;
                    case 3:
                        _btn4 = button;
                        break;
                    case 4:
                        _btn5 = button;
                        break;
                    case 5:
                        _btn6 = button;
                        break;
                    case 6:
                        _btn7 = button;
                        break;
                    default:
                        break;
                }
            }
            
        }
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake((width-20)/2, 40, 20, 3)];
        self.lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lineView];
        self.lineView.layer.masksToBounds = YES;
        // self.lineView.layer.cornerRadius = 2.0;
    }
    return self;
    
}

- (instancetype)initWithTitlesArray:(NSArray *)titlesArray
{
    
    return [self initWithTitlesArray:titlesArray with:NO];
}

- (void)buttonClickedAction:(UIButton *)button{
    NSInteger i = button.tag - 10;
    if (self.lastButtonTag == i) {
        return;
    }
    CGFloat width = KHScreenW/self.titlesArray.count;
    
    _HeadButtonsCallBack(i);
    
    for (UIButton *button in self.buttonsArray) {
        [button setTitleColor:kAAAAAAColor forState:UIControlStateNormal];
    }
    
    [button setTitleColor:The_MainColor forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = CGRectMake((width-20)/2+width*i, 40, 20, 3);
        self.lineView.frame = frame;
    }];
    self.lastButtonTag = i;
    
}

@end
