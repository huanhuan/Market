//
//  CPNMacros.h
//  
//
//  Created by CPN on 11/3/15.
//  Copyright (c) 2015 . All rights reserved.
//

#ifndef _CPNMacros_h
#define _CPNMacros_h


#define CPNColorSF(RGB) [UIColor colorWithRed:((float)((RGB & 0xFF0000) >> 16)) / 255.0 \
green:((float)((RGB & 0xFF00) >> 8)) / 255.0 \
blue:((float)((RGB & 0xFF))) / 255.0 \
alpha:1.0]

#define CPNColorST(r,g,b,p) [UIColor colorWithRed:(CGFloat)(r)/255.0 green:(CGFloat)(g)/255.0 blue:(CGFloat)(b)/255.0 alpha:p]
#define CPNColorSV(r,g,b)    CPNColorST(r,g,b,1)


#define MAIN_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define MAIN_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width


#define CPN_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define CPN_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define CPN_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define CPN_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define CPN_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define CPN_APP_BOUNDLEID ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"])

#define CPN_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

#define CPN_APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])

#define CPN_SELF_MODEL ((AppDelegate *)[UIApplication sharedApplication].delegate).loginUserModel

#define MINUSONE    @"-1"

/**
 *  微信sdk的appkey
 */
#define CPN_WECHATAPPKEY @"wxc5df61a5b9eb3c61"

/**
 *  微信sdk的AppSecret
 */
#define CPN_WECHATAPPSECRET @"e892c091e0d1b26053af9c4550e4401a"


#define WeakSelf __weak typeof(self) weakSelf = self;


#pragma mark -  全局颜色配置
#pragma mark - 黑色块
/**
 *                                           黑色,0x000000
 */
#define CPNCommonBlackColor                  CPNColorSF(0x000000)

/**
 *                                           中黑色,0x333333
 */
#define CPNCommonMiddleBlackColor            CPNColorSF(0x333333)

#pragma mark - 灰色块

/**
 *                                           最深灰,0x808080
 */
#define CPNCommonMaxDarkGrayColor            CPNColorSF(0x808080)

/**
 *                                           深灰,0x999999
 */
#define CPNCommonDarkGrayColor               CPNColorSF(0x999999)
/**
 *                                           灰色,0xb0b0b0
 */
#define CPNCommonGrayColor                   CPNColorSF(0xb0b0b0)

/**
 *                                           浅灰色,0xcccccc
 */
#define CPNCommonLightGrayColor              CPNColorSF(0xcccccc)

/**
 *                                           最浅灰色,0xc7c7cd
 */
#define CPNCommonMaxLightGrayColor           CPNColorSF(0xc7c7cd)

/**
 *                                           线条描边色,0xeaeaea
 */
#define CPNCommonLineLayerColorColor         CPNColorSF(0xeaeaea)

/**
 *                                           弹出弹框背景颜色,0xececec
 */
#define CPNCommonViewBackgroundColor         CPNColorSF(0xececec)
/**
 *                                           控制器背景颜色,0xf8f8f8
 */
#define CPNCommonContrllorBackgroundColor    CPNColorSF(0xf8f8f8)
/**
 *                                           列表按压色,0xf0f0f0
 */
#define CPNCommonCellHightBackgroundColor    CPNColorSF(0xf0f0f0)

#pragma mark - 蓝色块

/**
 *                                           深蓝色
 */
#define CPNCommonDarkBlueColor               CPNColorSF(0x3686dc)

/**
 *                                           中蓝色
 */
#define CPNCommonMiddleBlueColor             CPNColorSF(0x58a4f8)

/**
 *                                           浅蓝色
 */
#define CPNCommonLightBlueColor              CPNColorSF(0X3686dc)


#pragma mark - 红色块
/**
 *                                           浅红色
 */
#define CPNCommonLightRedColor               CPNColorSF(0xf46366)
/**
 *                                           红色
 */
#define CPNCommonRedColor                    CPNColorSF(0xc81623)

/**
 *                                           深红色
 */
#define CPNCommonDarkRedColor                CPNColorSF(0Xb64040)

#pragma mark - 橙色块
/**
 *                                           橙色,0xfa9899
 */
#define CPNCommonOrangeColor                 CPNColorSF(0xfa9899)

/**
 *                                           深橙色,0xfa9899
 */
#define CPNCommonDarkOrangeColor             CPNColorSF(0xfe9200)

#pragma mark - 白色块

/**
 *                                           白色,0xffffff
 */
#define CPNCommonWhiteColor                  CPNColorSF(0xffffff)

#pragma mark - 绿色快
/**
 *                                            草绿色,0x12c700
 */
#define CPNCommonGreenColor                  CPNColorSF(0x12c700)

/**
 *                                            绿色,0x17ba68
 */
#define CPNCommonLightGreenColor             CPNColorSF(0x17ba68)



#pragma mark -  全局字体大小配置
#define CPNCommonFontThirtySize                 [UIFont systemFontOfSize:30]
/**
 *  会员支付页面价格
 *
 *  @return
 */
#define CPNCommonFontTwentySize                 [UIFont systemFontOfSize:20]

/**
 *  导航栏标题字体
 */
#define CPNCommonFontEighteenSize               [UIFont systemFontOfSize:18]
/**
 *  短标题字体
 */
#define CPNCommonFontSixteenSize                [UIFont systemFontOfSize:16]
/**
 *  长标题字体
 */
#define CPNCommonFontFifteenSize                [UIFont systemFontOfSize:15]
/**
 *  内容区域字体
 */
#define CPNCommonFontFourteenSize               [UIFont systemFontOfSize:14]

#define CPNCommonFontThirteenSize               [UIFont systemFontOfSize:13]
/**
 *  内容注释字体
 */
#define CPNCommonFontTwelveSize                 [UIFont systemFontOfSize:12]

#define CPNCommonFontElevenSize                 [UIFont systemFontOfSize:11]
/**
 *  时间注释字体
 */
#define CPNCommonFontTenSize                    [UIFont systemFontOfSize:10]


#pragma mark - NotificationName


#endif
