//
//  SpecCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/8.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "SpecCell.h"
#import "SpecModel.h"


@implementation SpecCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = [UIColor colorWithRed:0.1*(arc4random() % 9) green:0.1*(arc4random() % 9) blue:0.1*(arc4random() % 9) alpha:1];
        
        _iconView = [[UIImageView alloc]init];
        _iconView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_iconView];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(ScalePx(44), ScalePx(44)));
            make.top.mas_offset(10);
            make.centerX.mas_equalTo(self.contentView);
        }];
        
        _titleLab = [Tool labelWithTitle:@"" color:The_TitleColor fontSize:13 alignment:1];
        [self.contentView addSubview:_titleLab];

        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.height.mas_equalTo(15);
            make.top.mas_equalTo(_iconView.mas_bottom).offset(9);
        }];
        
        _detailTitleLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:13 alignment:1];
        [self.contentView addSubview:_detailTitleLab];
        
        [_detailTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.bottom.offset(-10);
            make.top.mas_equalTo(_titleLab.mas_bottom).offset(4);
        }];

//        _imageView = [[UIImageView alloc]init];
//        [self.contentView addSubview:_imageView];
    }
    return self;
}

-(void)setModel:(SpecModel *)model
{
    _model = model;
    
    _detailTitleLab.text = model.detailTitle;
    _titleLab.text = model.title;
    [Tool setImgurl:_iconView imgurl:model.imageUrl];
    
    
//    [_imageView setImageWithURL:[NSURL URLWithString:model.imageUrl]];
//    _imageView.frame = CGRectMake(5, 5, 150, model.cellHeight - 10);
}


@end
