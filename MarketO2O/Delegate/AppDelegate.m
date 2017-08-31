//
//  AppDelegate.m
//  MaketO2O
//
//  Created by CPN on 2017/6/26.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "AppDelegate.h"
#import "CPNTabBarViewController.h"
#import "WXApi.h"
#import "CPNWeChatLoginServer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    //TODO:打开注释
//    [self applicationRequestUserConfigInfo];
    [self applicationLaunchMainViewController];
    [self applicationInitWeChatSDK];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if ([url.scheme isEqualToString:CPN_WECHATAPPKEY]) {
        NSRange rangeAuth = [url.absoluteString rangeOfString:@"oauth"];
        if (rangeAuth.location != NSNotFound) {
            return [WXApi handleOpenURL:url delegate:(id <WXApiDelegate>)[CPNWeChatLoginServer class]];
        }
    }
    return YES;
}


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.scheme isEqualToString:CPN_WECHATAPPKEY]) {
        NSRange rangeAuth = [url.absoluteString rangeOfString:@"oauth"];
        if (rangeAuth.location != NSNotFound) {
            return [WXApi handleOpenURL:url delegate:(id <WXApiDelegate>)[CPNWeChatLoginServer class]];
        }
    }
    
    return YES;
}


#pragma mark - netWorkReqeust

/**
 请求配置信息
 */
- (void)applicationRequestUserConfigInfo{
    [[CPNHTTPClient instanceClient] requestConfigSettingInfoWithCompleteBlock:^(CPNConfigSettingModel *infoModel, CPNError *error) {
        if (!error) {
            
        }
    }];
}


#pragma mark - baseFucntion

/**
 启动首页
 */
- (void)applicationLaunchMainViewController{
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
}


/**
 初始化微信sdk
 */
- (void)applicationInitWeChatSDK{
    [WXApi registerApp:CPN_WECHATAPPKEY];
}


#pragma mark - 成员属性初始化
/**
 *  首页tabBar控制器
 *
 */
- (CPNTabBarViewController *)tabBarController{
    if (!_tabBarController) {
        _tabBarController = [[CPNTabBarViewController alloc] init];
    }
    return _tabBarController;
}



/**
 配置信息model

 @return model
 */
- (CPNConfigSettingModel *)configModel{
    if (!_configModel) {
        _configModel = [[CPNDataBase defaultDataBase] configSettingInfo];
    }
    return _configModel;
}



/**
 登录用户model

 @return model
 */
- (CPNLoginUserInfoModel *)loginUserModel{
    if (!_loginUserModel) {
        _loginUserModel = [[CPNDataBase defaultDataBase] userLoginInfo];
        if (_loginUserModel) {
            [[CPNHTTPClient instanceClient] requestUserInfoWithUnionId:_loginUserModel completeBlock:^(CPNLoginUserInfoModel *infoModel, CPNError *error) {
                if (!error && infoModel) {
                    _loginUserModel = infoModel;
                }
            }];

        }
    }
    return _loginUserModel;
}

@end
