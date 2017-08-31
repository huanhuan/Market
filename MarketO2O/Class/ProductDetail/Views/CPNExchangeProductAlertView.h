//
//  CPNExchangeButtonAlertView.h
//  MarketO2O
//
//  Created by CPN on 2017/7/13.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNAlertView.h"

@interface CPNExchangeProductAlertView : CPNAlertView

/**
 收货人
 
 @return 收货人
 */
- (NSString *)nameText;

/**
 收货手机号
 
 @return 手机号
 */
- (NSString *)phoneText;
/**
 收货地址
 
 @return 收货地址
 */
- (NSString *)addressText;


@end
