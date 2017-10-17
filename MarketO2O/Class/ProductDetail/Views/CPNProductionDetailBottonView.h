//
//  CPNProductionDetailBottonView.h
//  MarketO2O
//
//  Created by satyapeng on 17/10/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol productionDetailBottomDelegate <NSObject>

- (void)addShopCar;
- (void)gotoShopCar;
- (void)buyNow;

@end

@interface CPNProductionDetailBottonView : UIView

@property (nonatomic, weak)id<productionDetailBottomDelegate> delegate;

@end
