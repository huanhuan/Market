//
//  CPNShopingCartItemModel.h
//  MarketO2O
//
//  Created by phh on 2017/9/17.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNHomePageProductItemModel.h"

@interface CPNShopingCartItemModel : CPNDataBase

@property (nonatomic, assign)NSUInteger count;
@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *imageUrl;
@property (nonatomic, assign)long points;
@property (nonatomic, assign)NSInteger status;

@end
