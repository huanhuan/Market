//
//  CPNShopingCartManager.h
//  MarketO2O
//
//  Created by phh on 2017/9/17.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPNSingleton.h"

@class CPNHomePageProductItemModel;

@interface CPNShopingCartManager : NSObject

CPNSingletonH(CPNShopingCartManager);

- (void)addToShopingCart:(CPNHomePageProductItemModel *)productionItem;

- (void)updateShopingCart:(CPNShopingCartItemModel *)productionItem;

- (void)deleteShopingCart:(CPNShopingCartItemModel *)productionItem;

- (void)gotoShopingCartVC;

@end
