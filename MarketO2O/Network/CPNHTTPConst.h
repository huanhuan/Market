//
//  CPNHTTPConst.h
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#ifndef CPNHTTPConst_h
#define CPNHTTPConst_h


#define STATIC_STRING(A) static NSString * const A =
#pragma mark - method

STATIC_STRING(API_TEST_URL)                     @"http://112.74.56.142";
//STATIC_STRING(API_TEST_URL)                     @"http://192.168.2.13";


STATIC_STRING(API_URL)                          @"http://112.74.56.142";
//STATIC_STRING(API_URL)                          @"http://192.168.2.13";


#pragma mark - path
//coupons
/**
 用户登录注册请求路由

 @return
 */
#define PATH_USER_REGISTER                      @"/coupons/v1/user/register.do"
/**
 获取用户优惠券列表接口路由
 
 @return
 */
#define PATH_USER_GETCOUPONORDERLIST           @"/coupons/v1/user/getcouponorderlist.do"

/**
 领取优惠券接口路由
 
 @return
 */
#define PATH_USER_PICKCOUPON                   @"/coupons/v1/user/pickcoupon.do"

/**
 兑换商品接口路由

 @return
 */
#define PATH_USER_EXCHANGEGOODS                @"/coupons/v1/user/exchangegoods.do"


/**
 获取用户订单列表请求接口
 
 @return
 */
#define PATH_USER_GETGOODSORDERLIST             @"/coupons/v1/user/getgoodsorderlist.do"

/**
 获取用户详细信息
 
 @return
 */
#define PATH_USER_GETUSERINFO           @"/coupons/v1/user/getuserinfo.do"

/**
 获取可领取的优惠券列表接口路由

 @return
 */
#define PATH_COUPONINFO_GETCOUPONLIST          @"/coupons/v1/couponInfo/getcouponlist.do"


/**
 首页热门商品列表请求路由
 
 @return
 */
#define PATH_GOODSINFO_GETHOTGOODSLIST          @"/coupons/v1/goodsInfo/gethotgoodslist.do"

/**
 获取商品类别列表路由
 
 @return
 */
#define PATH_GOODSINFO_GETGOODSTYPE             @"/coupons/v1/goodsInfo/getgoodstype.do"


/**
 获取某一个类别下面的商品列表路由
 
 @return
 */
#define PATH_GOODSINFO_GETGOODSBYTYPE           @"/coupons/v1/goodsInfo/gethotgoodsbytype.do"

/**
 获取商品的详情数据接口路由
 
 @return
 */
#define PATH_GOODSINFO_GETGOODSDETAIL           @"/coupons/v1/goodsInfo/getgoodsdetail.do"

/**
 获取商铺的信息
 
 @return
 */
#define PATH_SHOP_INFO                          @"/coupons/v1/goodsInfo/getgoodsdetail.do"

#endif
