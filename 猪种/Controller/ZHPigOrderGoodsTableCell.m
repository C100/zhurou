//
//  ZHPigOrderGoodsTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/13.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigOrderGoodsTableCell.h"
#import "ZHScreenAdaptation.h"
#import "ZHPigBuyModel.h"
#import "ZHPigGiftModel.h"

@interface ZHPigOrderGoodsTableCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelTop;
@property (nonatomic, weak) IBOutlet UILabel *labelTitle;
@property (nonatomic, weak) IBOutlet UILabel *labelSubTitle;
@property (nonatomic, weak) IBOutlet UILabel *labelPrice;
@property (nonatomic, weak) IBOutlet UILabel *labelCount;

@property (nonatomic, weak) IBOutlet UIImageView *imageViewIcon;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelTitleLeftConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelTitleTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *viewTopHeightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelSubTitleTopConstraint;

@end

@implementation ZHPigOrderGoodsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labelTop.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:12]];
    self.labelTitle.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:16]];
    self.labelSubTitle.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:12]];
    self.labelPrice.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:16]];
    self.labelCount.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:12]];

    self.viewTopHeightConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:35];
    self.labelTitleLeftConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:20];
    self.imageViewWidthConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:50];
    self.labelTitleTopConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14];
    self.labelSubTitleTopConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:12];
}

- (void)configureWithPigBuyModel:(ZHPigBuyModel *)pigBuyModel {
    self.labelTop.text = @"您将认购猪种";
    self.labelSubTitle.hidden = NO;
    self.labelSubTitle.text = pigBuyModel.pigIntroduce;
    if (!pigBuyModel) {
        return;
    }
    self.labelTitle.text = pigBuyModel.pigBreed;
    self.labelPrice.text = [NSString stringWithFormat:@"¥%@", @(pigBuyModel.pigPrice)];
    self.labelCount.text = [NSString stringWithFormat:@"x %@", @(pigBuyModel.buyCount)];
    [self.imageViewIcon sd_setImageWithURL:[NSURL URLWithString:pigBuyModel.pigImage]];
}

- (void)configureWithPigGiftModel:(ZHPigGiftModel *)pigGiftModel {
    self.labelTop.text = @"获得赠品";
    if (!pigGiftModel) {
        return;
    }
    self.labelTitle.text = pigGiftModel.giftName;
    self.labelSubTitle.hidden = YES;
    self.labelCount.text = @"x 1";

    NSString *prefixString = @"原价：￥";
    NSString *price = [NSString stringWithFormat:@"%@", pigGiftModel.giftPrice];
    NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", prefixString, price]];
    NSRange range = NSMakeRange(prefixString.length, price.length);
    [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:range];
    [newPrice addAttribute:NSBaselineOffsetAttributeName value:@(NSUnderlineStyleSingle) range:range];
    self.labelPrice.attributedText = newPrice;

    [self.imageViewIcon sd_setImageWithURL:[NSURL URLWithString:pigGiftModel.giftImage]];
}

@end
