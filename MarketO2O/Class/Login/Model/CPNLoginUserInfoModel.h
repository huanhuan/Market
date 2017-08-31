//
//  CPNLoginUserInfoModel.h
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNBaseModel.h"

@interface CPNLoginUserInfoModel : CPNBaseModel

/**
 用户id
 */
@property (nonatomic, assign) NSInteger    id;

/**
 用户昵称
 */
@property (nonatomic, copy) NSString    *nickname;

/**
 用户头像地址
 */
@property (nonatomic, copy) NSString    *headimgurl;

/**
 用户积分
 */
@property (nonatomic, assign) long    points;

/**
 uninid 微信的id
 */
@property (nonatomic, copy)NSString *unionId;

@end
