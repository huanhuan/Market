//
//  CPNCouponListSubViewController.h
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNBaseViewController.h"

@interface CPNCouponListSubViewController : CPNBaseViewController

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, assign) NSInteger     index;

- (void)refreshCouponDataList;

@end
