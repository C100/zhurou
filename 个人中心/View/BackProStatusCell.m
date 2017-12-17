//
//  BackProStatusCell.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProStatusCell.h"

@implementation BackProStatusCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.timeLabel = [Tool labelWithTitle:@"退换时间：2017-06-20" color:k888888Color fontSize:12 alignment:0];
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(12);
            make.height.mas_equalTo(12);
            make.bottom.mas_equalTo(-12);
        }];
        
        self.stateLabel = [Tool labelWithTitle:@"退货中" color:k888888Color fontSize:12 alignment:2];
        [self addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(12);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kDDDDDDColor;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(1);
            make.right.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)setBackModel:(BackProductModel *)backModel{
    _backModel = backModel;
    self.timeLabel.text = [NSString stringWithFormat:@"退换时间：%@",backModel.ctime];
    NSString *type;
    if (backModel.type.intValue==1) {//退货
        type = @"退货";
    }else{
        type = @"换货";
    }
        switch (backModel.status.intValue) {
            case 1://申请
                self.stateLabel.text = [NSString stringWithFormat:@"申请%@",type];
                break;
            case 2://中
                self.stateLabel.text = [NSString stringWithFormat:@"%@中",type];
                break;
            case 3://拒绝
                self.stateLabel.text = [NSString stringWithFormat:@"%@失败",type];
                break;
            case 4:
                self.stateLabel.text = [NSString stringWithFormat:@"%@成功",type];
                break;
                
            default:
                break;
        }
    

}

@end
