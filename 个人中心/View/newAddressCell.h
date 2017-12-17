//
//  newAddressCell.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"


@interface newAddressCell : UITableViewCell

@property(nonatomic,strong) UITextField *nameTextFild;
@property(nonatomic,strong) UITextField *phoneTextFild;
@property(nonatomic,strong) UITextField *detailAdrressFild;
@property(nonatomic,strong) UIButton *addressBtn;

//@property(nonatomic,strong) UILabel *phone;
@property(nonatomic,strong) UIButton *defaultBtn;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(AddressModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc;



@end
