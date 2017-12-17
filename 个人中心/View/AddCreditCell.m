//
//  AddCreditCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/19.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AddCreditCell.h"

@implementation AddCreditCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.infoLabel = [UILabel labelWithTitle:@"" color:k888888Color font:kLightFont(14) alignment:NSTextAlignmentLeft];
        [self addSubview:self.infoLabel];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(70);
            make.centerY.mas_equalTo(0);
        }];
        
        self.infoTextField = [[AddCreditTextField alloc]init];
        self.infoTextField.font = kLightFont(14);
        [self addSubview:self.infoTextField];
        [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.infoLabel.mas_right).mas_equalTo(15);
        }];
        self.infoTextField.textAlignment = NSTextAlignmentRight;
        
        self.selectButton = [UIButton buttonWithTitle:@"" titleColor:nil font:nil imageName:@"weigouxuan" target:nil action:nil];
        [self.selectButton setImage:[UIImage imageNamed:@"yigouxuan"] forState:UIControlStateSelected];
        [self addSubview:self.selectButton];
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(14, 14));
            make.centerY.mas_equalTo(0);
        }];
        self.selectButton.hidden = YES;
        
        
    }
    return self;
}




-(void)setInfos:(NSArray *)infos{
    _infos = infos;
    self.infoLabel.text = infos.firstObject;
    self.infoTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:infos.lastObject attributes:@{NSFontAttributeName:kLightFont(14),NSForegroundColorAttributeName:kccccccColor}];

}

@end
