//
//  GoodsCommentCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/22.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsCommentModel.h"
#import "GoodsModel.h"
@interface GoodsCommentCell : UITableViewCell

@property(nonatomic,strong) UIView *ImageBackView;
@property(nonatomic,strong) NSMutableArray *imagsArray;

@property(nonatomic,copy) void (^callback)();

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(GoodsModel *)model IndexPath:(NSIndexPath *)indexPath VC:(UIViewController *)vc;

@end
