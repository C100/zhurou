//
//  NameChangeVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/17.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "NameChangeVC.h"
#import "HSLimitText.h"

@interface NameChangeVC ()<HSLimitTextDelegate>
{
    HSLimitText *_nameTextFild;
    UILabel *_numLab;
}

@end

@implementation NameChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑昵称";
    self.view.backgroundColor = The_list_backgroundColor;
    [self prepareData];
    [self configUI];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    
}

-(void)configUI
{
    
    UIView *nameView = [[UIView alloc]init];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
    
    _nameTextFild=[self textFildWithTitle:@"昵称" color:The_wordsColor fontSize:15 alignment:0];
//    _nameTextFild.borderWidth = 1;
    _nameTextFild.textField.text = _name;
    _nameTextFild.maxLength = 11;
    _nameTextFild.delegate = self;
    _nameTextFild.isBecomFirstResponder = NO;
    
    _numLab = [Tool labelWithTitle:@"0/11" color:The_TitleColor fontSize:15 alignment:1];
    _numLab.size = CGSizeMake(40, 40);
    _nameTextFild.textField.rightView=_numLab;
    _nameTextFild.textField.rightViewMode = UITextFieldViewModeAlways;
    _numLab.text = [NSString stringWithFormat:@"%d/%d",(int)_name.length,11];
    

    [nameView addSubview:_nameTextFild];
    
    [_nameTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.bottom.mas_offset(0);
    }];
    
    
    UIBarButtonItem *save = [Tool BarButtonItemWithName:@"保存" font:15 target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = save;
    

}

#pragma mark buttonAction

-(void)saveAction
{
    if (_nameTextFild.textField.text.length == 0) {
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"昵称不能为空！"];
        return;
    }
    NSDictionary *dic = @{@"username":_nameTextFild.textField.text,};
    
    [HttpRequestManager postUpdateUserNameRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
        
        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"保存成功！"];
        [self.navigationController popViewControllerAnimated:YES];

        
    }];
}


-(HSLimitText *)textFildWithTitle:(NSString *)placeholder color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment
{
    HSLimitText *textFild = [[HSLimitText alloc] init];
    UIView *leftView = [[UIView alloc]init];
    leftView.width = 10;
    textFild.textField.leftViewMode = UITextFieldViewModeAlways;
    textFild.textField.leftView =leftView;
    
    textFild.placeholder = placeholder;
    textFild.textField.textColor = color;
    textFild.textField.font = [UIFont fontWithName:The_titleFont size:fontSize];
    textFild.borderColor = The_line_Color_grary;
    textFild.borderWidth = 0;
    //    label.font = [UIFont systemFontOfSize:fontSize];
    if (alignment) {
        textFild.textField.textAlignment = alignment;
    }
    [textFild sizeToFit];
    
    return textFild;
    
}

- (void)limitTextLimitInput:(HSLimitText *)textLimitInput text:(NSString *)text
{
    _numLab.text = [NSString stringWithFormat:@"%d/%d",(int)text.length,11];
    
}



@end
