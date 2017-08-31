//
//  AppDelegate.h
//  MaketO2O
//
//  Created by CPN on 2017/6/26.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>



@class CPNTabBarViewController;
@class CPNLoginUserInfoModel;
@class CPNConfigSettingModel;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow                  *window;

@property (strong, nonatomic) CPNConfigSettingModel     *configModel;

/**
 *  首页tabBar控制器
 */
@property (strong, nonatomic) CPNTabBarViewController   *tabBarController;

/**
 当前登录用户的model
 */
@property (strong, nonatomic) CPNLoginUserInfoModel     *loginUserModel;


@end

