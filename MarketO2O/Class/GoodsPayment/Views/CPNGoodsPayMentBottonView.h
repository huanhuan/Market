//
//  CPNGoodsPayMentBottonView.h
//  MarketO2O
//
//  Created by satyapeng on 25/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPNGoodsPayMentBottonDelegate<NSObject>

- (void)confirmButtonClick;

@end

@interface CPNGoodsPayMentBottonView : UIView

@property (nonatomic, weak)id<CPNGoodsPayMentBottonDelegate> delegate;

- (void)update:(NSInteger)payPoints remainPoints:(NSInteger)retainPoints needPayMoney:(float)needPayMoney;

@end
