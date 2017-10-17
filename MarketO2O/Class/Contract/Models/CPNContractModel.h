//
//  CPNContractModel.h
//  MarketO2O
//
//  Created by satyapeng on 17/10/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNBaseModel.h"

@interface CPNContractModel : CPNBaseModel


@property (nonatomic, copy)NSString *contractUrl;
@property (nonatomic, assign)NSInteger id;
@property (nonatomic, assign)NSInteger createdTime;
@property (nonatomic, assign)NSInteger modifiedTime;
@property (nonatomic, assign)NSInteger shopId;
@property (nonatomic, copy)NSString *shopName;

@end
