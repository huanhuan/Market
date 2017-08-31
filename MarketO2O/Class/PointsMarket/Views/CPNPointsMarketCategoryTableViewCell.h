//
//  CPNPointsMarketCategoryTableViewCell.h
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPNPointsMarketCategoryModel;

@interface CPNPointsMarketCategoryTableViewCell : UITableViewCell

@property (nonatomic, strong) CPNPointsMarketCategoryModel  *categoryModel;

/**
 返回行高
 
 @return 行高
 */
+ (CGFloat)cellHeight;

@end
