//
//  MyPigFirstLevelCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "MyPigFirstLevelCell.h"

@implementation MyPigFirstLevelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *linView = [[UIView alloc]init];
        [self addSubview:linView];
        linView.backgroundColor = kDDDDDDColor;
        [linView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(36);
            make.height.mas_equalTo(1);
            make.right.mas_equalTo(0);
        }];
        
        self.giftedButton = [[UIButton alloc]init];
        [self addSubview:self.giftedButton];
        [self.giftedButton setImage:[UIImage imageNamed:@"礼包"] forState:UIControlStateNormal];
        [self.giftedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(7);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        
        self.iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"待支付"]];
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        
        self.buyButton = [[UIButton alloc]init];
        [self addSubview:self.buyButton];
        [self.buyButton setTitle:@"购买凭证" forState:UIControlStateNormal];
        [self setStyleWithButton:self.buyButton];
        [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-53);
            make.top.mas_equalTo(9);
            make.size.mas_equalTo(CGSizeMake(58, 18));
        }];
        
        self.consumeButton = [[UIButton alloc]init];
        [self addSubview:self.consumeButton];
        [self.consumeButton setTitle:@"消费凭证" forState:UIControlStateNormal];
        [self setStyleWithButton:self.consumeButton];
        [self.consumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.buyButton.mas_left).mas_equalTo(-6);
            make.top.mas_equalTo(9);
            make.size.mas_equalTo(CGSizeMake(58, 18));
        }];
        
        self.proLabel = [Tool labelWithTitle:@"产品名称" color:k555555Color fontSize:16 alignment:0];
        [self addSubview:self.proLabel];
        [self.proLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.giftedButton.mas_right).mas_equalTo(7);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(self.consumeButton.mas_left).mas_equalTo(-5);
        }];
        
        NSArray *titles = @[@"下单时间",@"认购数量",@"认购月份/总月份",@"当前月份/总月份",@"认购价格/当前价格",@"认购总价格/当前总价格",];
        for (int i = 0; i<6; i++) {
            UILabel *leftLabel = [Tool labelWithTitle:titles[i] color:k888888Color fontSize:14 alignment:0];
            [leftLabel sizeToFit];
            [self addSubview:leftLabel];
            [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(linView.mas_bottom).mas_equalTo(9+(14+12)*i);
                make.left.mas_equalTo(20);
                make.size.mas_equalTo(CGSizeMake(leftLabel.bounds.size.width, 14));
            }];
            
            UILabel *rightLabel = [Tool labelWithTitle:@"2017-12-7" color:k333333Color fontSize:14 alignment:2];
            [self addSubview:rightLabel];
            rightLabel.tag = 1000+i;
            [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-21);
                make.top.mas_equalTo(linView.mas_bottom).mas_equalTo(9+(14+12)*i);
                make.height.mas_equalTo(14);
                make.left.mas_equalTo(leftLabel.mas_left).mas_equalTo(-3);
            }];
            
            if (i==5) {
                self.lastLabel = leftLabel;
            }
        }
        
        CGFloat width = (KHScreenW-16-2*ScaleX(26)-ScaleX(63))/2;
        self.leftButton = [[UIButton alloc]init];
        [self addSubview:self.leftButton];
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ScaleY(26));
            make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
            make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
            make.bottom.mas_equalTo(-21);
        }];
        [self.leftButton setTitle:@"发起变售" forState:UIControlStateNormal];
        [self setButtonStyleWithButton:self.leftButton];
        
        self.rightButton = [[UIButton alloc]init];
        [self addSubview:self.rightButton];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-ScaleY(26));
            make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
            make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
            make.bottom.mas_equalTo(-21);
        }];
        [self.rightButton setTitle:@"提前交割" forState:UIControlStateNormal];
        [self setButtonStyleWithButton:self.rightButton];
    
    }
    return self;
}

-(void)setStyleWithButton:(UIButton *)sender{
    sender.layer.cornerRadius = 4;
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = kC7C7C7Color.CGColor;
    [sender setTitleColor:kC7C7C7Color forState:UIControlStateNormal];
    sender.titleLabel.font = kFont(12);
}

-(void)setButtonStyleWithButton:(UIButton *)sender{
    sender.layer.cornerRadius = 4;
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = The_MainColor.CGColor;
    [sender setTitleColor:The_MainColor forState:UIControlStateNormal];
    sender.titleLabel.font = kFont(16);
}

-(void)setListModel:(MyPigListModel *)listModel{
    _listModel = listModel;
    switch (listModel.state.intValue) {
        case 0://未支付
        {
            self.iconImageView.image = [UIImage imageNamed:@"待支付"];
//            [self.leftButton setTitle:@"删除" forState:UIControlStateNormal];
            self.leftButton.hidden = YES;
            [self.rightButton setTitle:@"付款" forState:UIControlStateNormal];
            self.buyButton.hidden = YES;
            self.consumeButton.hidden = YES;
            
            CGFloat width = (KHScreenW-16-2*ScaleX(26)-ScaleX(63))/2;
            [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
                make.bottom.mas_equalTo(-21);
            }];
            [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
                make.bottom.mas_equalTo(-21);
            }];
            
        }
            break;
        case 1:
        {
            self.iconImageView.image = [UIImage imageNamed:@"已交割"];
            [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(0, 0));
                make.bottom.mas_equalTo(0);
            }];
            [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(0, 0));
                make.bottom.mas_equalTo(0);
            }];
            [self.consumeButton setTitle:@"交割凭证" forState:UIControlStateNormal];
            [self.buyButton setTitle:@"购买凭证" forState:UIControlStateNormal];
            self.buyButton.hidden = NO;
            self.consumeButton.hidden = NO;
        }
            break;
        case 2:
        {
            self.iconImageView.image = [UIImage imageNamed:@"已托管"];
            [self.rightButton setTitle:@"托管详情" forState:UIControlStateNormal];
            self.leftButton.hidden = YES;
            [self.consumeButton setTitle:@"托管凭证" forState:UIControlStateNormal];
            [self.buyButton setTitle:@"购买凭证" forState:UIControlStateNormal];
            
            CGFloat width = (KHScreenW-16-2*ScaleX(26)-ScaleX(63))/2;
            [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
                make.bottom.mas_equalTo(-21);
            }];
            [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
                make.bottom.mas_equalTo(-21);
            }];
            self.buyButton.hidden = NO;
            self.consumeButton.hidden = NO;
        }
            
            break;
        case 3:
        {
            self.iconImageView.image = [UIImage imageNamed:@"已到期"];
            self.consumeButton.hidden = YES;
            [self.buyButton setTitle:@"购买凭证" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"托管" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"交割" forState:UIControlStateNormal];
            CGFloat width = (KHScreenW-16-2*ScaleX(26)-ScaleX(63))/2;
            [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
                make.bottom.mas_equalTo(-21);
            }];
            [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
                make.bottom.mas_equalTo(-21);
            }];
            self.buyButton.hidden = NO;
//            self.consumeButton.hidden = YES;
        }
            
            break;
        case 6:
        {
            self.iconImageView.image = [UIImage imageNamed:@"已关闭"];
            self.buyButton.hidden = YES;
            self.consumeButton.hidden = YES;
            [self.rightButton setTitle:@"删除" forState:UIControlStateNormal];
            self.leftButton.hidden = YES;
            CGFloat width = (KHScreenW-16-2*ScaleX(26)-ScaleX(63))/2;
            [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
                make.bottom.mas_equalTo(-21);
            }];
            [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
                make.bottom.mas_equalTo(-21);
            }];
        }
            break;
        case 7:
        {
            self.iconImageView.image = [UIImage imageNamed:@"已购买"];
            self.consumeButton.hidden = YES;
            [self.buyButton setTitle:@"购买凭证" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"发起变售" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"提前交割" forState:UIControlStateNormal];
            CGFloat width = (KHScreenW-16-2*ScaleX(26)-ScaleX(63))/2;
            [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
                make.bottom.mas_equalTo(-21);
            }];
            [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(width, ScaleY(38)));
                make.bottom.mas_equalTo(-21);
            }];
            self.buyButton.hidden = NO;
//            self.consumeButton.hidden = YES;
        }
            break;
        case 8://已完成
        {
            self.iconImageView.image = [UIImage imageNamed:@"已消费"];
            [self.consumeButton setTitle:@"消费凭证" forState:UIControlStateNormal];
            [self.buyButton setTitle:@"购买凭证" forState:UIControlStateNormal];
            [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(0, 0));
                make.bottom.mas_equalTo(0);
            }];
            [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-ScaleY(26));
                make.top.mas_equalTo(self.lastLabel.mas_bottom).mas_equalTo(29);
                make.size.mas_equalTo(CGSizeMake(0, 0));
                make.bottom.mas_equalTo(0);
            }];
            self.buyButton.hidden = NO;
            self.consumeButton.hidden = NO;
        }
            
            break;
            
        default:
            break;
    }
    
    
    for (int i = 0; i<6; i++) {
        UILabel *rightLabel = [self viewWithTag:1000+i];
        switch (i) {
            case 0://下单时间
                rightLabel.text = [LUtils stringToDate:listModel.time.stringValue];
                break;
            case 1://认购数量
                rightLabel.text = [NSString stringWithFormat:@"%@头",listModel.count];
                break;
            case 2://认购月份/总月份
                rightLabel.text = [NSString stringWithFormat:@"%@/%@",listModel.term,listModel.saleLimit];
                break;
            case 3://当前月份/总月份
                rightLabel.text = [NSString stringWithFormat:@"%@/%@",listModel.presentTerm,listModel.saleLimit];
                break;
            case 4://认购价格/当前价格
                rightLabel.text = [NSString stringWithFormat:@"%@/%@",listModel.price,listModel.presentPrice];
                
                break;
            case 5:
                rightLabel.text = [NSString stringWithFormat:@"%@/%@",listModel.totalPrice,listModel.presentTotalPrice];
                break;
            default:
                break;
        }
    }
}

@end
