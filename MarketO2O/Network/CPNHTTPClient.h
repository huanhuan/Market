//
//  CPNHTTPClient.h
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPNResponse.h"

@class CPNError;
@class CPNLoginUserInfoModel;
@class CPNHomePageProductItemModel;
@class CPNShopInfoModel;


@interface CPNHTTPClient : NSObject

+ (instancetype)instanceClient;

#pragma mark - 登录注册请求接口
/**
 登录注册请求接口
 
 @param unionId 微信登录后的unionId
 @param nickName 微信登录获取到的用户名
 @param headerImage 微信登录获取到的头像地址
 @param completeBlock 请求完成回调
 */
- (void)requestLoginWithUnionId:(NSString *)unionId
                       nickName:(NSString *)nickName
                    headerImage:(NSString *)headerImage
                  completeBlock:(void (^)(CPNLoginUserInfoModel *infoModel, CPNError *error))completeBlock;

/**
 获取用户信息接口
 
 @param userLoginInfo 用户登录信息
 @completeBlock 请求完成回调
 */
- (void)requestUserInfoWithUnionId:(CPNLoginUserInfoModel *)userLoginInfo
                     completeBlock:(void(^)(CPNLoginUserInfoModel *infoModel, CPNError *error))completeBlock;

#pragma mark - 请求首页热门商品列表接口
/**
 请求首页热门商品列表接口
 
 @param page 分页页码
 @param completeBlock 请求完成回调
 */
- (void)requestHomePageHotProductWithPage:(NSInteger)page
                            isNeedLoading:(BOOL)isNeedLoading
                            completeBlock:(void (^)(NSArray *productList, CPNError *error))completeBlock;

/**
 请求搜索结果
 @param keyString 关键字
 @param completeBlock 请求完成回调
 */
- (void)requestSearchProductWithKeyString:(NSString *)keyString
                            completeBlock:(void (^)(NSArray *searchProductList, CPNError *error))completeBlock;

#pragma mark - 请求商品类别列表接口
/**
 请求商品类别列表接口
 
 @param completeBlock 请求完成回调
 */
- (void)requestProductCategoryListWithCompleteBlock:(void (^)(NSArray *categoryList, CPNError *error))completeBlock;

#pragma mark - 获取某一类别下面的商品列表接口
/**
 获取某一类别下面的商品列表接口
 
 @param categoryId 类别id
 @param page 页码
 @param completeBlock 请求完成回调
 */
- (void)requestTypeProductWithCategoryId:(NSString *)categoryId
                                    page:(NSInteger)page
                           isNeedLoading:(BOOL)isNeedLoading
                           completeBlock:(void (^)(NSArray *productList, CPNError *error))completeBlock;

#pragma mark - 请求商品详情数据接口
/**
 请求商品详情数据接口
 
 @param productId 商品id
 @param completeBlock 请求完成回调
 */
- (void)requestProductDetailInfoWithProductId:(NSString *)productId
                               completebBlock:(void (^)(CPNHomePageProductItemModel *productModel, CPNError *error))completeBlock;

#pragma mark - 请求用户订单列表接口
/**
 请求用户订单列表接口
 
 @param status 订单状态，0：全部订单，1：待付款订单，2：待收货订单，3：售后订单
 @param page 分页页码
 @param completeBlock 请求完成回调
 */
- (void)requestUserOrderListWithStatus:(NSInteger)status
                                  page:(NSInteger)page
                         isNeedLoading:(BOOL)isNeedLoading
                         completeBlock:(void (^)(NSArray *orderList, CPNError *error))completeBlock;


#pragma mark - 请求用户优惠券列表接口
/**
 请求用户优惠券列表接口
 
 @param status 优惠券状态，0：已领取，1：已使用
 @param page 分页页码
 @param isShowLoading 是否显示加载状态
 @param completeBlock 请求完成回调
 */
- (void)requestUserCouponListWithStatus:(NSInteger)status
                                   page:(NSInteger)page
                          isShowLoading:(BOOL)isShowLoading
                          completeBlock:(void (^)(NSArray *couponList, CPNError *error))completeBlock;


#pragma mark - 可领取的优惠券列表请求接口

/**
 可领取的优惠券列表请求接口
 
 @param page 分页页码
 @param completeBlock 请求完成回调
 */
- (void)requestAccquireCouponListWithPage:(NSInteger)page
                            isNeedLoading:(BOOL)isNeedLoading
                            completeBlock:(void (^)(NSArray *couponList, CPNError *error))completeBlock;

#pragma mark  获取商铺的信息
/**
 获取商铺的信息
 
 @param shopId 商铺的id
 @param completeBlock 请求完成回调
 */
- (void)requestShopInfoWithShopId:(NSString *)shopId
                    completeBlock:(void (^)(CPNShopInfoModel *shopInfo, CPNError *error))completeBlock;

#pragma mark  获取商铺的电子合同
/**
 获取商铺的电子合同
 
 @param shopId 商铺的id
 @param completeBlock 请求完成回调
 */
- (void)requestContractWithShopId:(NSString *)shopId
                    completeBlock:(void (^)(NSString *ContractImageUrl, CPNError *error))completeBlock;

#pragma mark 上传签名后的电子图片
/**
 @param image 上传的图片
 @param completeBlock 请求完成回调
 */
- (void)requestUploadContractImage:(UIImage *)image
                            shopId:(NSString *)shopId
                     completeBlock:(void (^)(BOOL status, CPNError *error))completeBlock;

#pragma mark - 领取优惠券接口
/**
 领取优惠券接口
 
 @param couponId 优惠券id
 @param completeBlock 请求完成回调
 */
- (void)requestAccquireCouponWithCounponId:(NSString *)couponId
                             completeBlock:(CPNHTTPCompleteBlock)completeBlock;

#pragma mark - 兑换商品请求接口
/**
 兑换商品请求接口
 
 @param productId 商品id
 @param name 收货人姓名
 @param phone 收货人电话
 @param address 收货人地址
 @param completeBlock 请求完成回调
 */
- (void)requestBuyProductWithProductId:(NSString *)productId
                                  name:(NSString *)name
                                 phone:(NSString *)phone
                               address:(NSString *)address
                         completeBlock:(CPNHTTPCompleteBlock)completeBlock;


#pragma mark - 请求配置信息接口
/**
 请求配置信息接口
 
 @param completeBlock 请求完成回调
 */
- (void)requestConfigSettingInfoWithCompleteBlock:(void (^)(CPNConfigSettingModel *infoModel, CPNError *error))completeBlock;

@end
