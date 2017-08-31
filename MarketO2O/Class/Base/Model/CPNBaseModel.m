//
//  CPNBaseModel.m
//  MarketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNBaseModel.h"

@implementation CPNBaseModel


- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if (oldValue == nil) {
        if (property.type.typeClass == [NSArray class]) {
            return @[];
        }else if (property.type.typeClass == [NSDictionary class]){
            return @{};
        }else if (!property.type.typeClass){
            return 0;
        }
        return nil;
    }
    return oldValue;
}

@end
