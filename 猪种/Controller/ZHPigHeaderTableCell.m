//
//  ZHPigHeaderTableCell.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigHeaderTableCell.h"

@interface ZHPigHeaderTableCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelTitle;

@end

@implementation ZHPigHeaderTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithTitle:(NSString *)title {
    self.labelTitle.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
