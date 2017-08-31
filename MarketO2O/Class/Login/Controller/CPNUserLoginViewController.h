//
//  CPNUserLoginViewController.h
//  IntelligentScales
//
//  Created by CPN on 2017/7/3.
//  Copyright © 2017年 . All rights reserved.
//

#import "CPNBaseViewController.h"

@interface CPNUserLoginViewController : CPNBaseViewController

@property (nonatomic, copy) void (^loginSuccessBlock)(CPNLoginUserInfoModel *model);

@end
