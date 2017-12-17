//
//  CommentCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/11.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "CommentCell.h"
#import "PhotoBrowerViewController.h"



@interface CommentCell()
{
    CommentModel *_model;
    UILabel *title1Lab;
}




@end


@implementation CommentCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
//    _vc = vc;
//    _model = model;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
//        NSString *pingrunStr = [NSString alloc]initWithFormat:@"评论(%@)",
        
        title1Lab = [Tool labelWithTitle:@"评论" color:The_TitleColor fontSize:16 alignment:1];
        title1Lab.hidden = YES;
        [self.contentView addSubview:title1Lab];
        

        
        
        _nameImageView = [[UIImageView alloc]init];
        _nameImageView.layer.cornerRadius = ScalePx(20);
        _nameImageView.clipsToBounds = YES;
        [self.contentView addSubview:_nameImageView];
       
        
        
        _titleLab = [Tool labelWithTitle:@"" color:The_TitleColor fontSize:15 alignment:0];
        _timeLab = [Tool labelWithTitle:@"" color:The_placeholder_Color_grary fontSize:13 alignment:2];
        _detailTitleLab = [Tool labelWithTitle:@"" color:The_wordsColor fontSize:13 alignment:0];
        [self.contentView addSubview:_titleLab];
        
        
        [self.contentView addSubview:_timeLab];
        
       
        
        [self.contentView addSubview:_detailTitleLab];
        
        

        [_detailTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameImageView.mas_right).offset(10);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(_timeLab.mas_bottom).offset(5);
        }];
        
        
        //评论图片
        
        UIImageView *lasetView = nil;
//        if (model.imgArr.count > 0) {
        
        int width = (KHScreenW-7*10-ScalePx(40))/5;
        
            for (int i = 0; i < 5; i++) {
                
                UIImageView *goodsImgView = [[UIImageView alloc]init];
                goodsImgView.contentMode = UIViewContentModeScaleAspectFill;
                goodsImgView.layer.masksToBounds = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgBigAction:)];
                goodsImgView.userInteractionEnabled = YES;
                goodsImgView.tag = 10 + i;
                [goodsImgView addGestureRecognizer:tap];

                
//                [goodsImgView  addTarget:self action:im];
                
               
//                [Tool setImgurl:goodsImgView imgurl:goodsImgUrl];
//                goodsImgView.contentMode = UIViewContentModeScaleAspectFit;
//                goodsImgView.clipsToBounds = YES;
//                [goodsImgView setClipsToBounds:YES];
                
                
                [self.contentView addSubview:goodsImgView];
                [goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (lasetView) {
                        make.left.mas_equalTo(lasetView.mas_right).offset(10);
//                        make.bottom.mas_equalTo(-10);
                    }else
                    {
                        make.left.mas_equalTo(_nameImageView.mas_right).offset(10);
                    }
                    make.top.mas_equalTo(_detailTitleLab.mas_bottom).offset(5);
                    make.size.mas_equalTo(CGSizeMake(width, width));
                }];
                
                switch (i ) {
                    case 0:
                        _commentImg1 = goodsImgView;
                        break;
                    case 1:
                        _commentImg2 = goodsImgView;
                        break;
                    case 2:
                        _commentImg3 = goodsImgView;
                        break;
                    case 3:
                        _commentImg4 = goodsImgView;
                        break;
                    case 4:
                        _commentImg5 = goodsImgView;
                        break;
                    default:
                        break;
                }
                
                lasetView = goodsImgView;
                

            }
            
//        }
        
        
        //评论回复
        
//        if (model.replyTitle.length > 0) {
        
            _replyBackView = [[UIView alloc]init];
            _replyBackView.backgroundColor = BXColor(250, 250, 250);
            [self.contentView addSubview:_replyBackView];
            
            
            
            UILabel *replyTitleLab = [Tool labelWithTitle:@"巴布里猪肉：" color:The_TitleColor fontSize:15 alignment:0];
            [_replyBackView addSubview:replyTitleLab];
            
            [replyTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_offset(10);
                make.size.mas_equalTo(CGSizeMake(80, 18));
            }];
            
            _replyLab = [Tool labelWithTitle:@""color:The_wordsColor fontSize:13 alignment:0];
            [_replyBackView addSubview:_replyLab];
            [_replyLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(10);
                make.top.mas_equalTo(replyTitleLab.mas_bottom).offset(10);
                make.right.mas_offset(-10);
            }];
            

        [_replyBackView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(_nameImageView.mas_right).offset(10);
               make.right.mas_offset(-10);
           }];
 
//        }
    }
    
    
    return self;
}



- (void)setModel:(CommentModel *)model
{
    _model = model;
    
//    self.backgroundColor = [UIColor redColor];
    
    BOOL havepinglun = NO;
    if (model.havePingLunTitle  && model.index == 0) {
                [title1Lab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.offset(10);
                    make.right.offset(-10);
                    make.height.mas_equalTo(20);
                }];
                title1Lab.hidden = NO;
                havepinglun = YES;
            }
    
    [_nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        if (havepinglun) {
            make.top.mas_equalTo(title1Lab.mas_bottom).offset(20);
        }else
        {
            make.top.mas_equalTo(10);
        }
        make.size.mas_equalTo(CGSizeMake(ScalePx(40), ScalePx(40)));
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameImageView.mas_right).offset(10);
        if (havepinglun) {
            make.top.mas_equalTo(title1Lab.mas_bottom).offset(20);
        }else
        {
            make.top.mas_equalTo(10);
        }
        
        make.height.mas_equalTo(18);
        make.right.mas_offset(90);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 18));
        if (havepinglun) {
            make.top.mas_equalTo(title1Lab.mas_bottom).offset(20);
            
        }else
        {
            make.top.mas_equalTo(10);
            
        }
    }];

    
    [Tool setTouxiangImgurl:_nameImageView imgurl:model.nameImgUrl];
   
    _titleLab.text = model.name;
    _timeLab.text = model.time;
    _detailTitleLab.text = model.detailTitle;
    
    [_detailTitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.detailTitleHeight + 5);

    }];
    
    
    _replyLab.text = model.replyTitle ;
    
    //获取回复的高度
    CGSize maxSize = [_replyLab.text sizeWithFont:[UIFont fontWithName:The_titleFont size:12] maxSize:CGSizeMake(KHScreenW-ScalePx(40)-50, CGFLOAT_MAX)];
    
    [_replyLab mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(model.replyTitleHeight + 10);
        make.height.mas_equalTo(maxSize.height+10+10);
    }];
    
   [_replyBackView mas_updateConstraints:^(MASConstraintMaker *make) {
       if (_model.imgArr>0) {
           make.top.mas_equalTo(_commentImg1.mas_bottom).offset(10);
       }else
       {
           make.top.mas_equalTo(_detailTitleLab.mas_bottom).offset(10);
       }
       make.height.mas_equalTo(maxSize.height+10 + 60);
       make.bottom.mas_equalTo(-10);
   }];
    
    if (model.replyTitle.length > 0) {
        _replyBackView.hidden = NO;
    }else
    {
        _replyBackView.hidden = YES;
        [_replyBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (_model.imgArr>0) {
                make.top.mas_equalTo(_commentImg1.mas_bottom).offset(0);
            }else
            {
                make.top.mas_equalTo(_detailTitleLab.mas_bottom).offset(0);
            }
            make.height.mas_equalTo(0);
        }];

    }

    
    
    
    
    for (int i = 0; i < 5;  i++) {
        
        UIImageView *lastImageView;
        UIImageView *tempIMgView = nil;
        
        switch (i ) {
            case 0:
                tempIMgView = _commentImg1;
                break;
            case 1:
                tempIMgView = _commentImg2;
                break;
            case 2:
                tempIMgView = _commentImg3;
                break;
            case 3:
                tempIMgView = _commentImg4;
                break;
            case 4:
                tempIMgView = _commentImg5;
                break;
            default:
                break;
        }

        int width = (KHScreenW-7*10-ScalePx(40))/5;
        if (i < model.imgArr.count) {
            lastImageView = tempIMgView;
            NSString  *goodsImgUrl = model.imgArr[i];

//            [Tool setSquareImgurl:tempIMgView imgurl:goodsImgUrl];
            
            [Tool setImgurl:tempIMgView imgurl:goodsImgUrl];
            tempIMgView.hidden = NO;
            tempIMgView.layer.masksToBounds = YES;
            
            if (i == model.imgArr.count-1) {
//                tempIMgView.hidden = YES;
                [tempIMgView mas_updateConstraints:^(MASConstraintMaker *make) {
                    if (lastImageView) {
                        make.left.mas_equalTo(lastImageView.mas_right).offset(10);
                        if (model.replyTitle.length > 0) {
                            //有回复
                        }else{
                            make.bottom.mas_equalTo(-10);
                        }
                    }else
                    {
                        make.left.mas_equalTo(_nameImageView.mas_right).offset(10);
                    }
                    make.top.mas_equalTo(_detailTitleLab.mas_bottom).offset(5);
                    make.size.mas_equalTo(CGSizeMake(width, width));
                }];
            }

        }
        
        
    }
}





-(void)imgBigAction:(UITapGestureRecognizer *)tap
{
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSInteger index =  tap.view.tag - 10;
    if (index>=_model.imgArr.count) {
        return;
    }
    
    [nav.view endEditing:YES];
    PhotoBrowerViewController *vc = [[PhotoBrowerViewController alloc]init];
    vc.index = index;
    vc.imagesArray = _model.imgArr;
    vc.canDelete = NO;
    
//    NSMutableArray *tempArr = [[NSMutableArray alloc]initWithArray:_model.commentImgArr];
    [vc setDeleteBlock:^(NSInteger index) {
//        [tempArr  removeObjectAtIndex:index];
//        _model.commentImgArr = tempArr;
//        _callback();
        
    }];
    
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];
}







@end
