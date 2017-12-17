//
//  LHeadButtonsView.h
//  Superlawyer-Lawyer
//
//  Created by 刘岑颖 on 17/2/8.
//  Copyright © 2017年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHeadButtonsView : UIView

@property (nonatomic,copy) void(^HeadButtonsCallBack) (NSInteger i);

@property (nonatomic) UIView *lineView;
@property(nonatomic, strong) UIView *bottomView;
@property (nonatomic) NSArray *titlesArray;
@property (nonatomic) NSMutableArray *buttonsArray;
- (instancetype)initWithTitlesArray:(NSArray *)titlesArray;
- (instancetype)initWithTitlesArray:(NSArray *)titlesArray with:(BOOL )needRename;//按钮是否需要重新赋值默认为NO

@property (nonatomic) NSInteger lastButtonTag;


@property(nonatomic,strong) UIButton *btn1;
@property(nonatomic,strong) UIButton *btn2;
@property(nonatomic,strong) UIButton *btn3;
@property(nonatomic,strong) UIButton *btn4;
@property(nonatomic,strong) UIButton *btn5;
@property(nonatomic,strong) UIButton *btn6;
@property(nonatomic,strong) UIButton *btn7;

@end
