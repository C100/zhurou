//
//  CouponApplyCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "CouponApplyCell.h"

@implementation CouponApplyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setNormalCell];
        [self setOtherStyleCell];
    }
    return self;
}

-(void)setRow:(NSInteger)row{
    _row = row;
    if (row == 2) {
        self.arrowImageView.hidden = NO;
        self.chooseLabel.hidden = NO;
        self.myTextField.hidden = YES;
    }else{
        self.arrowImageView.hidden = YES;
        self.chooseLabel.hidden = YES;
        self.myTextField.hidden = NO;
    }
}

-(void)setNormalCell{
    self.titleLabel = [UILabel labelWithTitle:@"" color:k888888Color font:kLightFont(14)];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(14);
        //make.width.mas_equalTo(56);
    }];
    
    self.myTextField = [[AddCreditTextField alloc]init];
    self.myTextField.font = kLightFont(14);
    [self addSubview:self.myTextField];
    [self.myTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    self.myTextField.textAlignment = NSTextAlignmentRight;
}

-(void)setOtherStyleCell{
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiayibu"]];
    self.arrowImageView = arrowImageView;
    [self addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(8, 14));
        make.centerY.mas_equalTo(0);
    }];
    self.chooseLabel = [UILabel labelWithTitle:@"省市选择" color:k555555Color font:kLightFont(14)];
    [self addSubview:self.chooseLabel];
    [self.chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(arrowImageView.mas_left).mas_equalTo(-5);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(14);
    }];
    arrowImageView.hidden = YES;
    self.chooseLabel.hidden = YES;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.myTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:placeholder attributes:@{NSForegroundColorAttributeName:kccccccColor,NSFontAttributeName:kLightFont(14)}];
}

@end
