//
//  SeearchTitleView.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/19.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchSelectModel.h"

@protocol SeearchTitleViewDelegate <NSObject>

-(void)searchContent:(NSString *)content;
-(void)beginEdit;

@end

@interface SeearchTitleView : UIView<UISearchBarDelegate>

@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UIButton *cancelButton;

@property(nonatomic,strong) UIButton *Btn1;
@property(nonatomic,strong) UIButton *Btn2;
@property(nonatomic,strong) UIButton *Btn3;

@property(nonatomic,strong) NSMutableArray *arr1;
@property(nonatomic,strong) NSMutableArray *arr2;
@property(nonatomic,strong) NSMutableArray *arr3;


@property(nonatomic,strong) UIViewController *vc;
@property(nonatomic,strong) UIView *backView;

@property(nonatomic, strong) UIView *titleView;
@property(nonatomic, strong) UIView *searchView;

@property(nonatomic,copy)  void (^Callback)(SearchSelectModel *model);

-(void)congigUI;

@property(nonatomic, weak) id<SeearchTitleViewDelegate> seearchTitleViewDelegate;

@end


