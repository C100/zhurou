//
//  LocationPickerView.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationPickerViewDelegate <NSObject>

-(void)chooseLocationWithProvince:(NSString *)pro andCity:(NSString *)city;

@end

@interface LocationPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

+ (instancetype)shareInstance;
//@property (nonatomic,strong) UIButton *cancleButton;
//@property (nonatomic,strong) UIButton *sureButton;
//@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic,weak) id<LocationPickerViewDelegate> locationPickerViewDelegate;

//@property (nonatomic,strong) NSString *selectedPro;
//@property (nonatomic,strong) NSString *selectedCity;

@property(nonatomic,strong)NSDictionary *pickerDic;
@property(nonatomic,strong)NSArray *provinceArray;
@property(nonatomic,strong)NSArray *selectedArray;
@property(nonatomic,strong)NSArray *cityArray;
@property(nonatomic,strong)UIView *bottomView;//包括导航视图和地址选择视图
@property(nonatomic,strong)UIPickerView *pickView;//地址选择视图
@property(nonatomic,strong)UIView *navigationView;//上面的导航视图

@end
