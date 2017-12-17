//
//  ShoppingCartVC.m
//  XiJuOBJ
//
//  Created by james on 16/9/9.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "ShoppingCartVC.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartModel.h"
#import "ShoppingCarUnderView.h"
#import "GoodsDetailView.h"
#import "ShoppingCartModel.h"
#import "OrderDetailVC.h"
#import "OrderDetailModel.h"
#import "GoodsVC.h"
@interface ShoppingCartVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    ShoppingCarUnderView *_underView;
    BOOL _isAllSelect;
    GoodsDetailView *_goodsView;
}
@property NSMutableArray *tableViewDataArray;
@end

@implementation ShoppingCartVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购物车";
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(prepareData) name:@"shoppingCarChange" object:nil];

     [self configUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark intviewcontroller
-(void)prepareData
{
    [HttpRequestManager postShoppingCarGetRequest:nil viewcontroller:self finishBlock:^(NSMutableArray *data) {
        
        _tableViewDataArray = data;
        if (data.count == 0) {
            self.tableView.hidden = YES;
            _underView.hidden = YES;
        }
        _isAllSelect = NO;
        
        [self myTableViewReload];
//        [self.tableView reloadData];
    }];

}

-(void)configUI
{
    
    
    
    UILabel *wuLab = [Tool labelWithTitle:@"尚未加入任何商品" color:The_placeholder_Color_grary fontSize:15 alignment:1];
    [self.view addSubview:wuLab];
    
    [wuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    
    
    self.view.backgroundColor = The_list_backgroundColor;
    
    UIImageView *wuImageView = [[UIImageView alloc]init];
    wuImageView.image = [UIImage imageNamed:@"wu@2x.png"];
    [self.view addSubview:wuImageView];
    
    [wuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.bottom.mas_equalTo(wuLab.mas_top).offset(-20);
    }];

    
    
    if (self.status) {//推过来的
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64-49) style:UITableViewStylePlain];
    }else{
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KHScreenW, KHScreenH-64-49-49) style:UITableViewStylePlain];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    
    _underView = [[ShoppingCarUnderView alloc]init];
    [self.view addSubview:_underView];
    [self.view bringSubviewToFront:_underView];

    [_underView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.status) {
            make.left.right.bottom.mas_equalTo(0);
        }else{
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-49);
        }
        
        make.height.mas_equalTo(49);
    }];

    [_underView configview1];
    _underView.backgroundColor = [UIColor whiteColor];
    [_underView.allSelectBtn addTarget:self action:@selector(allSelectActon) forControlEvents:UIControlEventTouchUpInside];
    [_underView.orderBtn addTarget:self action:@selector(orderActon) forControlEvents:UIControlEventTouchUpInside];


}

#pragma mark buttonAction

-(void)myTableViewReload
{
    [self.tableView reloadData];

//    BOOL isAllAelect = NO;
    CGFloat money=0;
    CGFloat count=0;

    for (int i = 0; i < _tableViewDataArray.count; i++) {
        
        ShoppingCartModel *model =_tableViewDataArray[i];
        if (model.isSelect) {
            count ++;
            money = [model.price floatValue] * [model.number floatValue] + money;
        }
    }
    
    if (count == _tableViewDataArray.count) {
//        isAllAelect = YES;
        _isAllSelect = YES;
    }else
    {
        _isAllSelect = NO;
    }
    
    [_underView updateView1WithSelect:_isAllSelect money:money count:count];

}

/**
 * 全选按钮
 */

-(void)allSelectActon
{
    for (int i = 0; i < _tableViewDataArray.count; i++) {
        ShoppingCartModel *model =_tableViewDataArray[i];
        model.isSelect = !_isAllSelect;
    }
    _isAllSelect = !_isAllSelect;

    [self myTableViewReload];
}
/**
 * 下单按钮
 */

-(void)orderActon
{
    
    
    OrderDetailVC *vc = [[OrderDetailVC alloc]init];
    OrderDetailModel *orderModel = [[OrderDetailModel alloc]init];

    NSMutableString *cardIds = [[NSMutableString alloc]initWithString:@""];
    for (ShoppingCartModel *tempModel in _tableViewDataArray) {
        
        if (tempModel.isSelect) {
            GoodsModel *selectModel = [[GoodsModel alloc]init];
            selectModel.scalePrice = tempModel.price;
            selectModel.title = tempModel.titleText;
            selectModel.number = tempModel.number;
            selectModel.type = tempModel.type;
            selectModel.color = tempModel.selectModel.color;
            selectModel.goodsId = tempModel.goodsId;
            selectModel.detailId = tempModel.selectModel.ID;
            selectModel.imgUrl = tempModel.selectModel.titleImg;
            selectModel.colorName = tempModel.selectModel.colorName;
            selectModel.leftNumber = tempModel.selectModel.leftCount;
            [cardIds appendFormat:@"%@;",tempModel.carId];
            orderModel.carIds = cardIds;
            [orderModel.goodsArr  addObject:selectModel];

            
            if ([selectModel.leftNumber integerValue] < [selectModel.number integerValue]) {
                [ [MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:[[NSString alloc]initWithFormat:@"%@库存不足",selectModel.title ]];
                return;
            }
            
        }

    }
    
    if (orderModel.goodsArr.count == 0) {
        
//        [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"请选择订单！"];
        return;
    }
    
       vc.model = orderModel;
    [self.navigationController pushViewController:vc animated:YES];
    
}
/**
 * 编辑按钮
 */
-(void)editAction:(UIButton *)btn
{
    
    ShoppingCartModel *model = _tableViewDataArray[btn.tag/100];

    GoodsModel *selectModel = [[GoodsModel alloc]init];
    selectModel.price = model.selectModel.salePrice;
    selectModel.title = model.titleText;
    selectModel.number = model.number;
    selectModel.type = model.type;
    selectModel.color = model.selectModel.color;
    selectModel.goodsId = model.goodsId;
    selectModel.detailId = model.selectModel.ID;
    selectModel.imgUrl = model.selectModel.titleImg;
    selectModel.colorName = model.selectModel.colorName;
    selectModel.leftNumber = @"10000";
    
    
    
    NSDictionary *dic = @{@"goodsId":model.goodsId,
                          };
    
    [HttpRequestManager postGoodsDeatailRequest:dic viewcontroller:self finishBlock:^(GoodsDetailModel *qusetModel) {
        
        ShoppingCartModel *_shoopingModel = [[ShoppingCartModel alloc]init];
        

        
        _shoopingModel.modelArr = qusetModel.shoppingCareGoodsArr;
        _shoopingModel.titleText = qusetModel.title;
        _shoopingModel.type = qusetModel.detailTitle;
        _shoopingModel.price = qusetModel.price;
        _shoopingModel.goodsId = qusetModel.goodsId;
        NSMutableDictionary *colorDic = [[NSMutableDictionary alloc]init];
        NSMutableDictionary *stytleDic = [[NSMutableDictionary alloc]init];
        
        for (int i = 0; i < qusetModel.shoppingCareGoodsArr.count; i++) {
            
            ShoppingGoodsModel *model = qusetModel.shoppingCareGoodsArr[i];
            
            [colorDic setObject:@"1" forKey:model.color];
            [stytleDic setObject:@"1" forKey:model.stytle];
            
            
            if (model.ID  == selectModel.detailId) {
                selectModel.leftNumber = model.leftCount;
            }
            
            
        }
        _shoopingModel.number = @"1";
        _shoopingModel.colorArr = [[colorDic allKeys] mutableCopy];
        _shoopingModel.typeArr = [[stytleDic allKeys] mutableCopy];
        

        
        
        _goodsView = [[GoodsDetailView alloc]init];
        _goodsView.shoppingCarEdit = @"YES";
        _goodsView.selectModel = selectModel;
        _goodsView.carId = model.carId;
        _goodsView.isAddShoppingCare = YES;
        _goodsView.Model = _shoopingModel;
        //    _goodsView.shoppingCareEdit = YES;
        [_goodsView showGoodsView:_goodsView];
        
        [_goodsView.requestBtn addTarget:self action:@selector(requestAction:) forControlEvents:UIControlEventTouchUpInside];

        
    }];
    
    
  
}

/**
 * 确定按钮
 */

-(void)requestAction:(UIButton *)btn
{
    _goodsView.hidden = YES;
    
 

}
/**
 * 删除按钮
 */

-(void)deletAction:(UIButton *)btn
{
    ShoppingCartModel *model = _tableViewDataArray[btn.tag/10];
    
    NSDictionary *dic = @{@"cardId":model.carId,
                          };

    NSInteger index=btn.tag/10;
    __weak __typeof(self)weakSelf = self;
    [[MyAlert manage] showBtnAlertWithTitle:@"提醒" detailTitle:@"是否删除该商品" confirm:^{
        
        [HttpRequestManager postShoppingCarDeletRequest:dic viewcontroller:weakSelf finishBlock:^(NSDictionary *dic) {
            
            if ([dic[@"code"] intValue] == 200) {
                [[MyAlert manage] showNoBtnAlertWithTitle:@"提醒" detailTitle:@"删除成功"];
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"shoppingCarChange" object:nil userInfo:nil];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                [weakSelf.tableViewDataArray removeObjectAtIndex:index];
//                [self.tableView reloadData];
            }
            
        }];

        
    }];
    
    
    
    
}


-(void)selectBtnAction:(UIButton *)btn
{
    ShoppingCartModel *model = _tableViewDataArray[btn.tag/1000];
    model.isSelect = !model.isSelect;
    
    [self myTableViewReload];

    
}

#pragma mark --tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"ShoppingCartCell";
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ShoppingCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    ShoppingCartModel *model = _tableViewDataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    cell.editButton.tag = 100 * indexPath.row;
    cell.deletButton.tag = 10 *indexPath.row;
    cell.selectBtn.tag = 1000 * indexPath.row;
    [cell.editButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deletButton addTarget:self action:@selector(deletAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShoppingCartModel *model = _tableViewDataArray[indexPath.row];

    if (getUserId) {
        GoodsVC *vc = [[GoodsVC alloc]init];
        vc.goodIds = model.goodsId;
        vc.title = model.titleText;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
}

//返回分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

//返回分区的脚的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
    
}

@end
