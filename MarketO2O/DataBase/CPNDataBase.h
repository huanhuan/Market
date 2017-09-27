//
//  CPNDataBase.h
//  
//
//  Created by CPN on 15/11/14.
//  Copyright © 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPNLoginUserInfoModel;
@class CPNConfigSettingModel;
@class CPNClientRegionModel;
@class CPNShopingCartItemModel;
@class CPNUserAddressInfoModel;

typedef NS_ENUM(int,CPNDataBaseValueType) {
    CPNDataBaseValueTypeString,
    CPNDataBaseValueTypeNSArry,
    CPNDataBaseValueTypeNSDictionary,
};

@interface CPNDataBase : NSObject

+ (CPNDataBase *) defaultDataBase;

/**
 *  设备deviceToken存储
 *
 *  @param deviceToken 推送token
 */
- (void)saveDevicePushToken:(NSString *)deviceToken;
- (NSString *)devicePushToken;

/**
 *  获取设备imei
 *
 *  @return 设备imei
 */
- (NSString *)deviceImei;



/**
 *  第一次启动之后存储标识
 */
- (void)setAppFirstStartUp;

/**
 *  判断是否是第一次启动app
 *
 *  @return BOOL
 */
- (BOOL)isFirstStartUp;


#pragma mark - 判断版本升级使用的（每次启动如果是新版本，保存当前版本号）
/**
 *  在新版本时，保存当前app的版本号
 */
- (void)saveNewAppVersion;


/**
 * 获取存储到本地的app版本信息
 *
 *  @return NSString
 */
- (NSString *)getAppVersion;

/**
 *  判断是否是新版本
 *
 *  @return BOOL
 */
- (BOOL)isAppNewVersion;


#pragma mark - 每次发生登录/注册/修改真实姓名等操作时，需要更新本地存储的登录用户信息
/**
 *  保存用户登录完成后的用户信息
 *
 *  @param userInfo 用户信息
 */
- (void)saveUserLoginInfo:(NSDictionary *)userInfo;
/**
 *  获取本地存储的用户信息
 *
 *  @return 返回本地存储的用户信息对象
 */
- (CPNLoginUserInfoModel *)userLoginInfo;
/**
 *  退出登录时清除本地存储的用户信息
 */
- (void)logoutUserAccount;


#pragma mark - 保存配置信息
/**
 *  保存配置信息
 *
 *  @param configInfo 用户信息
 */
- (void)saveConfigSettingInfo:(NSDictionary *)configInfo;
/**
 *  获取本地存储的配置信息
 *
 *  @return 返回本地存储的配置信息对象
 */
- (CPNConfigSettingModel *)configSettingInfo;

/**
 * 保存收获地址相关信息
 *
 *
 */
- (void)saveUserAddressInfo:(CPNUserAddressInfoModel *)useradressInfo;
/**
 *返回收获地址
 */
- (CPNUserAddressInfoModel *)getUserAddressInfo;

#pragma mark --------------------------------------------------- 华丽的分割线

#pragma mark - 加入购物车
/**
 添加商品到购物车
 
 @param item 需要添加的商品
 */
- (void)addProductionToShopCart:(CPNShopingCartItemModel *)item;

/**
 删除商品
 
 @param item 需要删除的商品
 */
- (void)deleteProductionFromShopCart:(CPNShopingCartItemModel *)item;

/**
 update商品信息
 
 @param item 更新商品
 */
- (void)updateProductionFromShopCart:(CPNShopingCartItemModel *)item;

/**
 获取购物车所有商品
 */

- (NSArray<CPNShopingCartItemModel*> *)getAllProductionInShopCart;

@end
