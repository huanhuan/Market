//
//  CPNShopingCartBottonView.h
//  MarketO2O
//
//  Created by phh on 2017/9/17.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPNShopingCartBottonViewDelegate<NSObject>

- (void)selectedAll:(BOOL)selected;

@end

@interface CPNShopingCartBottonView : UIView

- (void)updateSelectNumber:(NSUInteger)number points:(NSUInteger)points hasSelectedAll:(BOOL)selected;

@property (nonatomic, weak)id<CPNShopingCartBottonViewDelegate> delegate;

@end
