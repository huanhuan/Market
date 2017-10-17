//
//  CPNHTTPClient.m
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNHTTPClient.h"
#import "CPNHTTPConst.h"
#import "CPNHTTPAgent.h"
#import "CPNRequestKeys.h"
#import "NSString+Md5.h"
#import "CPNRequest.h"
#import "CPNError.h"
#import "NSString+Jason.h"

#import "CPNLoginUserInfoModel.h"
#import "CPNHomePageProductItemModel.h"
#import "CPNPointsMarketCategoryModel.h"
#import "CPNOrderListItemModel.h"
#import "CPNCouponListCouponItemModel.h"
#import "CPNGetCouponitemModel.h"
#import "CPNConfigSettingModel.h"
#import "CPNShopInfoModel.h"
#import "CPNContractModel.h"


@implementation CPNHTTPClient

static CPNHTTPClient * __clientInstance = NULL;

+ (instancetype)instanceClient {
    if (!__clientInstance)
        __clientInstance = [[CPNHTTPClient alloc] init];
    return __clientInstance;
}


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
                  completeBlock:(void (^)(CPNLoginUserInfoModel *infoModel, CPNError *error))completeBlock{
    //test
    //    unionId = @"okJpF1YZjPRmTMYnQVlP907_Vk3o";
    //    nickName = @"彭欢欢";
    //    headerImage = @"http://wx.qlogo.cn/mmopen/6FgXKUpiblt4Q8SxeaPagJIiccRuJdyPwsgwqB54fE2YT6w4cT7K2KNk9jsWzYUicUqXBYQd4KfFfJLmkLzGDibdKqs1ibIDqpzey/0";
    
    
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setString:unionId forKey:PARAM_KEY_UNIONID];
    [request setString:nickName forKey:PARAM_KEY_NICKNAME];
    [request setString:headerImage forKey:PARAM_KEY_HEADIMGURL];
    //    ////test
    //    [request setString:@"okJpF1YZjPRmTMYnQVlP907_Vk3o" forKey:PARAM_KEY_UNIONID];
    //    [request setString:@"彭欢欢" forKey:PARAM_KEY_NICKNAME];
    //    [request setString:@"http://wx.qlogo.cn/mmopen/6FgXKUpiblt4Q8SxeaPagJIiccRuJdyPwsgwqB54fE2YT6w4cT7K2KNk9jsWzYUicUqXBYQd4KfFfJLmkLzGDibdKqs1ibIDqpzey/0" forKey:PARAM_KEY_HEADIMGURL];
    [request setString:[[NSString stringWithFormat:@"%@ywdXLFeMJ48bAX8", unionId] md5HexDigest] forKey:PARAM_KEY_SIGN];
    
    
    
    [request setRequestPath:PATH_USER_REGISTER];
    [request setRequestMethod:CPN_REQUEST_METHOD_POST];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
#pragma mark 1.0
            //            NSMutableDictionary *userinfo = [NSMutableDictionary new];
            //            [userinfo setValue:unionId forKey:@"unionId"];
            //            [userinfo setValue:headerImage forKey:@"headimgurl"];
            //            [userinfo setValue:nickName forKey:@"nickname"];
            //            [[CPNDataBase defaultDataBase] saveUserLoginInfo:userinfo];
            //
            //            CPNLoginUserInfoModel *infoModel = [CPNLoginUserInfoModel mj_objectWithKeyValues:userinfo];
            //            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            //            delegate.loginUserModel = infoModel;
            //            completeBlock(infoModel,nil);
            //
            
#pragma mark 2.0  --这个接口直接返回用户信息
            response.respBody = [NSString dictionaryWithJsonString:response.respBody];
            if (response.respBody && [response.respBody isKindOfClass:[NSDictionary class]]) {
                CPNLoginUserInfoModel *infoModel = [CPNLoginUserInfoModel mj_objectWithKeyValues:response.respBody];
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                delegate.loginUserModel = infoModel;
                completeBlock(infoModel,nil);
            }
            else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock];
}


#pragma mark - 请求首页热门商品列表接口
/**
 请求首页热门商品列表接口
 
 @param page 分页页码
 @param isNeedLoading 是否显示加载状态
 @param completeBlock 请求完成回调
 */
- (void)requestHomePageHotProductWithPage:(NSInteger)page
                            isNeedLoading:(BOOL)isNeedLoading
                            completeBlock:(void (^)(NSArray *productList, CPNError *error))completeBlock{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setInt:page forKey:PARAM_KEY_PAGE];
    
    [request setRequestPath:PATH_GOODSINFO_GETHOTGOODSLIST];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSArray class]]) {
                NSArray *productArray = [CPNHomePageProductItemModel mj_objectArrayWithKeyValuesArray:response.respBody];
                completeBlock(productArray,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock
                             isNeedShowLoading:isNeedLoading];
}

/**
 请求搜索结果
 @param keyString 关键字
 @param completeBlock 请求完成回调
 */
- (void)requestSearchProductWithKeyString:(NSString *)keyString
                            completeBlock:(void (^)(NSArray *searchProductList, CPNError *error))completeBlock
{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setString:keyString forKey:PARAM_KEY_SEARCH_KEY];
    
    [request setRequestPath:PATH_SEARCH_PRODUCT];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSArray class]]) {
                NSArray *productArray = [CPNHomePageProductItemModel mj_objectArrayWithKeyValuesArray:response.respBody];
                completeBlock(productArray,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock
                             isNeedShowLoading:YES];
}

#pragma mark -请求用户详细信息---主要是积分
- (void)requestUserInfoWithUnionId:(CPNLoginUserInfoModel *)userLoginInfo
                     completeBlock:(void(^)(CPNLoginUserInfoModel *infoModel, CPNError *error))completeBlock
{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setString:userLoginInfo.unionId forKey:PARAM_KEY_UNIONID];
    [request setRequestPath:PATH_USER_GETUSERINFO];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil, error);
        }else
        {
            if (response.respBody && [response.respBody isKindOfClass:[NSDictionary class]]) {
                ///只取积分
                userLoginInfo.points = [[response.respBody objectForKey:@"points"] longValue];
                [[CPNDataBase defaultDataBase] saveUserLoginInfo:response.respBody];
                completeBlock(userLoginInfo, nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
            
        }
    };
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock
                             isNeedShowLoading:NO];
}


#pragma mark - 请求商品类别列表接口
/**
 请求商品类别列表接口
 
 @param completeBlock 请求完成回调
 */
- (void)requestProductCategoryListWithCompleteBlock:(void (^)(NSArray *categoryList, CPNError *error))completeBlock{
    CPNRequest *request = [[CPNRequest alloc] init];
    
    [request setRequestPath:PATH_GOODSINFO_GETGOODSTYPE];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSArray class]]) {
                NSArray *categoryArray = [CPNPointsMarketCategoryModel mj_objectArrayWithKeyValuesArray:response.respBody];
                completeBlock(categoryArray,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock];
}


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
                           completeBlock:(void (^)(NSArray *productList, CPNError *error))completeBlock{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setString:categoryId forKey:PARAM_KEY_TYPE];
    [request setInt:page forKey:PARAM_KEY_PAGE];
    
    [request setRequestPath:PATH_GOODSINFO_GETGOODSBYTYPE];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSArray class]]) {
                NSArray *productArray = [CPNHomePageProductItemModel mj_objectArrayWithKeyValuesArray:response.respBody];
                completeBlock(productArray,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock
                             isNeedShowLoading:isNeedLoading];
}


#pragma mark - 请求商品详情数据接口
/**
 请求商品详情数据接口
 
 @param productId 商品id
 @param completeBlock 请求完成回调
 */
- (void)requestProductDetailInfoWithProductId:(NSString *)productId
                               completebBlock:(void (^)(CPNHomePageProductItemModel *productModel, CPNError *error))completeBlock{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setString:productId forKey:PARAM_KEY_ID];
    
    [request setRequestPath:PATH_GOODSINFO_GETGOODSDETAIL];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSDictionary class]]) {
                CPNHomePageProductItemModel *infoModel = [CPNHomePageProductItemModel mj_objectWithKeyValues:response.respBody];
                completeBlock(infoModel,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock];
}


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
                         completeBlock:(void (^)(NSArray *orderList, CPNError *error))completeBlock{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setInt:status forKey:PARAM_KEY_STATUS];
    [request setInt:page forKey:PARAM_KEY_PAGE];
    
    [request setRequestPath:PATH_USER_GETGOODSORDERLIST];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSArray class]]) {
                NSArray *orderArray = [CPNOrderListItemModel mj_objectArrayWithKeyValuesArray:response.respBody];
                completeBlock(orderArray,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock
                             isNeedShowLoading:isNeedLoading];
}


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
                          completeBlock:(void (^)(NSArray *couponList, CPNError *error))completeBlock{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setInt:status forKey:PARAM_KEY_STATUS];
    [request setInt:page forKey:PARAM_KEY_PAGE];
    
    [request setRequestPath:PATH_USER_GETCOUPONORDERLIST];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSArray class]]) {
                NSArray *couponArray = [CPNCouponListCouponItemModel mj_objectArrayWithKeyValuesArray:response.respBody];
                completeBlock(couponArray,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock
                             isNeedShowLoading:isShowLoading];
}



#pragma mark - 可领取的优惠券列表请求接口

/**
 可领取的优惠券列表请求接口
 
 @param page 分页页码
 @param completeBlock 请求完成回调
 */
- (void)requestAccquireCouponListWithPage:(NSInteger)page
                            isNeedLoading:(BOOL)isNeedLoading
                            completeBlock:(void (^)(NSArray *couponList, CPNError *error))completeBlock{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setInt:page forKey:PARAM_KEY_PAGE];
    
    [request setRequestPath:PATH_COUPONINFO_GETCOUPONLIST];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSArray class]]) {
                NSArray *couponArray = [CPNGetCouponitemModel mj_objectArrayWithKeyValuesArray:response.respBody];
                completeBlock(couponArray,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock
                             isNeedShowLoading:isNeedLoading];
}

#pragma mark  获取商铺的信息
/**
 获取商铺的信息
 
 @param shopId 商铺的id
 @param completeBlock 请求完成回调
 */
- (void)requestShopInfoWithShopId:(NSString *)shopId
                    completeBlock:(void (^)(CPNShopInfoModel *shopInfo, CPNError *error))completeBlock
{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setString:shopId forKey:PARAM_KEY_SHOP_ID];
    
    [request setRequestPath:PATH_SHOP_INFO];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSArray class]]) {
                CPNShopInfoModel *shopModel = [CPNShopInfoModel mj_objectWithKeyValues:response.respBody];
                completeBlock(shopModel,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock
     ];
}

#pragma mark  获取商铺的电子合同
/**
 获取商铺的电子合同
 
 @param completeBlock 请求完成回调
 */
- (void)requestContractWithCompleteBlock:(void (^)(NSArray *Contracts, CPNError *error))completeBlock
{
    CPNRequest *request = [[CPNRequest alloc] init];
    
    [request setRequestPath:PATH_GET_ALL_CONTRACT];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSArray class]]) {
                NSArray *contractArray = [CPNContractModel mj_objectArrayWithKeyValuesArray:response.respBody];
                completeBlock(contractArray,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock
     ];
}

#pragma mark - 领取优惠券接口
/**
 领取优惠券接口
 
 @param couponId 优惠券id
 @param completeBlock 请求完成回调
 */
- (void)requestAccquireCouponWithCounponId:(NSString *)couponId
                             completeBlock:(CPNHTTPCompleteBlock)completeBlock{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setString:couponId forKey:PARAM_KEY_COUPONID];
    
    [request setRequestPath:PATH_USER_PICKCOUPON];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:completeBlock];
}

#pragma mark 上传签名后的电子图片
/**
 @param image 上传的图片
 @param completeBlock 请求完成回调
 */
- (void)requestUploadContractImage:(UIImage *)image
                            shopId:(NSString *)shopId
                     completeBlock:(void (^)(BOOL status, CPNError *error))completeBlock
{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setString:shopId forKey:PARAM_KEY_SHOP_ID];
    
    [request setRequestPath:PATH_UPDATE_CONTRACT];
    
    [request setRequestMethod:CPN_REQUEST_METHOD_POST];
    request.pictureData = UIImagePNGRepresentation(image);
    request.requestImageKey = [NSString stringWithFormat:@"%ld",image.hash];
    //    [request setima]
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            completeBlock(YES, nil);
        }
    };
    [[CPNHTTPAgent instanceAgent] startUploadPicture:request
                                            response:finishBlock
     ];
//    [[CPNHTTPAgent instanceAgent] startRequest:request
//                                      response:finishBlock
//     ];
}

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
                         completeBlock:(CPNHTTPCompleteBlock)completeBlock{
    CPNRequest *request = [[CPNRequest alloc] init];
    [request setString:productId forKey:PARAM_KEY_GOODSID];
    [request setString:name forKey:PARAM_KEY_NAME];
    [request setString:phone forKey:PARAM_KEY_PHONE];
    [request setString:address forKey:PARAM_KEY_ADDR];
    
    [request setRequestPath:PATH_USER_EXCHANGEGOODS];
    [request setRequestMethod:CPN_REQUEST_METHOD_POST];
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:completeBlock];
}


#pragma mark - 请求配置信息接口
/**
 请求配置信息接口
 
 @param completeBlock 请求完成回调
 */
- (void)requestConfigSettingInfoWithCompleteBlock:(void (^)(CPNConfigSettingModel *infoModel, CPNError *error))completeBlock{
    CPNRequest *request = [[CPNRequest alloc] init];
    //TODO:路由
    [request setRequestPath:nil];
    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
    CPNHTTPCompleteBlock finishBlock = ^(CPNResponse *response, CPNError *error) {
        if (error) {
            completeBlock(nil,error);
        }else{
            if (response.respBody && [response.respBody isKindOfClass:[NSDictionary class]]) {
                [[CPNDataBase defaultDataBase] saveConfigSettingInfo:response.respBody];
                CPNConfigSettingModel *infoModel = [CPNConfigSettingModel mj_objectWithKeyValues:response.respBody];
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                delegate.configModel = infoModel;
                completeBlock(infoModel,nil);
            }else{
                CPNError *error = [[CPNError alloc] init];
                error.errorCode = CPNErrorTypeDataParaseError;
                error.errorMessage = CPNErrorMessageDataParaseError;
                completeBlock(nil,error);
            }
        }
    };
    
    [[CPNHTTPAgent instanceAgent] startRequest:request
                                      response:finishBlock
                             isNeedShowLoading:NO];
}

@end
