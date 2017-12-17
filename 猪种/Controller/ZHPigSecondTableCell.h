//
//  ZHPigSecondTableCell.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHPigSecondTableCell : UITableViewCell

+ (CGFloat)heightWithText:(NSString *)text;

- (void)configureWithText:(NSString *)text;

@end
