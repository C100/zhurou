//
//  GoodsCommentCell.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 2016/11/22.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "GoodsCommentCell.h"
#import "GoodsCommentModel.h"
#import "PhotoBrowerViewController.h"
#import "HBTextView.h"
#import "UITools.h"
#import "GoodsModel.h"
#import "OSSMoreImageUpload.h"
#import "UIView+ViewController.h"


@interface GoodsCommentCell()<UITextViewDelegate>
{
    
    UIViewController *_vc;
    GoodsModel *_model;
    
    
}




@end


@implementation GoodsCommentCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier InspectModel:(GoodsModel *)model IndexPath:(NSIndexPath *)indexPath
                          VC:(UIViewController *)vc
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _vc = vc;
        _model = model;
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    
//    UILabel *titleLab = [Tool labelWithTitle:@"我们重视您的每一个反馈，您的建议和批评是对壹筑e家最大的支持，是我们对产品的优化改造的方向和动力！" color:The_TitleColor fontSize:14 alignment:0];
//    [self.contentView addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_offset(10);
//        make.right.mas_offset(-10);
//        make.height.mas_equalTo(50);
//    }];
    
    
    UIView *goodView = [[UIView alloc]init];
    [self.contentView addSubview:goodView];
    
    [goodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(70);
        make.top.mas_equalTo(10);
    }];
    [self creatGoodView:_model partentView:goodView];
    
    HBTextView *textView = [[HBTextView alloc]init];
    textView.borderColor = The_line_Color_grary;
    if (_model.commentStr.length == 0) {
        textView.placeholder = @"请输入评论内容";

    }
    
    textView.borderWidth = 1;
    textView.origianlOffset = CGPointMake(10, 10);
    textView.delegate = self;
    textView.textColor = The_TitleColor;
    textView.font = [UIFont fontWithName:The_titleFont size:13];;
    textView.placeholderColor = The_placeholder_Color_grary;
    
    textView.text = _model.commentStr;
    
    [self.contentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(ScaleY(130));
        make.top.mas_equalTo(goodView.mas_bottom).offset(10);
    }];
    
    _ImageBackView = [[UIView alloc]init];
    [self.contentView addSubview:_ImageBackView];
    [_ImageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textView.mas_bottom).offset(10);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo((KHScreenW-6*10)/5);
    }];
    
//    int width = (KHScreenW - scale_X * 200 ) / 5;
    CGFloat width = (KHScreenW-6*10)/5;
//    if (KHScreenW ==414 ) {
//        width = 100;
//    }
    
    
    
    for (int i = 0; i < _model.commentImgArr.count + 1; i++) {
        UIImageView *btnImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10*(i+1) + (width)* i,0, width, width)];
        btnImgView.tag = 1000 + i;
        btnImgView.contentMode  = UIViewContentModeScaleAspectFill;
        btnImgView.layer.masksToBounds = YES;
        if (i==_model.commentImgArr.count) {
            if (_model.commentImgArr.count==5) {
                btnImgView.hidden = YES;
            }else{
                btnImgView.hidden = NO;
            }
            btnImgView.image = [UIImage imageNamed:@"xiangji.png"];
            [btnImgView addTarget:self action:@selector(xiangjiAction)];
        }else
        {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
//            [Tool setSquareImgurl:btnImgView imgurl:_model.commentImgArr[i]];
            [Tool setImgurl:btnImgView imgurl:_model.commentImgArr[i]];
            btnImgView.userInteractionEnabled = YES;
            [btnImgView addGestureRecognizer:tap];
        }
//        _ImageBackView.backgroundColor = [UIColor redColor];
        [_ImageBackView addSubview:btnImgView];
    }
    
//    backView.backgroundColor = [UIColor redColor];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.mas_equalTo(_ImageBackView.mas_bottom).offset(10);
    }];
    
    
    
    
}

#pragma mark buttonAction


-(void)xiangjiAction
{
    [_vc.view endEditing:YES];

    [UITools selectImageFrom:_vc complete:^(UIImage *img) {
        
        [OSSMoreImageUpload uploadImages:@[img] isAsync:YES type:@(2) complete:^(NSArray<NSString *> *names, UploadImageState state, NSDictionary *dataDic) {
            
            NSString *downLoad = dataDic[@"download"];
            NSArray *images = [downLoad componentsSeparatedByString:@"/"];
            NSString *nameString = [NSString stringWithFormat:@"%@/%@/%@/%@",images[0],images[1],images[2],names.firstObject];
            [_model.commentImgArr addObject:nameString];
            _callback();
//            [HttpRequestManager postUpdateGoodsCommentImgRequest:nameString viewcontroller:_vc finishBlock:^(NSDictionary *data) {
//
//                if ([data[@"code"] integerValue] == 200) {
//
//                    [_model.commentImgArr addObject:data[@"url"]];
//                    _callback();
//                }
//            }];
        }];
        
        
    }];

   
}


//选中图片开启图片浏览
-(void)selectImage:(UITapGestureRecognizer *)btn
{
    
    [_vc.view endEditing:YES];

    
    
    NSInteger index = btn.view.tag - 1000;
    PhotoBrowerViewController *vc = [[PhotoBrowerViewController alloc]init];
    vc.index = index;
    vc.imagesArray = _model.commentImgArr;
    vc.canDelete = YES;
    
    NSMutableArray *tempArr = [[NSMutableArray alloc]initWithArray:_model.commentImgArr];
    [vc setDeleteBlock:^(NSInteger index) {
        [tempArr  removeObjectAtIndex:index];
        _model.commentImgArr = tempArr;
        _callback();
        
    }];
    
    vc.hidesBottomBarWhenPushed = YES;
    [_vc.navigationController pushViewController:vc animated:YES];

    
}

/**
 * 创建商品view
 */
-(UIView *)creatGoodView:(GoodsModel *)model partentView:(UIView *)goodView
{
    
    
    UIImageView *titleImgView = [[UIImageView alloc]init];
    [Tool setImgurl:titleImgView imgurl:model.imgUrl];
    [goodView addSubview:titleImgView];
    
    UILabel *titleLab = [Tool labelWithTitle:model.title color:The_TitleColor fontSize:16 alignment:0];
    [goodView addSubview:titleLab];
    
    NSString *priceStr = [[NSString alloc]initWithFormat:@"￥%@",model.price];
    UILabel *priceLab = [Tool labelWithTitle:priceStr color:The_TitleDeepColor fontSize:16 alignment:2];
    priceLab.hidden = YES;
    [goodView addSubview:priceLab];
    
    NSString *typeStr =[ [NSString alloc]initWithFormat:@"%@ | %@",model.colorName,model.type ];
    
    UILabel *typeLab = [Tool labelWithTitle:typeStr color:The_wordsColor fontSize:12 alignment:0];
    [goodView addSubview:typeLab];
//    model.timeStr
    
    NSString *num = [[NSString alloc]initWithFormat:@"%@",model.timeStr];
    UILabel *numberLab = [Tool labelWithTitle:num color:The_wordsColor fontSize:12 alignment:2];
    [goodView addSubview:numberLab];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = The_line_Color_grary;
    lineView.hidden = YES;
    [goodView addSubview:lineView];
    
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = The_list_backgroundColor;
    [goodView addSubview:lineView2];
    
    
    [titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleImgView.mas_right).offset(10);
        make.top.mas_offset(10);
        make.height.mas_equalTo(@18);
        //            make.size.mas_equalTo(CGSizeMake(150, 18));
        make.right.mas_equalTo(priceLab.left).offset(-5);
    }];
    
    WS(ws);
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.contentView.mas_right).offset(-10);
        make.top.mas_offset(10);
        //            make.left.mas_equalTo(ws.titleLab.mas_right);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@100);
        
    }];
    
    [typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleImgView.mas_right).offset(10);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
        make.right.mas_equalTo(numberLab.left).offset(-5);
        make.height.mas_equalTo(16);
        
    }];
    
    [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@150);
    }];
    //
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleImgView.mas_bottom).offset(10);
        make.left.offset(10);
        make.height.mas_equalTo(1);
        make.right.mas_offset(0);
    }];
    //
    
    return goodView;
    
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    _model.commentStr = textView.text;

}



@end
