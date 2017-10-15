//
//  CPNHomePageGoodsItemModel.m
//  MarketO2O
//
//  Created by CPN on 2017/7/1.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNHomePageProductItemModel.h"

@implementation CPNHomePageProductItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"imageUrl":@"imageurl",
             @"desc":@"description"};
}


- (void)mj_keyValuesDidFinishConvertingToObject{
    NSString *domain = [CPNHTTPAgent instanceAgent].baseURL.absoluteString;
    NSArray *substringArray = [self.imageUrl componentsSeparatedByString:@";"];
    if (substringArray.count > 0) {
        self.imageUrl = [NSString stringWithFormat:@"%@/coupons/%@",domain,substringArray[0]];
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:substringArray];
        [tempArray removeObjectAtIndex:0];
        NSMutableArray *domainTempArray = [NSMutableArray arrayWithCapacity:tempArray.count];
        [tempArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj = [NSString stringWithFormat:@"%@/coupons/%@",domain,obj];
            [domainTempArray addObject:obj];
        }];
        self.detailImageUrls = domainTempArray;

    }
}

@end
