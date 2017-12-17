//
//  SeearchTitleView.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/19.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "SeearchTitleView.h"
#import "SearchSelectModel.h"


@interface SeearchTitleView()
{
    UIView *_BtnBackView;
    NSMutableArray *_btnArr;
    NSMutableArray *_selectArr;
}




@end


@implementation SeearchTitleView

-(void)congigUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
//        subView = nil;
    }
    
    self.searchView = [[UIView alloc]init];
    [self addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    self.cancelButton = [Tool buttonWithTitle:@"取消" titleColor:k272F3FColor font:16 imageName:nil target:nil action:nil];
    [self.searchView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(11);
        make.size.mas_equalTo(CGSizeMake(32, 18));
    }];
    
    self.searchBar = [[UISearchBar alloc]init];
    [self.searchView addSubview:self.searchBar];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"搜索提示";
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.cancelButton.mas_left).mas_equalTo(-13);
    }];
//    self.searchBar.tintColor = kF4F4F4Color;
    UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = kF4F4F4Color;
    _searchBar.backgroundImage = [[UIImage alloc] init];
    
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:titleView];
    self.titleView = titleView;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(40);
    }];
    
    UIView *topLineView = [[UIView alloc]init];
    topLineView.backgroundColor = The_line_Color_grary;
    [titleView addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    CGFloat width = KHScreenW/3;
    
    _Btn1 = [Tool buttonWithTitle:@"场景" titleColor:The_wordsColor font:13 imageName:nil target:self action:@selector(buttonAction:)];
    _Btn1.tag = 1001;
    [_Btn1 setTitleColor:The_MainColor forState:UIControlStateSelected];
    [_Btn1 setImage:[UIImage imageNamed:@"shang@2x.png" ]forState:UIControlStateSelected];
    [_Btn1 setImage:[UIImage imageNamed:@"xia@2x.png" ]forState:UIControlStateNormal];

    [titleView addSubview:_Btn1];
    
    [_Btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(width, 40));
        make.top.mas_equalTo(1);
    }];
    
    _Btn2 = [Tool buttonWithTitle:@"色系" titleColor:The_wordsColor font:13 imageName:@"xia@2x.png" target:self action:@selector(buttonAction:)];
    [titleView addSubview:_Btn2];
    _Btn2.tag = 1002;

    [_Btn2 setTitleColor:The_MainColor forState:UIControlStateSelected];
    [_Btn2 setImage:[UIImage imageNamed:@"shang@2x.png" ]forState:UIControlStateSelected];
    [_Btn2 setImage:[UIImage imageNamed:@"xia@2x.png" ]forState:UIControlStateNormal];
    
    [_Btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(1);
        make.left.mas_equalTo(_Btn1.mas_right);
        make.size.mas_equalTo(CGSizeMake(width, 40));
    }];
    
    _Btn3 = [Tool buttonWithTitle:@"类别" titleColor:The_wordsColor font:13 imageName:@"xia@2x.png" target:self action:@selector(buttonAction:)];
    [titleView addSubview:_Btn3];
    _Btn3.tag = 1003;

    [_Btn3 setTitleColor:The_MainColor forState:UIControlStateSelected];
    [_Btn3 setImage:[UIImage imageNamed:@"shang@2x.png" ]forState:UIControlStateSelected];
    [_Btn3 setImage:[UIImage imageNamed:@"xia@2x.png" ]forState:UIControlStateNormal];
    
    [_Btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(1);
        make.left.mas_equalTo(_Btn2.mas_right);
        make.size.mas_equalTo(CGSizeMake(width, 40));
    }];

    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = The_line_Color_grary;
    [titleView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.mas_offset(0);
        make.height.mas_equalTo(1);
    }];
    
    
//        [_vc.view addSubview:titleView];
//        [_vc.view bringSubviewToFront:titleView];
    
    
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(40);
        }];
    
    
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = BXAlphaColor(0, 0, 0, 0.3);
    [_vc.view addSubview:_backView];
    [_vc.view bringSubviewToFront:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.top.mas_equalTo(titleView.mas_bottom);
    }];
    _backView.hidden = YES;

    [_backView addTarget:self action:@selector(btnViewTackBack)];

    SearchSelectModel *buxianModel = [[SearchSelectModel alloc]init];

    buxianModel.title = @"不限";
    
    if (!_arr1) {
        _arr1 = [[NSMutableArray alloc]init];
    }
    if (!_arr2) {
        _arr2 = [[NSMutableArray alloc]init];
    }
    if (!_arr3) {
        _arr3 = [[NSMutableArray alloc]init];
    }
    
//    [_arr1 insertObject:buxianModel atIndex:0];
////    [_arr1 insertObjects:buxianModel atIndexedSubscript:0];
//    [_arr2 setObject:buxianModel atIndexedSubscript:0];
//    [_arr3 setObject:buxianModel atIndexedSubscript:0];

    
    if (!_BtnBackView) {
        _BtnBackView = [[UIView alloc]init];
    }
    _BtnBackView.backgroundColor = [UIColor whiteColor];
    _BtnBackView.frame = CGRectMake(0, 0, KHScreenW, 0);
    [_backView addSubview:_BtnBackView];
}



#pragma mark buttionAction

-(void)buttonAction:(UIButton *)btn
{

    [self btnIsNoSelect:btn];
    btn.selected = !btn.selected;
    NSMutableArray *tempArr = nil;

    //选择将要显示的数据
    
    switch (btn.tag) {
        case 1001:
            tempArr = _arr1;
            break;
        case 1002:
            tempArr = _arr2;
            break;
        case 1003:
            tempArr = _arr3;
            break;

        default:
            break;
    }
    
    
    _selectArr = tempArr;
    
   
    
    NSArray *btnArr = _BtnBackView.subviews;
    for (int i = 0; i < btnArr.count; i++) {
        UIView *btn =btnArr[i];
        [btn removeFromSuperview];
    }
    
    
    CGFloat width = KHScreenW/4;
    CGFloat height = 40;
    CGFloat lasetY = 0;
    
    for (int i = 0; i < tempArr.count; i++) {
        SearchSelectModel *Model =tempArr[i];
        
        UIButton *selectBtn = [Tool buttonWithTitle:Model.title titleColor:The_wordsColor font:15 imageName:nil target:self action:@selector(selectBtnAction:)];
        selectBtn.tag = 1000+i;
        [selectBtn setTitleColor:The_MainColor forState:UIControlStateSelected];
        selectBtn.frame = CGRectMake(i%4*width, i/4*height, width, height);
        [_BtnBackView addSubview:selectBtn];
        lasetY = CGRectGetMaxY(selectBtn.frame);
        
        if (Model.isSelect) {
            selectBtn.selected = YES;
        }
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = The_line_Color_grary;
        lineView.frame = CGRectMake(width - 1, 10, 1, height-20);
        [selectBtn addSubview:lineView];
        if (i == tempArr.count -1) {
            lineView.hidden = YES;
        }
        

    }

    
    if (btn.isSelected) {
        _backView.hidden = NO;

        [UIView animateWithDuration:0.2 animations:^{
            _BtnBackView.frame = CGRectMake(0, 0, KHScreenW, lasetY );
        } completion:^(BOOL finished) {
        }];
    }else
    {

        
        [self btnViewTackBack];
        
    }
}

/**
 * 收回按钮试图
 */

-(void)btnViewTackBack
{
    [UIView animateWithDuration:0.2 animations:^{
        _BtnBackView.frame = CGRectMake(0, 0, KHScreenW, 0);
        NSArray *btnArr = _BtnBackView.subviews;
        for (int i = 0; i < btnArr.count; i++) {
            UIView *btn =btnArr[i];
            [btn removeFromSuperview];
        }
    } completion:^(BOOL finished) {
        [self btnIsNoSelect:nil];
        _backView.hidden = YES;

    }];
}

-(void)btnIsNoSelect:(UIButton *)btn
{
    _Btn1.selected =  _Btn1 == btn ? btn.selected: NO;
    _Btn2.selected =  _Btn2 == btn ? btn.selected: NO;
    _Btn3.selected =  _Btn3 == btn ? btn.selected: NO;

}

-(void)selectBtnAction:(UIButton *)btn
{
    NSArray *btnArr = _BtnBackView.subviews;
    for (int i = 0; i < btnArr.count; i++) {
        UIButton *tempBtn =btnArr[i];
        tempBtn.selected = NO;
    }
    for (int i = 0; i < _selectArr.count; i++) {
        SearchSelectModel *Model =_selectArr[i];
        Model.isSelect = NO;
    }
    
    btn.selected = YES;
    SearchSelectModel *Model =_selectArr[btn.tag-1000];
    Model.isSelect = YES;
    
    if (_selectArr == _arr1) {
        Model.pragram = @"sceneId";
        if ([Model.title isEqualToString:@"不限"]) {
            [_Btn1 setTitle:@"场景" forState:UIControlStateNormal];

        }else
        {
            [_Btn1 setTitle:Model.title forState:UIControlStateNormal];

        }
    }
    if (_selectArr == _arr2) {
        Model.pragram = @"colorId";

        if ([Model.title isEqualToString:@"不限"]) {
            [_Btn2 setTitle:@"色系" forState:UIControlStateNormal];
            
        }else
        {
            [_Btn2 setTitle:Model.title forState:UIControlStateNormal];
            
        }
    }
    if (_selectArr == _arr3) {
        Model.pragram = @"typeId";

        if ([Model.title isEqualToString:@"不限"]) {
            [_Btn3 setTitle:@"类别" forState:UIControlStateNormal];
            
        }else
        {
            [_Btn3 setTitle:Model.title forState:UIControlStateNormal];
            
        }
    }
    _Callback(Model);
    [self btnViewTackBack];

    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //搜索
    [self.seearchTitleViewDelegate searchContent:searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.seearchTitleViewDelegate beginEdit];
}


@end
