//
//  newsCommentCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCommentModel.h"

@interface newsCommentCell : UITableViewCell


@property(nonatomic,strong) UIImageView *nameImageView;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UILabel *detailTitleLab;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UILabel *replyLab;
@property(nonatomic,strong) UIButton *replyBtn;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(NewsCommentModel *)model index:(NSIndexPath *)index uiviewcontroller:(UIViewController *)vc;





@end
