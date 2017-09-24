//
//  CPNShopingCartItemCell.h
//  MarketO2O
//
//  Created by phh on 2017/9/17.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPNShopingCartItemModel.h"

@protocol CPNShopingCartItemCellDelegate<NSObject>

- (void)selecteItemModel:(CPNShopingCartItemModel *)itemModel status:(BOOL)selected;
- (void)updateItemModelCount:(CPNShopingCartItemModel *)itemModel;
@end


@interface CPNShopingCartItemCell : UITableViewCell

@property(nonatomic, strong)CPNShopingCartItemModel *itemModel;

@property(nonatomic, weak)id<CPNShopingCartItemCellDelegate> delegate;

+ (CGFloat)cellHeight;

@end
