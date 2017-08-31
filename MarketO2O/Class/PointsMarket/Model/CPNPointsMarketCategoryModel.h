//
//  CPNPointsMarketCategoryModel.h
//  MarketO2O
//
//  Created by CPN on 2017/7/2.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNBaseModel.h"

@interface CPNPointsMarketCategoryModel : CPNBaseModel

@property (nonatomic, copy  ) NSString      *id;
@property (nonatomic, copy  ) NSString      *name;
@property (nonatomic, assign) NSInteger     status;
@property (nonatomic, assign) BOOL          isSelected;

@end
