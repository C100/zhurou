//
//  SeeBigImageView.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/22.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "SeeBigImageView.h"

@implementation SeeBigImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.6];
        //self.alpha = .6;
        
        self.seeBigImageView = [[UIImageView alloc]init];
        [self addSubview:self.seeBigImageView];
        [self.seeBigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        self.seeBigImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

-(void)setSeeBigImage:(UIImage *)seeBigImage{
    _seeBigImage = seeBigImage;
    self.seeBigImageView.image = seeBigImage;
}

@end
