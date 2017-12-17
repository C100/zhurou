//
//  ZHPigThirdTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigThirdTableCell.h"

@interface ZHPigThirdTableCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageViewBackground;

@end

@implementation ZHPigThirdTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithImageURLString:(NSString *)imageURLString {
    [self.imageViewBackground sd_setImageWithURL:[NSURL URLWithString:imageURLString]];
}

@end
