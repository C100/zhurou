//
//  newAddressCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "newAddressCell.h"

//@implementation newAddressCell


@interface newAddressCell()<UITextFieldDelegate>
{
    AddressModel *_model;
    UIViewController *_vc;
}
@end


@implementation newAddressCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(AddressModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc
{
    
    
    _vc=vc;
    _model=model;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CommonCellView*commonView= [[CommonCellView alloc] init];
    [self addSubview:commonView];
//    commonView.backgroundColor = [UIColor redColor];
    [commonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
    if (self) {
        
        if (indexPath.section == 0) {
            switch (indexPath.row ) {
                case 0:
                {
                    [commonView textFildRightConfig:@"收件人" vauleTitle:model.title];
                    commonView.textfild1.delegate = self;
                    _nameTextFild =commonView.textfild1;
                }
                    break;
                case 1:
                    
                {
                    [commonView textFildRightConfig:@"手机号" vauleTitle:model.phone];
                    commonView.textfild1.delegate = self;
                    commonView.textfild1.keyboardType = UIKeyboardTypePhonePad;
                    _phoneTextFild =commonView.textfild1;
                
                }
                    break;
                case 2:
                    
                {
                    [commonView buttonLeftConfig:@"省、市、区县" vauleTitle:model.address];
                    _addressBtn = commonView.btn1;
                    [commonView.titleLab  mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.width.mas_equalTo(100);
                    }];
                    commonView.vauleLab.textAlignment = 2;
                }
                    break;
                case 3:
                    
                {
                    [commonView textFildRightConfig:@"详细地址" vauleTitle:model.detailAddress];
                    commonView.textfild1.delegate = self;
                    _detailAdrressFild =commonView.textfild1;
                }
                    break;
                    
                default:
                    break;
            }
            

        }else
        {
            
            UILabel *titleLab = [Tool labelWithTitle:@"设为默认地址" color:The_wordsColor fontSize:15 alignment:0];
//            titleLab.backgroundColor = [UIColor redColor];
            [commonView addSubview:titleLab];
            
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(14);
                make.size.mas_equalTo(CGSizeMake(100, 18));
                make.centerY.mas_equalTo(commonView.centerY);
            }];
            
            
            _defaultBtn = [Tool buttonWithTitle:@"" titleColor:nil font:0 imageName:nil target:self action:nil];
            [commonView addSubview:_defaultBtn];
            [_defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.top.bottom.offset(0);
            }];
            
            UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wancheng@2x.png"]];
            
            if (model.isSelect) {
                imgView.image = [UIImage imageNamed:@"yigouxuan@2x.png"];
            }else
            {
                imgView.image = [UIImage imageNamed:@"wancheng@2x.png"];
            }

            [commonView addSubview:imgView];
            
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(14, 14));
                make.right.mas_offset(-24);
                make.centerY.mas_equalTo(commonView.centerY);
            }];
            
 
            
        }
        
        
    }
    return self;
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_nameTextFild) {
        _model.title = textField.text;
    }
    if (_phoneTextFild) {
        _model.phone = textField.text;
    }
    if (_detailAdrressFild) {
        _model.detailAddress = textField.text;
    }
    
}


@end
