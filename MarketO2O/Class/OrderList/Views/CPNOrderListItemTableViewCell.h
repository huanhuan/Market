//
//  CPNOrderListItemTableViewCell.h
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPNOrderListItemModel;

@interface CPNOrderListItemTableViewCell : UITableViewCell

@property (nonatomic, strong) CPNOrderListItemModel *orderModel;

+ (CGFloat)cellHeight;

@end
