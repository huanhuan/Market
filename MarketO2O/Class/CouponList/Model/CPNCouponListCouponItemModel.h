//
//  CPNCouponListCouponItemModel.h
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNBaseModel.h"

@interface CPNCouponListCouponItemModel : CPNBaseModel


/**
 优惠券id
 */
@property (nonatomic, copy) NSString        *id;

@property (nonatomic, copy) NSString        *couponId;
/**
 优惠券名称
 */
@property (nonatomic, copy) NSString        *couponName;

/**
 优惠券描述
 */
@property (nonatomic, copy) NSString        *couponDescription;
/**
 优惠码
 */
@property (nonatomic, copy) NSString        *code;

/**
 可换积分
 */
@property (nonatomic, copy) NSString        *couponPoints;

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
@property (nonatomic, copy) NSString        *shopActive;

@property (nonatomic, copy) NSString        *userId;

@property (nonatomic, assign) NSInteger     couponCounts;

@property (nonatomic, assign) NSInteger     status;
/**
 已经领取的数量
 */
@property (nonatomic, assign) NSInteger     copuonPick;

@end
