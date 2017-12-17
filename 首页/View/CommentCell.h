//
//  CommentCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/11.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"


@interface CommentCell : UITableViewCell

@property(nonatomic,strong) UIImageView *nameImageView;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UILabel *detailTitleLab;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UILabel *replyLab;
@property(nonatomic,strong) UIImageView *commentImg1;
@property(nonatomic,strong) UIImageView *commentImg2;
@property(nonatomic,strong) UIImageView *commentImg3;
@property(nonatomic,strong) UIImageView *commentImg4;
@property(nonatomic,strong) UIImageView *commentImg5;
@property(nonatomic,strong) UIView *replyBackView;
@property(nonatomic,strong) CommentModel *model;

@property(nonatomic,strong) UIViewController *vc;


//@property(nonatomic,strong) UILabel *titleLab;



//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(CommentModel *)model index:(NSIndexPath *)index uiviewcontroller:(UIViewController *)vc;




@end
