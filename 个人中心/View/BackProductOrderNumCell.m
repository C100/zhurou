//
//  BackProductOrderNumCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/7.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProductOrderNumCell.h"

@implementation BackProductOrderNumCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleLabel = [Tool labelWithTitle:@"运单号：" color:k888888Color fontSize:14 alignment:0];
        [self addSubview:titleLabel];
        [titleLabel sizeToFit];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(13);
            make.bottom.mas_equalTo(-13);
            make.size.mas_equalTo(CGSizeMake(titleLabel.bounds.size.width, 14));
        }];
        
        self.orderNumTextField = [[UITextField alloc]init];
        [self addSubview:self.orderNumTextField];
        [self.orderNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right).mas_equalTo(4);
            make.top.mas_equalTo(13);
            make.right.mas_equalTo(0);
        }];
        
    
        self.orderNumTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入订单号" attributes:@{NSFontAttributeName:kFont(14),NSForegroundColorAttributeName:kccccccColor}];
        
    }
    return self;
}

@end
