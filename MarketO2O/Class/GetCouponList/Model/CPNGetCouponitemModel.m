//
//  CPNCouponitemModel.m
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNGetCouponitemModel.h"

@implementation CPNGetCouponitemModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.isCanAccquire = YES;
    }
    return self;
}


+ (NSArray *)mj_ignoredPropertyNames{
    return @[@"isCanAccquire"];
}

@end
