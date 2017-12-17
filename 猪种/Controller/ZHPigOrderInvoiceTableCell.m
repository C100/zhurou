//
//  ZHPigOrderInvoiceTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigOrderInvoiceTableCell.h"
#import "ZHScreenAdaptation.h"

@interface ZHPigOrderInvoiceTableCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelLeft;
@property (nonatomic, weak) IBOutlet UILabel *labelRight;

@end

@implementation ZHPigOrderInvoiceTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labelLeft.font = self.labelRight.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]];
}

- (void)configureWithInvoiceString:(NSString *)invoiceString {
    if (invoiceString) {
        self.labelRight.text = invoiceString;
    } else {
        self.labelRight.text = @"未填写";
    }
}

@end
