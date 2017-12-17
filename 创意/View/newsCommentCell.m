//
//  newsCommentCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "newsCommentCell.h"

@implementation newsCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(NewsCommentModel *)model index:(NSIndexPath *)index uiviewcontroller:(UIViewController *)vc
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSString *pinglunStr = [[NSString alloc]initWithFormat:@"评论(%ld)",(long)model.num ];
        
        UILabel *titleLab = [Tool labelWithTitle:pinglunStr color:The_TitleColor fontSize:16 alignment:1];
        titleLab.hidden = YES;
        [self.contentView addSubview:titleLab];
        
        BOOL havepinglun = NO;
        if (model.havePingLunTitle  && index.row == 0) {
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.offset(10);
                make.right.offset(-10);
                make.height.mas_equalTo(20);
            }];
            titleLab.hidden = NO;
            havepinglun = YES;
        }
        
        
        _nameImageView = [[UIImageView alloc]init];
        _nameImageView.layer.cornerRadius = 20;
        _nameImageView.clipsToBounds = YES;

        [Tool setTouxiangImgurl:_nameImageView imgurl:model.nameImgUrl];
        [self.contentView addSubview:_nameImageView];
        [_nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            if (havepinglun) {
                make.top.mas_equalTo(titleLab.mas_bottom).offset(20);
            }else
            {
                make.top.mas_equalTo(10);
            }
            make.size.mas_equalTo(CGSizeMake(ScalePx(40), ScalePx(40)));
        }];
        
        _titleLab = [Tool labelWithTitle:model.name color:The_TitleColor fontSize:15 alignment:0];
        [self.contentView addSubview:_titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameImageView.mas_right).offset(10);
            if (havepinglun) {
                make.top.mas_equalTo(titleLab.mas_bottom).offset(20);
            }else
            {
                make.top.mas_equalTo(10);
            }
            
            make.height.mas_equalTo(18);
            make.right.mas_offset(90);
        }];
        
        
        //回复按钮
        _replyBtn = [Tool buttonWithTitle:@"回复" titleColor:The_MainColor font:13 imageName:nil target:self action:nil];
        [self.contentView addSubview:_replyBtn];
        _replyBtn.hidden = YES;
        [_replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_titleLab);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.right.mas_offset(-10);
        }];
        
        
        
        _timeLab = [Tool labelWithTitle:model.time color:The_placeholder_Color_grary fontSize:13 alignment:0];
        [self.contentView addSubview:_timeLab];
        
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(80, 18));
            make.top.mas_equalTo(_titleLab.mas_top).offset(0);
        }];
        
        _detailTitleLab = [Tool labelWithTitle:model.detailTitle color:The_wordsColor fontSize:13 alignment:0];
        [self.contentView addSubview:_detailTitleLab];
        
        
        
        [_detailTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameImageView.mas_right).offset(10);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(_timeLab.mas_bottom).offset(5);
            make.height.mas_equalTo(model.detailTitleHeight + 5);
        }];
        
        
        
        
        UIView *lastView = [[UIView alloc]init];
        
        for (int i = 0; i < model.replyModelArr.count; i++) {
            
            CommonModel *common = model.replyModelArr[i];
            UIView *replyBackView = [[UIView alloc]init];
            [self.contentView addSubview:replyBackView];

            if (i==0) {
                [replyBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_detailTitleLab.mas_bottom).offset(10);
                }];
            }else
            {
                [replyBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(lastView.mas_bottom);
                }];
                
            }
             lastView = [self replyView:common backView:replyBackView];
            
            
        }
    }
    
    
    return self;
}


-(UIView *)replyView:(CommonModel *)model  backView:(UIView *)replyBackView
{
    replyBackView.backgroundColor = BXColor(250, 250, 250);
    
        
    
    UILabel *replyTitleLab = [Tool labelWithTitle:[[NSString alloc]initWithFormat:@"%@:",model.title1] color:The_TitleColor fontSize:15 alignment:0];
    [replyBackView addSubview:replyTitleLab];
    
    [replyTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
//        make.size.mas_equalTo(CGSizeMake(80, 18));
        make.height.mas_equalTo(18);
    }];
    
    
    
   UILabel *detailTimeLab = [Tool labelWithTitle:model.title2 color:The_placeholder_Color_grary fontSize:13 alignment:2];
    [replyBackView addSubview:detailTimeLab];
    
    [detailTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.right.offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 18));
        
    }];
    
    UILabel *replyLab = [Tool labelWithTitle:model.title3 color:The_wordsColor fontSize:13 alignment:0];
    
    CGSize replySize = [model.title3 sizeWithFont:[UIFont fontWithName:The_titleFont size:13] maxSize:CGSizeMake(KHScreenW-ScalePx(40)-50, MAXFLOAT)];
    
    [replyBackView addSubview:replyLab];
    [replyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.mas_equalTo(replyTitleLab.mas_bottom).offset(10);
        //                make.size.mas_equalTo(CGSizeMake(80, 18));
        make.right.mas_offset(-10);
        make.height.mas_equalTo(replySize.height + 10);
    }];
    
    
    [replyBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameImageView.mas_right).offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(replySize.height + 60);
    }];
    


    return replyBackView;
}



@end
