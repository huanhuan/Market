//
//  NSString+Jason.h
//  MarketO2O
//
//  Created by phh on 2017/8/13.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Jason)

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
