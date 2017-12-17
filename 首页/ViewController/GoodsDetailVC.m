//
//  GoodsDetailVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/7.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "GoodsDetailVC.h"
#import "GoodsDetailCell.h"
#import "GoodsDetailModel.h"
#import "CommonModel.h"
#import "LoginVC.h"
#import "CommentModel.h"
#import "CommentCell.h"
#import "ShoppingCarUnderView.h"
#import "GoodsDetailView.h"
#import "ShoppingGoodsModel.h"
#import "MQChatViewManager.h"

@interface GoodsDetailVC ()<UITableViewDelegate,UITableViewDataSource,GoodsDetailCellDelegate>
{
//    GoodsDetailModel *_dataModel;
    ShoppingCarUnderView *_underView;
    GoodsDetailView *_goodsView;
    ShoppingCartModel *_shoopingModel;
}

@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataModel:) name:@"reloadDataModel" object:nil];
    _shoopingModel = [[ShoppingCartModel alloc]init];
    [self prepareData];
    [self configUI];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark intviewcontroller
-(CGSize)baseUrl:(NSString *)url{
    NSMutableString *tempStr =[[NSMutableString alloc]init];
            if ( [url hasPrefix:@"http"]) {
                [tempStr appendFormat:@"%@",url];
    
            }else
            {
                [tempStr appendFormat:@"%@/%@",ImgBase_Url,url];
    
            }
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:tempStr]];
            UIImage *image = [UIImage imageWithData:data];
    return image.size;
}
-(void)reloadDataModel:(NSNotification *)text
{
    _dataModel =  text.object;
    _dataModel.firstSize = [self baseUrl:_dataModel.titleImg];
    for (int i = 0; i<_dataModel.goodsArr.count; i++) {
        CommonModel *commomModel = _dataModel.goodsArr[i];
        commomModel.secSize = [self baseUrl:commomModel.imgUrl];
    }
    _dataModel.thirdSize = [self baseUrl:_dataModel.chicunImg];
    _shoopingModel.modelArr = _dataModel.shoppingCareGoodsArr;
    _shoopingModel.titleText = _dataModel.title;
    _shoopingModel.type = _dataModel.detailTitle;
    _shoopingModel.price = _dataModel.scleprice;
    _shoopingModel.originalPrice = _dataModel.price;
    _shoopingModel.goodsId = _dataModel.goodsId;
    _shoopingModel.smallUrl = _dataModel.smallUrl;
//    _shoopingModel.colorName = _dataModel.
    
    NSMutableDictionary *colorDic = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *stytleDic = [[NSMutableDictionary alloc]init];
    _shoopingModel.colorNameArr = [NSMutableArray array];
    for (int i = 0; i < _dataModel.shoppingCareGoodsArr.count; i++) {
        
        ShoppingGoodsModel *model = _dataModel.shoppingCareGoodsArr[i];
    
        [colorDic setObject:@"1" forKey:model.color];
        [stytleDic setObject:@"1" forKey:model.stytle];
        [_shoopingModel.colorNameArr addObject: model.colorName];
        
    }
    _shoopingModel.number = @"1";
    _shoopingModel.colorArr = [[colorDic allKeys] mutableCopy];
    _shoopingModel.typeArr = [[stytleDic allKeys] mutableCopy];
    
    
    _underView = [[ShoppingCarUnderView alloc]init];
    [self.view addSubview:_underView];
    [self.view bringSubviewToFront:_underView];
    [_underView configGoodsDetailView:_dataModel.price andSclaPrice:_dataModel.scleprice];
    [_underView.btn2 addTarget:self action:@selector(shoppingCarAction) forControlEvents:UIControlEventTouchUpInside];
    [_underView.btn3 addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(@49);
    }];
    

//    NSNumber *priceNum = @(_dataModel.price.floatValue);
//    NSNumber *scaleNum = @(_dataModel.scleprice.floatValue);
//    if ([priceNum isEqual:scaleNum]) {
//        _underView.Lab1.text = [[NSString alloc]initWithFormat:@"￥%@起",[Tool priceChange:_dataModel.price]];
//        
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_underView.Lab1.text];
//        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0,1)];
//        //    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,@"".length)];
//        _underView.Lab1.attributedText = str;
//    }else{
//        _underView.Lab1.text = [[NSString alloc]initWithFormat:@"%@",[Tool priceChange:_dataModel.price]];
////        _underView.scaleLabel.text = [NSString stringWithFormat:@"￥%@",[Tool priceChange:_dataModel.scleprice]];
////        
//        NSString *titleZongStr = [[NSString alloc]initWithFormat:@"￥%@",[Tool priceChange:_dataModel.scleprice] ];
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleZongStr];
//        [str addAttribute:NSForegroundColorAttributeName value:The_wordsColor range:NSMakeRange(0,@"".length)];
//        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(@"".length,1)];
//        _underView.scaleLabel.attributedText = str;
//        
//    }
    [_underView.btn1 addTarget:self action:@selector(kefuAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView reloadData];
}

-(void)prepareData
{
    
}

-(void)configUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = The_list_light_backgroundColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //注册
    [self.tableView registerClass:[GoodsDetailCell class] forCellReuseIdentifier:@"GoodsDetailCell"];
    self.tableView.estimatedRowHeight = 100;
//    _underView = [[ShoppingCarUnderView alloc]init];
//    [self.view addSubview:_underView];
//    [self.view bringSubviewToFront:_underView];
//    [_underView configGoodsDetailView:_dataModel.price andSclaPrice:_dataModel.scleprice];
//    [_underView.btn2 addTarget:self action:@selector(shoppingCarAction) forControlEvents:UIControlEventTouchUpInside];
//    [_underView.btn3 addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
//
//
//    [_underView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(@49);
//    }];
    
    
}

#pragma mark buttonAction

-(void)kefuAction
{
    [[Tool tools] showkefuViewController:self];
}


-(void)collectionAction:(UIButton *)sender
{
    BXLog(@"收藏");
    NSDictionary *dic = @{@"goodsId":_goodsID};

    if ([_dataModel.isCollection intValue] == 0) {
        [ HttpRequestManager postCollectAddRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            
            if ([data[@"code"] intValue] == 200) {
                _dataModel.isCollection = @"1";
//                [self.tableView reloadData];
                    [sender setImage:[UIImage imageNamed:@"yishoucang@2x.png"] forState:UIControlStateNormal];
            }
        }];

    }else
    {
        [ HttpRequestManager postCollectDelteRequest:dic viewcontroller:self finishBlock:^(NSDictionary *data) {
            if ([data[@"code"] intValue] == 200) {
                _dataModel.isCollection = @"0";
//                [self.tableView reloadData];
                [sender setImage:[UIImage imageNamed:@"weishoucang@2x.png"] forState:UIControlStateNormal];
            }

        }];

    }
    
    
}

//购物车
-(void)shoppingCarAction
{
    _goodsView = [[GoodsDetailView alloc]init];
    _goodsView.Model = _shoopingModel;
//    _goodsView.shoppingCareEdit = YES;
    _goodsView.isAddShoppingCare = YES;
    [_goodsView showGoodsView:_goodsView];

//    [_goodsView.requestBtn addTarget:self action:@selector(requestAction) forControlEvents:UIControlEventTouchUpInside];
    
}

//购买按钮
-(void)buyAction
{
//    if () {
//        
//    }
    _goodsView = [[GoodsDetailView alloc]init];
    _goodsView.Model = _shoopingModel;
    //    _goodsView.shoppingCareEdit = YES;
    _goodsView.isAddShoppingCare = NO;
    [_goodsView showGoodsView:_goodsView];
}


//确定
-(void)requestAction
{
    
}

//更多评论
-(void)moreCommentAction
{
    self.moreCommentcallback();
}

#pragma mark --tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger row= 0;
    switch (section) {
        case 0:
            row=1;
            break;
        case 1:
            row=_dataModel.goodsArr.count;
            break;
        case 2:
            row=1;
            break;
        case 3:
            row=1;
            break;
        case 4:
            row=1;
            break;
        case 5:
        {
            row=_dataModel.commentArr.count;
            if (_dataModel.commentArr.count > 3) {
                row = 3;
            }
        }
            break;
        default:
            break;
    }
    
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5) {
        static NSString *cellid = @"Comment333Cell";
        CommentModel *model = _dataModel.commentArr[indexPath.row];
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
//            cell.backgroundColor = [UIColor redColor];
            cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
//        return cell;
    }else
    {
//        GoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsDetailCell" forIndexPath:indexPath];
//        cell.vc = self;
//        cell.indexPath = indexPath;
//        cell.model = _dataModel;
        
        GoodsDetailCell *cell = [[GoodsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodsDetailCell" model:_dataModel index:indexPath];
        cell.goodsDetailCellDelegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.collectBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 5) {
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor whiteColor];
        backView.frame = CGRectMake(0, 0, KHScreenW, 60);
        
        if (_dataModel.commentArr.count >3) {
            UIButton *btn = [Tool buttonWithTitle:@"查看更多评论" titleColor:The_wordsColor font:13 imageName:nil target:self action:@selector(moreCommentAction)];
            btn.borderWidth = 1;
            btn.borderColor = The_line_Color_grary;
            [backView addSubview:btn];
            btn.frame = CGRectMake(50, 10, KHScreenW-100, 40);

        }else
        {
            UILabel *titleLab = [Tool labelWithTitle:@"没有更多评论" color:The_placeholder_Color_grary fontSize:13 alignment:1];
            [backView addSubview:titleLab];
            titleLab.frame = CGRectMake(50, 10, KHScreenW-100, 40);
        }
        
        
        return backView;

    }else
    {
        return nil;
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 5) {
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor whiteColor];
        backView.frame = CGRectMake(0, 0, KHScreenW, 50);
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = The_list_light_backgroundColor;
        lineView.frame = CGRectMake(0, 0, KHScreenW, 10);
        [backView addSubview:lineView];
        
        NSString *pinglunStr = [[NSString alloc]initWithFormat:@"评论(%lu)",(unsigned long)_dataModel.commentArr.count ];
        
        UILabel *titleLab = [Tool labelWithTitle:pinglunStr color:The_TitleColor fontSize:16 alignment:1];
        [backView addSubview:titleLab];
        titleLab.frame = CGRectMake(0, 20, KHScreenW, 20);
        return backView;
        
    }else
    {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    LoginVC *vc = [[LoginVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}
//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 5) {
        return 50;
    }else if(section == 0){
        return 0.1;
    }
    return 10;
}


//返回分区的脚的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 5) {
        return 60;
        
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row= 0;
    switch (indexPath.section) {
        case 0:
//            row= ScalePx(220) + 46 + _dataModel.detailHeight + 20;
            if (self.dataModel==nil) {
                return 60;
            }
            return UITableViewAutomaticDimension;
            break;
        case 1:
        {
//            CommonModel *commonModel =  _dataModel.goodsArr[indexPath.row];
//            row=commonModel.height + ScalePx(195) + 25;
            return UITableViewAutomaticDimension;

        }
            break;
        case 2:
        {
//            row= ScalePx(152) + 60;
            return UITableViewAutomaticDimension;
            
        }
            break;
        case 3:
        {
            if (_dataModel.canshuCellHeight==0) {
                row = 158;
            }else{
                row= _dataModel.canshuCellHeight;
            }
            
            
        }
            break;
        case 4:
        {
//            row= (_dataModel.tuijianArr.count/3 + 1) * 100 + 58;
            return UITableViewAutomaticDimension;
        }
            break;
        case 5:
        {
        
            return UITableViewAutomaticDimension;
//            CommentModel *model = _dataModel.commentArr[indexPath.row];
//            
//            CGFloat cellHeight;
//            
//            cellHeight = model.detailTitleHeight + 44;
//            
//            if (model.imgArr.count > 0) {
//                cellHeight  = ScalePx(80) + cellHeight + 10;
//            }
//            
//            if (model.replyTitle.length > 0) {
//                cellHeight  = 80 + cellHeight + model.replyTitleHeight;
//            }
//            
//            return cellHeight;

        }
            break;
        default:
            break;
    }
    
    return row;
}

-(void)refreshTableView{
    [self.tableView reloadData];
}

@end
