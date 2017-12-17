//
//  AddCreditSuccessView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AddCreditSuccessView.h"

@implementation AddCreditSuccessView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *successImageView = [[UIImageView alloc]init];
        successImageView.image = [UIImage imageNamed:@"icon_success"];
        [self addSubview:successImageView];
        successImageView.contentMode = UIViewContentModeScaleAspectFit;
        [successImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(55);
            make.top.mas_equalTo(34);
        }];
        
        
        UILabel *successLabel = [UILabel labelWithTitle:@"添加成功!" color:kDefinedColor font:kMediumFont(18)];
        [self addSubview:successLabel];
        [successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(successImageView.mas_bottom).mas_equalTo(27);
            make.height.mas_equalTo(18);
            make.bottom.mas_equalTo(-34);
        }];
    }
    return self;
    
}

@end
