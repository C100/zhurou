//
//  BackProductInstructCell.h
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/7.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackProductInstructCell : UITableViewCell<UITextViewDelegate>

@property(nonatomic, strong) UITextView *myTextView;
@property(nonatomic, strong) UILabel *placeholderLabel;

@end
