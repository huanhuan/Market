//
//  CPNGoodsPaymentCell.h
//  MarketO2O
//
//  Created by satyapeng on 25/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPNShopingCartItemModel.h"
@interface CPNGoodsPaymentCell : UITableViewCell

@property(nonatomic, strong)CPNShopingCartItemModel *itemModel;


- (void)setItemModel:(CPNShopingCartItemModel *)model;

+ (CGFloat)cellHeight;

@end
