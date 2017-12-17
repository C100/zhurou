//
//  NoticeCenterCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/11.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeCenterModel.h"



@interface NoticeCenterCell : UITableViewCell



@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UIImageView *headImgView;
@property(nonatomic,strong) UILabel *detailLabTitle;

@property(nonatomic,strong) UIButton *deletBtn;
@property(nonatomic,strong) UIButton *openBtn;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(NoticeCenterModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc;

@end
