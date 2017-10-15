//
//  CPNHomePageGoodsItemTableViewCell.h
//  MarketO2O
//
//  Created by CPN on 2017/7/1.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPNHomePageProductItemModel;

/**
 首页商品显示cell
 */
@interface CPNHomePageProductItemTableViewCell : UITableViewCell

@property (nonatomic, strong) CPNHomePageProductItemModel *itemModel;

- (void)hideBuyButton;
/**
 返回cell行高
 
 @return 行高
 */
+ (CGFloat)cellHeight;

@end
