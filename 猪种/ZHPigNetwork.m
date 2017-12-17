//
//  ZHPigNetwork.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigNetwork.h"
#import "ZHPigInfoModel.h"
#import "ZHPigOrderModel.h"
#import "ZHPigBuyModel.h"
#import "ZHPigMyOrderModel.h"
#import "ZHPigPayModel.h"

@implementation ZHPigNetwork

- (void)getPigInfoWithCallback:(ZHBaseNetworkCallback)callback {
    [self POST:S_HOST_URL(@"pigSpecies/getPig.do") parameters:nil compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            ZHPigInfoModel *model = [[ZHPigInfoModel alloc] initWithDictionary:obj];
            if (callback) {
                callback (YES, message, model, code);
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];
}

- (void)realNameAuthWithName:(NSString *)name IDCard:(NSString *)IDCard callback:(ZHBaseNetworkCallback)callback {

    NSDictionary *parameters = @{ @"userRealName" : TO_SAFE_STR(name),
                                  @"idCard" : TO_SAFE_STR(IDCard), };

    [self POST:S_HOST_URL(@"pigSpecies/authentication.do") parameters:parameters compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            NSString *contractURL = @"";
            if ([obj isKindOfClass:[NSString class]]) {
                contractURL = obj;
            }
            if (callback) {
                callback (YES, message, contractURL, code);
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];
}

- (void)checkNeedRealNameAuthWithCallback:(ZHBaseNetworkCallback)callback {
    [self POST:S_HOST_URL(@"pigSpecies/confirmOrder.do") parameters:nil compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            if (callback) {
                callback (YES, message, obj, code);
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];
}

- (void)getOrderInfoWithGoodsId:(NSNumber *)goodsId callback:(ZHBaseNetworkCallback)callback {
    
    NSDictionary *parameters = @{ @"goodsId" : goodsId ? goodsId : @(0) };

    [self POST:S_HOST_URL(@"pigSpecies/getOrderInfo.do") parameters:parameters compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            ZHPigOrderModel *model = [[ZHPigOrderModel alloc] initWithDictionary:obj];
            if (callback) {
                callback (YES, message, model, code);
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];

}

- (void)uploadOrderPigBuyModel:(ZHPigBuyModel *)pigBuyModel addressModel:(AddressModel *)addressModel invoice:(NSString *)invoice payType:(NSNumber *)payType callback:(ZHBaseNetworkCallback)callback {
    NSDictionary *parameters = @{ @"pigId" : pigBuyModel.pigId,
                                  @"count" : @(pigBuyModel.buyCount),
                                  @"invoice" : TO_SAFE_STR(invoice),
                                  @"batch" : pigBuyModel.batch,
                                  @"term" : pigBuyModel.term,
                                  @"price" : @(pigBuyModel.pigPrice),
                                  @"address" : [NSString stringWithFormat:@"%@%@",TO_SAFE_STR(addressModel.address), TO_SAFE_STR(addressModel.detailAddress)],
                                  @"name" : TO_SAFE_STR(addressModel.title),
                                  @"phone" : TO_SAFE_STR(addressModel.phone),
                                  @"payMethod" : payType ? payType : @(1),
                                  };

    [self POST:S_HOST_URL(@"pigSpecies/submitOrder.do") parameters:parameters compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            ZHPigPayModel *payModel = [[ZHPigPayModel alloc] initWithDictionary:obj];
            if (callback) {
                callback (YES, message, payModel, code);
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];
}

- (void)getOrderToBePaidWithCallback:(ZHBaseNetworkCallback)callback {
    [self POST:S_HOST_URL(@"pigSpecies/noPayOrders.do") parameters:nil compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            ZHPigMyOrderModel *myOrderModel = [[ZHPigMyOrderModel alloc] initWithDictionary:obj];
            if (callback) {
                callback (YES, message, myOrderModel, code);
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];
}

- (void)cancelOrderWithOrderId:(NSNumber *)orderId callback:(ZHBaseNetworkCallback)callback {
    if (!orderId) {
        return;
    }
    NSDictionary *parameters = @{ @"id" : orderId };

    [self POST:S_HOST_URL(@"pigSpecies/deleteOrder.do") parameters:parameters compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            if (callback) {
                callback (YES, message, obj, code);
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];
}

- (void)deleteOrderWithOrderId:(NSNumber *)orderId callback:(ZHBaseNetworkCallback)callback {
    if (!orderId) {
        return;
    }
    NSDictionary *parameters = @{ @"id" : orderId };

    [self POST:S_HOST_URL(@"pigSpecies/del.do") parameters:parameters compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            if (callback) {
                callback (YES, message, obj, code);
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];
}

- (void)payOrderToBePaidWithMyOrderModel:(ZHPigMyOrderModel *)myOrderModel payType:(NSNumber *)payType callback:(ZHBaseNetworkCallback)callback {
    NSDictionary *parameters = @{ @"orderId" : myOrderModel.orderId,
                                  @"realName" : myOrderModel.realName,
                                  @"totalPrice" : myOrderModel.totalPrice,
                                  @"payMethod" : payType,};

    [self POST:S_HOST_URL(@"pigSpecies/rePay.do") parameters:parameters compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            ZHPigPayModel *payModel = [[ZHPigPayModel alloc] initWithDictionary:obj];
            if (callback) {
                callback (YES, message, payModel, code);
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];
}

- (void)paySucceededWithOrderId:(NSNumber *)orderId callback:(ZHBaseNetworkCallback)callback {
    if (!orderId) {
        return;
    }
    NSDictionary *parameters = @{ @"id" : orderId };

    [self POST:S_HOST_URL(@"pigSpecies/finishOrder.do") parameters:parameters compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (status) {
            if (callback) {
                callback (YES, message, obj, code);
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];
}

- (void)versionDetectionWithCallback:(ZHBaseNetworkCallback)callback {
    [self POST:S_HOST_URL(@"appVersion/versionCheck.do") parameters:nil compeletion:^(BOOL status, NSString *message, id obj, NSString *code) {
        if (obj) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary *)obj;
                NSString *appStoreURLString = DICT_ATTRIBUTE_FOR_KEY(dict, @"iosUpgradeAddress");
                if (appStoreURLString.length > 0) {
                    if (callback) {
                        callback (YES, message, appStoreURLString, code);
                    }
                } else {
                    if (callback) {
                        callback (NO, message, obj, code);
                    }
                }
            }
        } else {
            if (callback) {
                callback (NO, message, obj, code);
            }
        }
    }];
}

@end
