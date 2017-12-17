//
//  ZHPigOrderAddressTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigOrderAddressTableCell.h"
#import "AddressModel.h"
#import "ZHScreenAdaptation.h"

@interface ZHPigOrderAddressTableCell ()

@property (nonatomic, weak) IBOutlet UIView *viewAddAddress;
@property (nonatomic, weak) IBOutlet UIView *viewAddressInfo;

@property (nonatomic, weak) IBOutlet UILabel *labelName;
@property (nonatomic, weak) IBOutlet UILabel *labelPhone;
@property (nonatomic, weak) IBOutlet UILabel *labelAddressInfo;
@property (nonatomic, weak) IBOutlet UILabel *labelAddAddress;

@property (nonatomic, strong) AddressModel *addressModel;

@end

@implementation ZHPigOrderAddressTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithAddressModel:(AddressModel *)addressModel {
    if (addressModel) {
        self.addressModel = addressModel;
        self.viewAddAddress.hidden = YES;
        self.viewAddressInfo.hidden = NO;
        [self configureAddressInfoWithAddressModel:self.addressModel];
    } else {
        self.viewAddAddress.hidden = NO;
        self.viewAddressInfo.hidden = YES;
    }
}

- (void)configureAddressInfoWithAddressModel:(AddressModel *)addressModel {
    self.labelName.text = [NSString stringWithFormat:@"收件人：%@", addressModel.title];
    self.labelPhone.text = addressModel.phone;
    self.labelAddressInfo.text = [NSString stringWithFormat:@"收货地址：%@%@", addressModel.address, addressModel.detailAddress];
}

+ (CGFloat)heightWithAddressModel:(AddressModel *)addressModel {
    if (addressModel) {
        CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 20, CGFLOAT_MAX);
        NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]]};

        CGFloat oneLineLabelHeight = [@"" boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
        CGFloat actualLabelHeight = [[NSString stringWithFormat:@"收货地址：%@%@", addressModel.address, addressModel.detailAddress] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
        if (actualLabelHeight - oneLineLabelHeight > 1) {
            return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:78 + oneLineLabelHeight];
        } else {
            return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:78];
        }
    } else {
        return [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:43];
    }
}

@end
