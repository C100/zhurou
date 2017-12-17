//
//  PersonalCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/24.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "PersonalCell.h"

@interface PersonalCell()<UITextFieldDelegate>
{
    PersonalInfoModel *_model;
    UIViewController *_vc;
}
@end


@implementation PersonalCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(PersonalInfoModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc
{
    
    
    _vc=vc;
    _model=model;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CommonCellView*commonView= [[CommonCellView alloc] init];
    [self addSubview:commonView];
    [commonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
    if (self) {
        
        
        switch (indexPath.row ) {
            case 0:
            {
                [commonView buttonLeftConfig:@"昵称" vauleTitle:model.name];
                commonView.vauleLab.textColor = The_TitleColor;
                _nameBtn = commonView.btn1;
            }
                break;
            case 1:

            {
                
                if (model.phone.length > 0) {
                    [commonView labelLeftConfig:@"手机号" vauleTitle:model.phone];
                    commonView.vauleLab.textAlignment = NSTextAlignmentRight;
                    commonView.vauleLab.textColor = The_TitleColor;

                }else
                {
                    [commonView buttonLeftConfig:@"手机号" vauleTitle:model.address];
                    commonView.vauleLab.textColor = The_placeholder_Color_grary;
                    commonView.vauleLab.text = @"未绑定";
                    _phoneBtn = commonView.btn1;
                }
            }
                break;
            case 2:
                
            {
                [commonView buttonLeftConfig:@"地址管理" vauleTitle:model.address];
                commonView.vauleLab.textColor = The_TitleColor;

                _addressBtn = commonView.btn1;
            }
                break;
   
            default:
                break;
        }
        

    }
    return self;

}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
//    if (_nameTextFild) {
//        _model.name = _nameTextFild.text;
//
//    }
    
}



@end
