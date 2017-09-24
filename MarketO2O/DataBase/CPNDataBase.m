//
//  CPNDataBase.m
//  
//
//  Created by CPN on 15/11/14.
//  Copyright © 2015年 . All rights reserved.
//

#import "CPNDataBase.h"
#import "AppDelegate.h"
#import "FMDB.h"
#import "CPNDataBaseManager.h"
#import "CPNLoginUserInfoModel.h"
#import "CPNConfigSettingModel.h"
#import "CPNShopingCartItemModel.h"

#define CPN_COMMON_SETTING_TABLE @"CPNCommonSetting"

#define CPN_SHOPING_CART_PRODUCTION_INFOS @"CPNShopingCartProductionInfos"

@implementation CPNDataBase

static CPNDataBase * _sharedDataBase;

+ (CPNDataBase *) defaultDataBase {
    if (!_sharedDataBase) {
        _sharedDataBase = [[CPNDataBase alloc] init];
        NSString * sql = [NSString stringWithFormat:@"create table if not exists %@ (key VARCHAR UNIQUE, value VARCHAR, valueType INTEGER)",CPN_COMMON_SETTING_TABLE];
        BOOL res = [CPNDataBaseManager executeUpdate:sql];
        if (res) {
            NSLog(@"创建表执行成功");
        }else{
            NSLog(@"创建表执行失败");
        }
        
        NSString * sqlShopingCart = [NSString stringWithFormat:@"create table if not exists %@ (key VARCHAR UNIQUE, value VARCHAR, valueType INTEGER)",CPN_SHOPING_CART_PRODUCTION_INFOS];
        BOOL resShopingCart = [CPNDataBaseManager executeUpdate:sqlShopingCart];
        if (resShopingCart) {
            NSLog(@"创建购物车表执行成功");
        }else{
            NSLog(@"创建购物车表执行失败");
        }
    }
    return _sharedDataBase;
}

/**
 *  插入数据库一条记录
 *
 *  @param key       键值对中的key
 *  @param value     键值对中得value
 *  @param valueType value的数据类型（字符串型、数组型、字典型）
 */
- (void)insertCommonSettingWithKey:(NSString *)key value:(id)value valueType:(CPNDataBaseValueType)valueType{
    NSString *keys = @"(key,value,valueType)";
    NSString *values = [NSString stringWithFormat:@"('%@','%@',%d)",key,value,valueType];
    NSMutableString *query = [[NSMutableString alloc] initWithFormat:@"INSERT OR REPLACE INTO %@ %@ VALUES %@",CPN_COMMON_SETTING_TABLE,keys,values];
    [CPNDataBaseManager executeUpdate:query];
}

/**
 *  从数据库中读取记录
 *
 *  @param key 需要读取的数据key值
 *
 *  @return 返回读取到得记录
 */
- (id)getSettingValueWithKey:(NSString *)key{
    if ([CPNInputValidUtil isBlinkString:key]) {
        return nil;
    }
    NSString * query = [NSString stringWithFormat:@"SELECT value,valueType FROM %@ where key = '%@'",CPN_COMMON_SETTING_TABLE,key];
    
    __block id valueObject = nil;
    [CPNDataBaseManager executeQuery:query queryResBlock:^(FMResultSet *set) {
        if ([set next]) {
            NSInteger valueType = [set intForColumn:@"valueType"];
            NSString *value = [set stringForColumn:@"value"];
            if (valueType != CPNDataBaseValueTypeString) {
                valueObject = [value mj_JSONObject];
            }else{
                valueObject = value;
            }
        }
    }];
    return valueObject;
}

/**
 *  删除一条数据库记录
 *
 *  @param key 需要删除的数据key值
 */
- (void)removeValueWithKey:(NSString *)key{
    if ([CPNInputValidUtil isBlinkString:key]) {
        return;
    }
    NSString * query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE key = '%@'",CPN_COMMON_SETTING_TABLE,key];
    [CPNDataBaseManager executeUpdate:query];
}

#pragma mark - 判断是否是第一次启动应用，如果是第一次启动应用，则展示引导页，如果不是，再次启动时，需要直接显示引导页最后一页
/**
 *  第一次启动之后存储标识
 */
- (void)setAppFirstStartUp{
    [self insertCommonSettingWithKey:@"firstStartUp" value:@"1" valueType:CPNDataBaseValueTypeString];
}

/**
 *  判断是否是第一次启动app
 *
 *  @return BOOL
 */
- (BOOL)isFirstStartUp{
    NSString *str = [self getSettingValueWithKey:@"firstStartUp"];
    return (str == nil);
}


#pragma - mark 保存获取到的设备推送token
/**
 *  保存推送token
 *
 *  @param deviceToken 推送token
 */
- (void)saveDevicePushToken:(NSString *)deviceToken{
    if ([CPNInputValidUtil isBlinkString:deviceToken]) {
        return;
    }
    [self insertCommonSettingWithKey:@"deviceToken" value:deviceToken valueType:CPNDataBaseValueTypeString];
}

/**
 *  获取推送token
 *
 *  @return 返回本地存储的推送token
 */
- (NSString *)devicePushToken{
    NSString *deviceToken = [self getSettingValueWithKey:@"deviceToken"];
    if ([CPNInputValidUtil isBlinkString:deviceToken]) {
        return nil;
    }
    return deviceToken;
}



#pragma mark - 保存获取到的设备imei号
/**
 *  保存设备imei
 *
 *  @param imei 设备imei
 */
- (void)saveDeviceImei:(NSString *)imei{
    if ([CPNInputValidUtil isBlinkString:imei]) {
        return;
    }
    [self insertCommonSettingWithKey:@"deviceImei" value:imei valueType:CPNDataBaseValueTypeString];
}


/**
 *  获取设备imei
 *
 *  @return 设备imei
 */
- (NSString *)deviceImei{
    NSString *deviceImei = [self getSettingValueWithKey:@"deviceImei"];
    if ([CPNInputValidUtil isBlinkString:deviceImei]) {
        NSString *imei = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [self saveDeviceImei:imei];
        return imei;
    }
    return deviceImei;
}



#pragma mark - 判断版本升级使用的（每次启动如果是新版本，保存当前版本号）
/**
 *  在新版本时，保存当前app的版本号
 */
- (void)saveNewAppVersion{
    [self insertCommonSettingWithKey:@"saveNewAppVersion" value:CPN_APP_VERSION valueType:CPNDataBaseValueTypeString];
}


/**
 * 获取存储到本地的app版本信息
 *
 *  @return NSString
 */
- (NSString *)getAppVersion{
    return [self getSettingValueWithKey:@"saveNewAppVersion"];
}

/**
 *  判断是否是新版本
 *
 *  @return BOOL
 */
- (BOOL)isAppNewVersion{
    NSString *version = [self getAppVersion];
    if (!version || [CPN_APP_VERSION compare:version options:NSNumericSearch] == NSOrderedDescending) {
        return YES;
    }
    return NO;
}



#pragma mark - 登录后保存用户信息
/**
 *  保存用户登录完成后的用户信息
 *
 *  @param userInfo 用户信息
 */
- (void)saveUserLoginInfo:(NSDictionary *)userInfo{
    NSString *info = [userInfo mj_JSONString];
    [self insertCommonSettingWithKey:@"userLoginInfo" value:info valueType:CPNDataBaseValueTypeNSDictionary];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.loginUserModel = [CPNLoginUserInfoModel mj_objectWithKeyValues:userInfo];
}

/**
 *  获取本地存储的用户信息
 *
 *  @return 返回本地存储的用户信息对象
 */
- (CPNLoginUserInfoModel *)userLoginInfo{
    NSDictionary *loginInfo = [self getSettingValueWithKey:@"userLoginInfo"];
    if ([loginInfo isKindOfClass:[NSDictionary class]]) {
        CPNLoginUserInfoModel *infoModel = [CPNLoginUserInfoModel mj_objectWithKeyValues:loginInfo];
        return infoModel;
    }
    return nil;
}


/**
 *  退出登录时清除本地存储的用户信息
 */
- (void)logoutUserAccount{
    [self removeValueWithKey:@"userLoginInfo"];
}


#pragma mark - 保存配置信息
/**
 *  保存配置信息
 *
 *  @param configInfo 用户信息
 */
- (void)saveConfigSettingInfo:(NSDictionary *)configInfo{
    NSString *info = [configInfo mj_JSONString];
    [self insertCommonSettingWithKey:@"configSettingInfo" value:info valueType:CPNDataBaseValueTypeNSDictionary];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.configModel = [CPNConfigSettingModel mj_objectWithKeyValues:configInfo];
}

/**
 *  获取本地存储的配置信息
 *
 *  @return 返回本地存储的配置信息对象
 */
- (CPNConfigSettingModel *)configSettingInfo{
    NSDictionary *configInfo = [self getSettingValueWithKey:@"configSettingInfo"];
    if ([configInfo isKindOfClass:[NSDictionary class]]) {
        CPNConfigSettingModel *infoModel = [CPNConfigSettingModel mj_objectWithKeyValues:configInfo];
        return infoModel;
    }
    return nil;
}

#pragma mark --------------------------------------------------- 华丽的分割线

/**
 *  插入CPN_SHOPING_CART_PRODUCTION_INFOS数据库一条记录
 *
 *  @param key       键值对中的key
 *  @param value     键值对中得value
 *  @param valueType value的数据类型（字符串型、数组型、字典型）
 */
- (void)insertShopCartWithKey:(NSString *)key value:(id)value valueType:(CPNDataBaseValueType)valueType{
    NSString *keys = @"(key,value,valueType)";
    NSString *values = [NSString stringWithFormat:@"('%@','%@',%d)",key,value,valueType];
    NSMutableString *query = [[NSMutableString alloc] initWithFormat:@"INSERT OR REPLACE INTO %@ %@ VALUES %@",CPN_SHOPING_CART_PRODUCTION_INFOS,keys,values];
    [CPNDataBaseManager executeUpdate:query];
}

/**
 *  从数据库CPN_SHOPING_CART_PRODUCTION_INFOS中读取记录
 *
 *  @param key 需要读取的数据key值
 *
 *  @return 返回读取到得记录
 */
- (id)getShopCartItemValueWithKey:(NSString *)key{
    if ([CPNInputValidUtil isBlinkString:key]) {
        return nil;
    }
    NSString * query = [NSString stringWithFormat:@"SELECT value,valueType FROM %@ where key = '%@'",CPN_SHOPING_CART_PRODUCTION_INFOS,key];
    
    __block id valueObject = nil;
    [CPNDataBaseManager executeQuery:query queryResBlock:^(FMResultSet *set) {
        if ([set next]) {
            NSInteger valueType = [set intForColumn:@"valueType"];
            NSString *value = [set stringForColumn:@"value"];
            if (valueType != CPNDataBaseValueTypeString) {
                valueObject = [value mj_JSONObject];
            }else{
                valueObject = value;
            }
        }
    }];
    return valueObject;
}

/**
 *  删除一条数据库CPN_SHOPING_CART_PRODUCTION_INFOS记录
 *
 *  @param key 需要删除的数据key值
 */
- (void)removeItemFromShopCartValueWithKey:(NSString *)key{
    if ([CPNInputValidUtil isBlinkString:key]) {
        return;
    }
    NSString * query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE key = '%@'",CPN_SHOPING_CART_PRODUCTION_INFOS,key];
    [CPNDataBaseManager executeUpdate:query];
}

#pragma mark - 加入购物车
/**
 添加商品到购物车
 
 @param item 需要添加的商品
 */
- (void)addProductionToShopCart:(CPNShopingCartItemModel *)item
{
    CPNShopingCartItemModel *saveItem = item;
    id DBItem = [self getShopCartItemValueWithKey:item.id];
    if (DBItem) {
        CPNShopingCartItemModel *itemModel = [CPNShopingCartItemModel mj_objectWithKeyValues:DBItem];
        itemModel.count ++;
        saveItem = itemModel;
    }
    
    //NSDictionary *saveData = [saveItem mj_keyValues];
    NSString *value = [saveItem mj_JSONString];
    [self insertShopCartWithKey:saveItem.id value:value valueType:CPNDataBaseValueTypeString];
}

/**
 删除商品
 
 @param item 需要删除的商品
 */
- (void)deleteProductionFromShopCart:(CPNShopingCartItemModel *)item
{
    id DBItem = [self getShopCartItemValueWithKey:item.id];
    if (DBItem) {
        [self removeItemFromShopCartValueWithKey:item.id];
    }
}

/**
 update商品信息
 
 @param item 更新商品
 */
- (void)updateProductionFromShopCart:(CPNShopingCartItemModel *)item
{
    NSDictionary *saveData = [item mj_keyValues];
    id value = [saveData mj_JSONString];
    [self insertShopCartWithKey:item.id value:value valueType:CPNDataBaseValueTypeNSDictionary];
}

/**
 获取购物车所有商品
 */

- (NSArray<CPNShopingCartItemModel*> *)getAllProductionInShopCart
{
    NSString * query = [NSString stringWithFormat:@"SELECT value,valueType FROM %@ ",CPN_SHOPING_CART_PRODUCTION_INFOS];
    
    __block NSMutableArray *allProductions = [NSMutableArray new];
    [CPNDataBaseManager executeQuery:query queryResBlock:^(FMResultSet *set) {
        while ([set next]) {
            NSInteger valueType = [set intForColumn:@"valueType"];
            NSString *value = [set stringForColumn:@"value"];
            if (valueType == CPNDataBaseValueTypeString) {
                id valueTemp = [value mj_JSONObject];
                CPNShopingCartItemModel *model = [CPNShopingCartItemModel mj_objectWithKeyValues:valueTemp];
                [allProductions addObject:model];
            }
        }
    }];
    return allProductions;

}


@end
