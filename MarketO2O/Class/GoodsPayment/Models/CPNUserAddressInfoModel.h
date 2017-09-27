//
//  CPNUserAddressInfoModel.h
//  MarketO2O
//
//  Created by satyapeng on 25/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNDataBase.h"

@interface CPNUserAddressInfoModel : CPNDataBase

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *telephoneNumber;
@property (nonatomic, copy)NSString *city;
@property (nonatomic, copy)NSString *address;

@end
