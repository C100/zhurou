//
//  BackProductApplyViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 2017/12/6.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "BackProductApplyViewController.h"
#import "BackProductTableView.h"
#import "BackProductInstructCell.h"
#import "ChooseCompanyViewController.h"

@interface BackProductApplyViewController ()<BackProductTableViewDelegate>

@property(nonatomic, strong) BackProductTableView *myTableView;
@property(nonatomic, strong) NSString *companyCode;

@end

@implementation BackProductApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退换货申请";
    
    self.myTableView = [[BackProductTableView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64-40)];
    self.myTableView.backProductTableViewDelegate = self;
    if (self.orderDetailModel.statusNum.intValue==2||self.type.intValue==2) {//换货或代发货
        self.myTableView.isNeedLogNum = NO;
    }else{
        self.myTableView.isNeedLogNum = YES;
    }
    self.myTableView.backPrice = self.backAllPrice;
    self.myTableView.goodsModel = self.goodsModel;
    [self.view addSubview:self.myTableView];
    
    UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myTableView.frame), KHScreenW, 40)];
    [self.view addSubview:submitButton];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.titleLabel.font = kFont(14);
    [submitButton setBackgroundColor:The_MainColor];
    [submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)chooseCompany{
    ChooseCompanyViewController *vc = [[ChooseCompanyViewController alloc]init];
    vc.callBack = ^(NSString *company, NSString *num) {
        self.companyCode = num;
        UITableViewCell *cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.detailTextLabel.text = company;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)submitAction{
//    NSMutableArray *goodsArr = [NSMutableArray array];
    NSDictionary *goodDic =@{@"goodsAmount":self.goodsModel.number,
                             @"goodsColor":self.goodsModel.color,
                             @"goodsId":self.goodsModel.goodsId,
                             @"goodsColorStyleId":self.goodsModel.detailId,
                             @"goodsStyle":self.goodsModel.type,
                             @"goodsName":self.goodsModel.title,
                             @"goodsSmallUrl":self.goodsModel.imgUrl,
                             @"colorName":self.goodsModel.colorName,
                             };
//    [goodsArr addObject:goodDic];
//    NSDictionary *praramDic = @{@"payMsg":goodsArr
//                                };
    NSString *jsonStr = [self ObjectTojsonString:goodDic];
    BackProductInstructCell *cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    int allPrice = _backAllPrice*100;
    NSDictionary *paramDic;
    NSString *reason = cell.myTextView.text;
    if (cell.myTextView.text==0) {
        reason = @"";
    }
    if (self.myTableView.isNeedLogNum==YES) {
        paramDic = @{@"receiptId":self.orderDetailModel.receiptId,
                     @"waybillNumber":@(10),
                     @"payMsg":jsonStr,
                     @"refundReason":reason,
                     @"type":self.type,
                     @"money":@(allPrice),
                     @"companyNo":self.companyCode
                     };
    }else{
        paramDic = @{@"receiptId":self.orderDetailModel.receiptId,
                     @"payMsg":jsonStr,
                     @"refundReason":reason,
                     @"type":self.type,
                     @"money":@(allPrice)
                     };
    }
    
    [HttpRequestManager postBackProductRequest:paramDic viewcontroller:self finishBlock:^(NSDictionary *data) {
        //成功
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(NSString*)ObjectTojsonString:(id)object

{
    
    NSString *jsonString = [[NSString alloc]init];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                        
                                                       options:NSJSONWritingPrettyPrinted
                        
                                                         error:&error];
    
    if (! jsonData) {
        
        NSLog(@"error: %@", error);
        
    } else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}


@end
