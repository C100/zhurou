//
//  ZHPigMyOrderIdTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigMyOrderIdTableCell.h"
#import "ZHScreenAdaptation.h"

@interface ZHPigMyOrderIdTableCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelOrderId;

@end

@implementation ZHPigMyOrderIdTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labelOrderId.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]];
}

- (void)configureWithOrderId:(NSString *)orderId {
    self.labelOrderId.text = orderId ? orderId : @"";
}

@end
