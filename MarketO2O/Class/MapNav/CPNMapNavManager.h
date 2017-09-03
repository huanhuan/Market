//
//  CPNMapNavManager.h
//  MarketO2O
//
//  Created by phh on 2017/9/3.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPNSingleton.h"

@interface CPNMapNavManager : NSObject

CPNSingletonH(CPNMapNavManager);

- (void)mapNavTargetPointWithLatitude:(CGFloat)lat longitude:(CGFloat)lon name:(NSString *)name;
@end
