//
//  CPNOrderListItemModel.h
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNBaseModel.h"

@interface CPNOrderListItemModel : CPNBaseModel

/**
 订单id
 */
@property (nonatomic, copy) NSString    *id;
/**
 订单花费的积分
 */
@property (nonatomic, copy) NSString    *points;

/**
 商品图片地址
 */
@property (nonatomic, copy) NSString    *goodsImageurl;

@property (nonatomic, copy) NSString    *goodsId;
@property (nonatomic, copy) NSString    *goodsName;
@property (nonatomic, copy) NSString    *goosStar;
@property (nonatomic, copy) NSString    *goodsDescription;
@property (nonatomic, assign) NSInteger goodsStatus;

/**
 门店信息
 */
@property (nonatomic, copy) NSString    *shopAddr;

@property (nonatomic, copy) NSString    *shopName;

@property (nonatomic, copy) NSString    *shopPhone;

@property (nonatomic, assign) NSInteger shopActive;

@property (nonatomic, assign) NSInteger shopStatus;


@property (nonatomic, copy) NSString    *orderSn;
/**
 收货人
 */
@property (nonatomic, copy) NSString    *name;

/**
 收货人手机号
 */
@property (nonatomic, copy) NSString    *phone;

/**
 收货地址
 */
@property (nonatomic, copy) NSString    *addr;


@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString    *userId;

/**
 订单物流号
 */
@property (nonatomic, copy)NSString *waybillNumber;

@end
