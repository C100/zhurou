//
//  LocationPickerView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "LocationPickerView.h"
#import "AddressManage.h"

#define navigationViewHeight 44.0f
#define pickViewViewHeight 200.0f
#define buttonWidth 60.0f
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define __kDatepickTitleColor ([UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f])

@implementation LocationPickerView



+ (instancetype)shareInstance
{
    static LocationPickerView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[LocationPickerView alloc] init];
    });
    
    [shareInstance showBottomView];
    return shareInstance;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self _addTapGestureRecognizerToSelf];
        [self _getPickerData];
        [self _createView];
    }
    return self;
    
}
#pragma mark - get data
- (void)_getPickerData
{
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    //    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    
    self.pickerDic = [[AddressManage manage] getAllAreaDic];
    
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
}
-(void)_addTapGestureRecognizerToSelf
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
}
-(void)_createView
{
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, navigationViewHeight+pickViewViewHeight)];
    [self addSubview:_bottomView];
    //导航视图
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, navigationViewHeight)];
    _navigationView.backgroundColor = __kDatepickTitleColor;
    [_bottomView addSubview:_navigationView];
    //这里添加空手势不然点击navigationView也会隐藏,
    UITapGestureRecognizer *tapNavigationView = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
    [_navigationView addGestureRecognizer:tapNavigationView];
    
    
    UILabel* _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0,0, kScreenWidth , 46)];
    _titlelab.backgroundColor = __kDatepickTitleColor;
    _titlelab.text = @"选择地址";
    _titlelab.font = [UIFont fontWithName:The_titleFont size:16];
    
    //    _titlelab.font = [UIFont systemFontOfSize:16];
    _titlelab.textAlignment = NSTextAlignmentCenter;
    [_navigationView addSubview:_titlelab];
    
    NSArray *buttonTitleArray = @[@"取消",@"确定"];
    for (int i = 0; i <buttonTitleArray.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.titleLabel.font = [UIFont fontWithName:The_titleFont size:16];
        
        button.frame = CGRectMake(i*(kScreenWidth-buttonWidth), 0, buttonWidth, navigationViewHeight);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [_navigationView addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, navigationViewHeight, kScreenWidth, pickViewViewHeight)];
    _pickView.backgroundColor = [UIColor whiteColor];
    _pickView.dataSource = self;
    _pickView.delegate =self;
    
    [_bottomView addSubview:_pickView];
    
    
}
-(void)tapButton:(UIButton*)button
{
    //点击确定回调block
    if (button.tag == 1) {
        
        NSString *province = [self.provinceArray objectAtIndex:[_pickView selectedRowInComponent:0]];
        
        NSString *city = @"";
        if (self.cityArray.count == 0) {
            city =province;
        }else
        {
            city = [self.cityArray objectAtIndex:[_pickView selectedRowInComponent:1]];
            
        }
        
        [self.locationPickerViewDelegate chooseLocationWithProvince:province andCity:city];
    }
    
    [self hiddenBottomView];
    
    
}
-(void)showBottomView
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = kScreenHeight-navigationViewHeight-pickViewViewHeight;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = kScreenHeight;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}


#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _provinceArray.count;
    } else {
        return _cityArray.count;
    }
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[Tool labelWithTitle:@"" color:The_TitleColor fontSize:16 alignment:1];
    
    //    lable.textAlignment=NSTextAlignmentCenter;
    //    lable.font=[UIFont systemFontOfSize:16.0f];
    if (component == 0) {
        lable.text=[self.provinceArray objectAtIndex:row];
    } else {
        lable.text=[self.cityArray objectAtIndex:row];
    }
    return lable;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat pickViewWidth = kScreenWidth/3;
    
    return pickViewWidth;
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    
    
    
}


//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
//        self.pickerView.delegate = self;
//        self.pickerView.dataSource = self;
//        [self setChooseView];
//        
//        //解决第一次弹出没有数据的情况
//        self.selectedCity = @"无锡市";
//        self.selectedPro = @"江苏省";
//    }
//    return self;
//}
//-(void)setChooseView{
//    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, 30)];
//    [self addSubview:bgView];
//    bgView.backgroundColor = [UIColor whiteColor];
//    
//    self.cancleButton = [UIButton buttonWithTitle:@"取消" titleColor:k888888Color font:kLightFont(14) target:nil action:nil];
//    self.cancleButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [bgView addSubview:self.cancleButton];
//    self.cancleButton.frame = CGRectMake(5, 5, 40, 20);
//    
//    self.sureButton = [UIButton buttonWithTitle:@"确定" titleColor:k888888Color font:kLightFont(14) target:nil action:nil];
//    self.sureButton.titleLabel.textAlignment = NSTextAlignmentRight;
//    [bgView addSubview:self.sureButton];
//    self.sureButton.frame = CGRectMake(KHScreenW-45, 5, 40, 20);
//}
//
//-(UIPickerView *)pickerView{
//    if (_pickerView == nil) {
//        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, KHScreenW, 170)];
//        _pickerView.backgroundColor = [UIColor clearColor];
//        _pickerView.delegate = self;
//        _pickerView.dataSource = self;
//        [self addSubview:_pickerView];
//    }
//    return _pickerView;
//}
//
//#pragma UIPickView delegate
//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    return 2;
//}
////返回的是每一列的个数
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return 1;
//}
//
////返回的是component列的行显示的内容
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    if (component==0) {
//        return @"江苏省";
//    }
//    return @"无锡市";
//}
//
////如果选中某行，该执行的方法
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    [self.locationPickerViewDelegate chooseLocationWithProvince:self.selectedPro andCity:self.selectedCity];
//}
//
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSString *str = @"";
//    if (component == 0) {
//        str = @"江苏省";
//    }else{
//        str = @"无锡市";
//    }
//    NSAttributedString *dayString = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:[LUtils colorHex:@"#98BBE3"],NSFontAttributeName:kLightFont(14)}];
//    return dayString;
//}
//
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    
//    UILabel *label = [UILabel labelWithTitle:nil color:[LUtils colorHex:@"#98BBE3"] font:kLightFont(14) alignment:NSTextAlignmentCenter];
//    if (component==0) {
//        label.text = @"江苏省";
//    }else{
//        label.text = @"无锡市";
//    }
//    
//    label.frame = CGRectMake(0, 0, KHScreenW, 30);
//    
//    return label;
//}


@end
