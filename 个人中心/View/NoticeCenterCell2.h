//
//  NoticeCenterCell2.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/15.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeCenterModel.h"

@interface NoticeCenterCell2 : UITableViewCell


@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UIImageView *headImgView;
@property(nonatomic,strong) UILabel *detailLabTitle;

@property(nonatomic,strong) UIButton *deletBtn;
@property(nonatomic,strong) UIButton *openBtn;
@property(nonatomic,strong) UIButton *detailInfoBtn;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(NoticeCenterModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc;


@end
