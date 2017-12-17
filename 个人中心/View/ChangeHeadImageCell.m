//
//  ChangeHeadImageCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/29.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ChangeHeadImageCell.h"

@implementation ChangeHeadImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的资金头像"]];
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        self.iconImageView.layer.cornerRadius = 25;
        self.iconImageView.layer.masksToBounds = YES;
        
        UILabel *titleLabel = [Tool labelWithTitle:@"修改头像" color:kADADADColor fontSize:15 alignment:2];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-30);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(21);
        }];
    }
    return self;
}

@end
