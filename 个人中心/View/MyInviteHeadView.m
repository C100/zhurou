//
//  MyInviteHeadView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/11/28.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyInviteHeadView.h"
#import "UIImageView+WebCache.h"

@implementation MyInviteHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *topView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Rectangle 3 Copy"]];
//        topView.backgroundColor = The_MainColor;
        [self addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(234+64);
        }];
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(234);
            make.top.mas_equalTo(topView.mas_bottom);
        }];
        
        UIImageView *myCodeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的邀请二维码背景"]];
        [self addSubview:myCodeImageView];
        [myCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(25+64);
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(-25);
        }];
        
        self.iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的资金头像"]];
        [myCodeImageView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.mas_equalTo(30);
        }];
        
        
        self.nameLabel = [Tool labelWithTitle:@"穿普拉达的女王的邀请码" color:k282828Color fontSize:15 alignment:0];
        [myCodeImageView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(13);
            make.top.mas_equalTo(23);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(21);
        }];
        
        self.instructionLabel = [Tool labelWithTitle:@"告诉小伙伴们我在用巴布里" color:kB2B2B2Color fontSize:15 alignment:0];
        [myCodeImageView addSubview:self.instructionLabel];
        [self.instructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(1);
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(13);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(21);
        }];
        
        self.codeImageView = [[UIImageView alloc]initWithImage:[Tool qrImageForString:@"" imageSize:251 logoImageSize:0]];
        [myCodeImageView addSubview:self.codeImageView];
        [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_equalTo(45);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(251);
        }];
        
        self.codeLabel = [Tool labelWithTitle:@"邀请码：" color:[UIColor blackColor] fontSize:18 alignment:1];
        [myCodeImageView addSubview:self.codeLabel];
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.codeImageView.mas_bottom).mas_equalTo(4);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.bottom.mas_equalTo(-25);
        }];
    }
    return self;
}

-(void)setCode:(NSString *)code{
    _code = code;
    self.codeLabel.text = [NSString stringWithFormat:@"邀请码：%@",code];
    self.codeImageView.image = [Tool qrImageForString:code imageSize:251 logoImageSize:0];
}

-(void)setPersonModel:(PersonalInfoModel *)personModel{
    _personModel = personModel;
    self.nameLabel.text = personModel.name;
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgBase_Url,personModel.imgUrl]] placeholderImage:[UIImage imageNamed:@"我的资金头像"]];
    [Tool setImgurl:self.iconImageView imgurl:personModel.imgUrl];
}


@end
