//
//  CPNGoodsPaymentManager.h
//  MarketO2O
//
//  Created by satyapeng on 17/10/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPNSingleton.h"
#import "CPNShopingCartItemModel.h"

@interface CPNGoodsPaymentManager : NSObject

CPNSingletonH(CPNGoodsPaymentManager);

- (void)gotoGoodsPaymentVC:(NSArray<CPNShopingCartItemModel *> *) selectedProductionArray;

@end
