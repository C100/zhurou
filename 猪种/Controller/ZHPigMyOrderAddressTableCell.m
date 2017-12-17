//
//  ZHPigMyOrderAddressTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/14.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigMyOrderAddressTableCell.h"
#import "ZHScreenAdaptation.h"
#import "ZHPigMyOrderModel.h"

@interface ZHPigMyOrderAddressTableCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelRealName;
@property (nonatomic, weak) IBOutlet UILabel *labelAddressName;
@property (nonatomic, weak) IBOutlet UILabel *labelPhone;
@property (nonatomic, weak) IBOutlet UILabel *labelIDCard;
@property (nonatomic, weak) IBOutlet UILabel *labelAddress;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelNameTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelIDCardTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelAddressTopConstraint;

@end

@implementation ZHPigMyOrderAddressTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labelRealName.font = self.labelAddressName.font = self.labelPhone.font = self.labelIDCard.font = self.labelAddress.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]];

    self.labelNameTopConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:13];
    self.labelIDCardTopConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:15];
    self.labelAddressTopConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:12];
}

- (void)configureWithMyOrderModel:(ZHPigMyOrderModel *)myOrderModel {
    if (!myOrderModel) {
        return;
    }
    self.labelRealName.text = myOrderModel.realName;
    if (myOrderModel.idCard > 0) {
        NSMutableString *string = [[NSMutableString alloc] initWithString:myOrderModel.idCard];
        [string replaceCharactersInRange:NSMakeRange(myOrderModel.idCard.length - 8, 4) withString:@"****"];

        self.labelIDCard.text = string;
    }
    self.labelPhone.text = myOrderModel.addressModel.phone;
    AddressModel *addressModel = myOrderModel.addressModel;
    self.labelAddressName.text = [NSString stringWithFormat:@"收件人：%@", addressModel.title];
    self.labelAddress.text = [NSString stringWithFormat:@"收货地址：%@", addressModel.detailAddress];
}

+ (CGFloat)heightWithMyOrderModel:(ZHPigMyOrderModel *)myOrderModel {

    CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 20, CGFLOAT_MAX);
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]]};

    AddressModel *addressModel = myOrderModel.addressModel;
    CGFloat oneLineLabelHeight = [@"" boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    CGFloat actualLabelHeight = [[NSString stringWithFormat:@"收货地址：%@%@", addressModel.address, addressModel.detailAddress] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    if (actualLabelHeight - oneLineLabelHeight > 1) {
        return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:80 + 2 * oneLineLabelHeight];
    } else {
        return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:80 + oneLineLabelHeight];
    }
}

@end
