//
//  BackProductInstructCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/7.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProductInstructCell.h"

@implementation BackProductInstructCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel*titleLabel = [Tool labelWithTitle:@"退款说明：" color:k888888Color fontSize:14 alignment:0];
        [self addSubview:titleLabel];
        [titleLabel sizeToFit];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(13);
            make.size.mas_equalTo(CGSizeMake(titleLabel.bounds.size.width, 14));
        }];
        
        self.myTextView = [[UITextView alloc]init];
        self.myTextView.delegate = self;
        [self addSubview:self.myTextView];
        [self.myTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right).mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(13);
            make.height.mas_equalTo(46);
            make.bottom.mas_equalTo(-13);
        }];
        
        self.placeholderLabel = [Tool labelWithTitle:@"选填" color:kDDDDDDColor fontSize:14 alignment:0];
        [self.placeholderLabel sizeToFit];
        [self.myTextView addSubview:self.placeholderLabel];
        [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(2);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(self.placeholderLabel.bounds.size.width, 14));
        }];
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length==0) {
        self.placeholderLabel.hidden = NO;
    }else{
        self.placeholderLabel.hidden = YES;
    }
}

@end
