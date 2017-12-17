//
//  ZHPigMyOrderInvoiceTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigMyOrderInvoiceTableCell.h"
#import "ZHScreenAdaptation.h"

@interface ZHPigMyOrderInvoiceTableCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelLeft;
@property (nonatomic, weak) IBOutlet UILabel *labelRight;

@end

@implementation ZHPigMyOrderInvoiceTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labelLeft.font = self.labelRight.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]];
}

- (void)configureWithInvoiceDict:(NSDictionary *)invoiceDict {
    if (!invoiceDict) {
        return;
    }
    NSNumber *invoiceType = invoiceDict[@"type"];
    NSString *title;
    if ([invoiceType integerValue] == 0) {
        title = @"个人";
        self.labelRight.text = [NSString stringWithFormat:@"%@ %@", title, invoiceDict[@"orderCheck"]];
    } else {
        title = @"公司";
        self.labelRight.text = [NSString stringWithFormat:@"%@ %@ %@", title, invoiceDict[@"orderCheck"], invoiceDict[@"code"]];
    }
}

@end
