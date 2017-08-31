//
//  CPNCouponitemModel.h
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNBaseModel.h"

@interface CPNGetCouponitemModel : CPNBaseModel

/**
 优惠券id
 */
@property (nonatomic, copy) NSString        *id;

/**
 优惠券名称
 */
@property (nonatomic, copy) NSString        *name;

/**
 优惠券描述
 */
@property (nonatomic, copy) NSString        *desc;

/**
 可换积分
 */
@property (nonatomic, copy) NSString        *points;

/**
 门店id
 */
@property (nonatomic, copy) NSString        *shopId;

/**
 门店名称
 */
@property (nonatomic, copy) NSString        *shopName;

/**
 门店地址
 */
@property (nonatomic, copy) NSString        *shopAddr;
@property (nonatomic, copy) NSString        *shopStatus;
@property (nonatomic, copy) NSString        *shopPhone;
@property (nonatomic, copy) NSString        *shopUnionId;
@property (nonatomic, copy) NSString        *shopActive;


@property (nonatomic, assign) NSInteger     counts;

@property (nonatomic, assign) NSInteger     status;

/**
 已经领取的数量
 */
@property (nonatomic, assign) NSInteger     pick;

/**
 是否可以领取，默认为YES
 */
@property (nonatomic, assign) BOOL          isCanAccquire;

@end
