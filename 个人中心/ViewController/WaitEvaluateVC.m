//
//  WaitEvaluateVC.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/26.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "WaitEvaluateVC.h"
#import "OrderModel.h"
#import "OrderCell.h"
#import "OrderDetailVC.h"



@interface WaitEvaluateVC ()

@end

@implementation WaitEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self pingjiaAction];
}

-(void)pingjiaAction
{
}

-(void)reloadDataModel:(NSNotification *)text
{
    NSDictionary *dataDic =  text.object;
    self.tableViewDataArray = [[NSMutableArray alloc]init];
    
    NSArray *dataArr = dataDic[@"allReceipt"];
    
    for (int i = 0; i < dataArr.count; i++) {
        
        NSDictionary *goodsDic = dataArr[i];
        
        
        OrderModel *model = [[OrderModel alloc]init];
        
        model.time = [NSDate dateStrFromCstampTime:[goodsDic[@"createTime"] intValue] withDateFormat:@"YYYY-MM-dd"];
        model.payDic = [goodsDic mutableCopy];
        model.timeint = goodsDic[@"createTime"] ;

        model.ID = goodsDic[@"id"];
        NSDictionary *payMsgDic = [[Tool tools] dictionaryWithJsonString:goodsDic[@"payJson"]];
        NSArray *payMsgArr = payMsgDic[@"payMsg"];
        
        for (int j = 0; j < payMsgArr.count; j++) {
            NSDictionary *goodsDic = payMsgArr[j];
            GoodsModel *tempModel = [[GoodsModel alloc]init];
            tempModel.imgUrl = goodsDic[@"goodsSmallUrl"];
            tempModel.colorName = goodsDic[@"colorName"];
            tempModel.title =  goodsDic[@"goodsName"];
            tempModel.color =  goodsDic[@"goodsColor"];
            tempModel.type = goodsDic[@"goodsStyle"];
            tempModel.goodsId = goodsDic[@"goodsId"];
            tempModel.detailId = goodsDic[@"goodsColorStyleId"];
            tempModel.price = [Tool priceChange:goodsDic[@"price"]];
            tempModel.scalePrice = [Tool priceChange:goodsDic[@"price"]];
            tempModel.number =  goodsDic[@"goodsAmount"];
            
            
            CGFloat tempPrice = ([tempModel.price floatValue] * 100)/[tempModel.number floatValue];
            tempModel.scalePrice = [[NSString alloc]initWithFormat:@"%0.2f",tempPrice * 0.01];
            tempModel.price = [[NSString alloc]initWithFormat:@"%0.2f",tempPrice * 0.01];
            
            [model.goodsArr addObject:tempModel];
        }

        if ([goodsDic [@"showStatus"] intValue] == 1) {
            model.type = @"待付款";
        }else if ([goodsDic [@"showStatus"] intValue] == 2) {
            model.type = @"待发货";
        }else if ([goodsDic [@"showStatus"] intValue] == 4) {
            model.type = @"待评价";
        }else if ([goodsDic [@"showStatus"] intValue] == 5)
        {
            model.type = @"已完成";
        }else if ([goodsDic [@"showStatus"] intValue] == 6){
            model.type = @"待收货";
        }
        
        if ([model.type isEqualToString:@"待收货"]) {
            [self.tableViewDataArray addObject:model];
        }
    }
    [self changeArrayByArray:self.tableViewDataArray];

    [self.tableView reloadData];
}

//排序
-(void)changeArrayByArray:(NSMutableArray *)array
{
    
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        OrderModel *a = (OrderModel *)obj1;
        OrderModel *b = (OrderModel *)obj2;
        
        int aNum = [a.timeint intValue];
        int bNum = [b.timeint intValue];
        
        if (aNum > bNum) {
            return NSOrderedAscending;
        }
        else if (aNum < bNum){
            return NSOrderedDescending;
        }
        else {
            return NSOrderedSame;
        }
    }];
}


@end
