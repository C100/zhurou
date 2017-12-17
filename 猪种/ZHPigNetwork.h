//
//  ZHPigNetwork.h
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/12.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHBaseNetwork.h"

@class ZHPigBuyModel;
@class AddressModel;
@class ZHPigMyOrderModel;
@interface ZHPigNetwork : ZHBaseNetwork

/**
 *  获取猪种信息
 */
- (void)getPigInfoWithCallback:(ZHBaseNetworkCallback)callback;
/**
 *  实名认证
 */
- (void)realNameAuthWithName:(NSString *)name IDCard:(NSString *)IDCard callback:(ZHBaseNetworkCallback)callback;
/**
 *  检测是否需要实名认证和是否有未支付的订单
 */
- (void)checkNeedRealNameAuthWithCallback:(ZHBaseNetworkCallback)callback;
/**
 *  订单填写页面获取订单信息
 */
- (void)getOrderInfoWithGoodsId:(NSNumber *)goodsId callback:(ZHBaseNetworkCallback)callback;
/**
 *  取消订单
 */
- (void)cancelOrderWithOrderId:(NSNumber *)orderId callback:(ZHBaseNetworkCallback)callback;
/**
 *  删除订单
 */
- (void)deleteOrderWithOrderId:(NSNumber *)orderId callback:(ZHBaseNetworkCallback)callback;
/**
 *  上传订单
 */
- (void)uploadOrderPigBuyModel:(ZHPigBuyModel *)pigBuyModel addressModel:(AddressModel *)addressModel invoice:(NSString *)invoice payType:(NSNumber *)payType callback:(ZHBaseNetworkCallback)callback;
/**
 *  获取未完成订单
 */
- (void)getOrderToBePaidWithCallback:(ZHBaseNetworkCallback)callback;
/**
 *  未完成订单页面去支付
 */
- (void)payOrderToBePaidWithMyOrderModel:(ZHPigMyOrderModel *)myOrderModel payType:(NSNumber *)payType callback:(ZHBaseNetworkCallback)callback;
/**
 *  上传支付成功信息
 */
- (void)paySucceededWithOrderId:(NSNumber *)orderId callback:(ZHBaseNetworkCallback)callback;

/**
 *  版本检测
 */
- (void)versionDetectionWithCallback:(ZHBaseNetworkCallback)callback;

@end
