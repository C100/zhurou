//
//  NoticeCenterCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/11.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "NoticeCenterCell.h"

@implementation NoticeCenterCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(NoticeCenterModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc
{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   
    
    if (self) {
        self.backgroundColor = The_list_backgroundColor;
        
        _timeLab = [Tool labelWithTitle:model.timeStr color:The_wordsColor fontSize:13 alignment:1];
        [self.contentView addSubview:_timeLab];
        
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(15);
            make.top.mas_offset(10);
        }];
        
        _headImgView = [[UIImageView alloc] init];
        _headImgView.cornerRadius = 25;
        [Tool setTouxiangImgurl:_headImgView imgurl:model.imgUrl];
        [self.contentView addSubview:_headImgView];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.mas_equalTo(_timeLab.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        UIImageView *backImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:backImgView];
        UIImage *image=[UIImage imageNamed:@"duihuakaung1@2x.png"];
        backImgView.image=[image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        
        [backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headImgView.mas_right).offset(10);
            make.top.mas_equalTo(_timeLab.mas_bottom).offset(10);
            make.right.offset(-60);
            make.height.mas_equalTo(model.detailStrHeight + 50);
        }];
        _detailLabTitle = [Tool labelWithTitle:model.detailStr color:The_wordsColor fontSize:13 alignment:0];
        _detailLabTitle.numberOfLines = 0;
        [backImgView addSubview:_detailLabTitle];
        [_detailLabTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.left.mas_offset(20);
            make.height.mas_equalTo(70);
            make.right.mas_offset(-10);
        }];
        
        
        
        CGFloat detailStrHeight = 0;
        detailStrHeight = model.detailStrHeight ;

        if (model.detailStrHeight > 70) {
            NSString *btnTitle = @"收起";
            _openBtn = [Tool buttonWithTitle:btnTitle titleColor:The_MainColor font:13 imageName:nil target:self action:nil];
            [_openBtn setImage:[UIImage imageNamed: @"xiabiue@2x.png"] forState:UIControlStateNormal];
            [_openBtn setImage:[UIImage imageNamed: @"shang@2x.png"] forState:UIControlStateSelected];
            [_openBtn setTitle:@"展开" forState:UIControlStateNormal];
            [_openBtn setTitle:@"收起" forState:UIControlStateSelected];

            if (model.isOpen) {
                detailStrHeight = model.detailStrHeight + 40;
                _openBtn.selected = YES;
                
            }else{
                detailStrHeight = 70;
                btnTitle = @"展开";
                _openBtn.selected = NO;
            }
            
            [backImgView addSubview:_openBtn];
            backImgView.userInteractionEnabled = YES;
           [_openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(10);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(_detailLabTitle.mas_bottom).offset(0);
           }];
            
            [backImgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_openBtn.mas_bottom);
            }];
           
        }else
        {
            [backImgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_detailLabTitle.mas_bottom);
            }];


           
        }
        
        [backImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(detailStrHeight + 20);
        }];
        
        

        
 
        _deletBtn = [Tool buttonWithTitle:nil titleColor:nil font:0 imageName:@"shanchu@2x.png" target:nil action:nil];
        _deletBtn.backgroundColor = [UIColor whiteColor];
        _deletBtn.cornerRadius = 20;
        [self.contentView addSubview:_deletBtn];
        [_deletBtn setImage:[UIImage imageNamed:@"shanchu@2x.png"] forState:UIControlStateNormal
         ];
        
        [_deletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.right.offset(-10);
        }];
        
        
        
        
        
    }
    return self;
}
@end
