//
//  SettingCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/29.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell()<UITextFieldDelegate>
{
    SettingModel *_model;
    UIViewController *_vc;
}
@end

@implementation SettingCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(SettingModel *)model IndexPath:(NSIndexPath *)indexPath
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
            
                float folderSize = 0;
                
                //SDWebImage框架自身计算缓存的实现
                folderSize=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
                
                NSString *folderSizeStr = [[NSString alloc]initWithFormat:@"%0.1fM",folderSize ];
                model.huancun = folderSizeStr;

                
                [commonView buttonLeftConfig:@"清除缓存" vauleTitle:model.huancun];
                commonView.vauleLab.textAlignment = 2;
                _huanChun = commonView.btn1;
                

            }
                break;
            case 1:
                
            {
                [commonView buttonLeftConfig:@"修改密码" vauleTitle:nil];
                _changePassWord = commonView.btn1;

            }
                break;
            case 2:
                
            {
                [commonView buttonLeftConfig:@"意见反馈" vauleTitle:nil];
                _yijian = commonView.btn1;
                
            }
                break;

            case 3:
                
            {
                [commonView buttonLeftConfig:@"用户协议" vauleTitle:nil];
                _xieyi = commonView.btn1;

            }
                break;
            case 4:
                
            {
                [commonView buttonLeftConfig:@"壹筑e家APP评分" vauleTitle:nil];
                [commonView.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(150);
                }];
                _pingfeng = commonView.btn1;

            }
                break;
                
            default:
                break;
        }
        
        
    }
    return self;
 
}

@end
