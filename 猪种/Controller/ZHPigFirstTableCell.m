//
//  ZHPigFirstTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/10.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigFirstTableCell.h"
#import "ZHScreenAdaptation.h"
#import "ZHPigInfoModel.h"

@interface ZHPigFirstTableCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelPigBreed;
@property (nonatomic, weak) IBOutlet UILabel *labelPigIntro;
@property (nonatomic, weak) IBOutlet UILabel *labelPigPrice;
@property (nonatomic, weak) IBOutlet UILabel *labelPigRemain;

@property (nonatomic, weak) IBOutlet UILabel *labelPigPeriod;
@property (nonatomic, weak) IBOutlet UIButton *buttonBuyPig;

@property (nonatomic, weak) IBOutlet UIImageView *imageViewSellOut;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonBuyPigWidthConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelPigRemainTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelPigBreedTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelPigBreedRightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelPigIntroTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelPigIntroRightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelPigPriceTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonBuyPigBottomConstraint;

@end

@implementation ZHPigFirstTableCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.labelPigBreed.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:18]];
    self.labelPigIntro.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]];
    self.labelPigPrice.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:24]];
    self.labelPigRemain.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:12]];
    self.labelPigPeriod.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:17]];

    self.buttonBuyPig.layer.cornerRadius = 5;
    self.buttonBuyPigWidthConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:105];
    self.labelPigBreedTopConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:18];
    self.labelPigIntroTopConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:10];
    self.labelPigPriceTopConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:7];
    self.labelPigRemainTopConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:10];
    self.buttonBuyPigBottomConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14];
    self.labelPigBreedRightConstraint.constant = self.labelPigIntroRightConstraint.constant =
    [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:120];

    [self configureSubviews];
}

- (void)configureSubviews {
    self.imageViewSellOut.hidden = YES;
    [self configureBuyButtonWithEnabled:NO];
}

- (void)configureLabelPigRemainWithPigRemain:(NSNumber *)pigRemain {
    if (!pigRemain) {
        return;
    }
    NSString *pigNumber = [NSString stringWithFormat:@"%@", pigRemain];
    NSString *labelPigRemainText = [NSString stringWithFormat:@"剩余数量：%@头", pigNumber];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelPigRemainText];
    NSRange range = NSMakeRange(5, pigNumber.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0] range:range];
    self.labelPigRemain.attributedText = attributedString;

}

- (void)configureLabelPigPeriodWithPeriod:(NSNumber *)period {
    if (!period) {
        return;
    }
    NSString *periodNumber = [NSString stringWithFormat:@"%@", period];
    NSString *labelPigPeriodText = [NSString stringWithFormat:@"当前第%@期", periodNumber];
    NSMutableAttributedString *labelPigPeriodAttributedString = [[NSMutableAttributedString alloc] initWithString:labelPigPeriodText];
    [labelPigPeriodAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:182/255.0f green:37/255.0f blue:30/255.0f alpha:1.0] range:NSMakeRange(3, periodNumber.length)];
    self.labelPigPeriod.attributedText = labelPigPeriodAttributedString;
}

- (void)configureBuyButtonWithEnabled:(BOOL)enabled {
    self.buttonBuyPig.enabled = enabled;
    if (enabled) {
        self.buttonBuyPig.backgroundColor = [LUtils colorHex:@"#A51318"];
    } else {
        self.buttonBuyPig.backgroundColor = [LUtils colorHex:@"#C1C1C1"];
    }
}

- (void)configureWithPigInfoModel:(ZHPigInfoModel *)pigInfoModel {
    if (!pigInfoModel) {
        self.labelPigBreed.text = @"";
        self.labelPigIntro.text = @"";
        self.labelPigPrice.text = @"";
        self.labelPigPeriod.text = @"";
        self.labelPigRemain.text = @"";
        self.imageViewSellOut.hidden = YES;
        [self configureBuyButtonWithEnabled:NO];
    } else {
        self.labelPigBreed.text = pigInfoModel.title;
        self.labelPigIntro.text = pigInfoModel.subtitle;
        self.labelPigPrice.text = [NSString stringWithFormat:@"¥%.2f", [pigInfoModel.presentPrice floatValue]];
        [self configureLabelPigPeriodWithPeriod:pigInfoModel.presentTerm];
        [self configureLabelPigRemainWithPigRemain:pigInfoModel.presentCount];
        self.imageViewSellOut.hidden = [pigInfoModel.presentCount integerValue] > 0;
        [self configureBuyButtonWithEnabled:[pigInfoModel.presentCount integerValue] > 0];
    }
}

@end
