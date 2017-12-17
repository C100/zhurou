//
//  ZHPigOrderUserInfoTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigOrderUserInfoTableCell.h"
#import "ZHScreenAdaptation.h"
#import "ZHPigOrderModel.h"

@interface ZHPigOrderUserInfoTableCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelName;
@property (nonatomic, weak) IBOutlet UILabel *labelIDCard;

@end

@implementation ZHPigOrderUserInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labelIDCard.font = self.labelName.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]];
}

- (void)configureWithPigOrderModel:(ZHPigOrderModel *)pigOrderModel {

    if (pigOrderModel.idCard > 0) {
        NSMutableString *string = [[NSMutableString alloc] initWithString:pigOrderModel.idCard];
        [string replaceCharactersInRange:NSMakeRange(pigOrderModel.idCard.length - 8, 4) withString:@"****"];

        self.labelIDCard.text = string;
    }

    self.labelName.text = pigOrderModel.realName;
}

@end
