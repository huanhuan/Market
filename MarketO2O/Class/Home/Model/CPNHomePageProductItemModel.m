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
    self.imageUrl = [NSString stringWithFormat:@"%@/coupons/%@",domain,self.imageUrl];
}

@end
