//
//  ZHPigSecondTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigSecondTableCell.h"
#import "ZHScreenAdaptation.h"

@interface ZHPigSecondTableCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelIntro;

@end

@implementation ZHPigSecondTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configureWithText:(NSString *)text {
    self.labelIntro.text = text;
    self.labelIntro.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]];
}

+ (CGFloat)heightWithText:(NSString *)text {
    CGFloat labelHeight = [text boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]]} context:nil].size.height;

    CGFloat actualHeight = 0;
#if defined(__LP64__) && __LP64__
    actualHeight = ceil(labelHeight);
#else
    actualHeight = ceilf(labelHeight);
#endif
    return fmaxf(actualHeight + 20, 16 + 20);
}

@end
