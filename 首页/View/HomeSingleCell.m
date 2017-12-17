//
//  HomeCell.m
//  XiJuOBJ
//
//  Created by james on 16/9/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "HomeSingleCell.h"

@implementation HomeSingleCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(HomeModel *)model index:(NSIndexPath *)index uiviewcontroller:(UIViewController *)vc
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _titleImgView = [[UIImageView alloc]init];
        _titleImgView.frame = CGRectMake(0, 0, KHScreenW, 220);
        [Tool setImgurl:_titleImgView imgurl:model.titleImgUrl];
//        [Tool setSquareImgurl:_titleImgView imgurl:model.titleImgUrl];
        
        
        [self.contentView addSubview:_titleImgView];
        
        _titleLab = [Tool labelWithTitle:model.title color:The_TitleColor fontSize:16 alignment:0];
        _titleLab.frame = CGRectMake(10, CGRectGetMaxY(_titleImgView.frame) + 10, 200, 18);
        [self.contentView addSubview:_titleLab];

        
        _priceLab = [Tool labelWithTitle:model.Price color:The_TitleDeepColor fontSize:16 alignment:2];
        _priceLab.frame = CGRectMake(KHScreenW - 150, CGRectGetMaxY(_titleImgView.frame) + 10, 140, 18);
        [self.contentView addSubview:_priceLab];
        
        
        _detailTitleLab = [Tool labelWithTitle:model.detailTitle color:The_wordsColor fontSize:12 alignment:0];
        _detailTitleLab.frame = CGRectMake(10, CGRectGetMaxY(_priceLab.frame) + 10, KHScreenW - 20, 14);
        _detailTitleLab.numberOfLines = 1;
        [self.contentView addSubview:_detailTitleLab];
        
        
        for (int i = 0; i < model.colorArr.count; i++) {
            NSString *HEXstr = model.colorArr[i];
            UIView * dian = [ self dianView:[Tool getColorFromHex:HEXstr]];
            dian.frame = CGRectMake(10 + i*20,CGRectGetMaxY(_detailTitleLab.frame) + 8, 10, 10);
            [self.contentView addSubview:dian];

        }

        CGFloat width = (KHScreenW - 15*4)/3;
        NSLog(@"%f",CGRectGetMaxY(_detailTitleLab.frame) + 38);
        
//        if (model.isOpen) {
//            for (int i = 0; i < model.imgArr.count; i++) {
//                
//                UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(15 + i%3*(width + 15), CGRectGetMaxY(_detailTitleLab.frame) + 38  + i/3*(width + 10), width, width)];
//                [Tool setImgurl:imgview imgurl:model.imgArr[i]];
//                imgview.contentMode = UIViewContentModeScaleAspectFit;
//
//                [self.contentView addSubview:imgview];
//                
//            }
//        }else
//        {
//            NSInteger count = 0;
//            if (model.imgArr.count >5) {
//                count = 6;
//            }else
//            {
//                count = model.imgArr.count;
//            }
//            
//                for (int i = 0; i < count; i++) {
//                    
//                    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(15 + i%3*(width + 15), CGRectGetMaxY(_detailTitleLab.frame) + 38  + i/3*(width + 10), width, width)];
//                    imgview.contentMode = UIViewContentModeScaleAspectFit;
//                    [Tool setImgurl:imgview imgurl:model.imgArr[i]];
//                    [self.contentView addSubview:imgview];
//                    
//                    if (i==5) {
//                        
//                        UIView *backView = [[UIView alloc]initWithFrame: CGRectMake(15 + i%3*(width + 15), CGRectGetMaxY(_detailTitleLab.frame) + 38  + i/3*(width + 10), width, width)];
//                        backView.backgroundColor = [UIColor whiteColor];
//                        [self.contentView addSubview:backView];
//
//                        _moreButton = [Tool buttonWithTitle:@"查看更多" titleColor:The_wordsColor font:13 imageName:nil target:self action:nil];
//                        
//                        _moreButton.size = CGSizeMake(70, 30);
//                        _moreButton.center =backView.center;
//                        [_moreButton.layer setBorderWidth:1]; //边框宽度
//                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//                        NSArray *RGBArr = @[@(205),@(205),@(205)];
//                        
//                        if (RGBArr.count >=3) {
//                            CGFloat r =[RGBArr[0]floatValue];
//                            CGFloat g =[RGBArr[1]floatValue];
//                            CGFloat b =[RGBArr[2]floatValue];
//                            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){r/255, g/255, b/255, 1 });
//                            [_moreButton.layer setBorderColor:colorref];
//                        }
//                        [self.contentView addSubview:_moreButton];
// 
//                        
//                    }
//                    
//                }
//
//
//        }
        
        
        
    }
    
    
    return self;
}



-(UIView*)dianView:(UIColor *)color
{
    
    UIView *dian = [[UIView alloc]init];
    dian.borderWidth = 1;
    dian.borderColor = The_TitleColor;
    dian.size = CGSizeMake(10, 10);
    dian.cornerRadius = 5;
    dian.backgroundColor = color;
    return dian;
    
}


//- (void)setModel:(HomeModel *)model
//{
////    _model = model;
//    
//}
//

@end
