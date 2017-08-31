//
//  CPNGetCouponItemTableViewCell.h
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPNGetCouponitemModel;

@interface CPNGetCouponItemTableViewCell : UITableViewCell

@property (nonatomic, strong) CPNGetCouponitemModel    *itemModel;

/**
 返回cell行高
 
 @return 行高
 */
+ (CGFloat)cellHeight;

@end
