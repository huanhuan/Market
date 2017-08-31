//
//  CPNCouponListItemTableViewCell.h
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPNCouponListCouponItemModel;

@interface CPNCouponListItemTableViewCell : UITableViewCell

@property (nonatomic, strong) CPNCouponListCouponItemModel  *couponModel;

@property (nonatomic, assign) NSInteger                     index;

/**
 返回cell行高
 
 @return 行高
 */
+ (CGFloat)cellHeight;

@end
