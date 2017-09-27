//
//  CPNAddressTableViewCell.h
//  MarketO2O
//
//  Created by satyapeng on 26/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPNUserAddressInfoModel.h"

@interface CPNAddressTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *name;
@property (nonatomic, strong)UILabel *telePhone;
@property (nonatomic, strong)UILabel *address;

@property (nonatomic, strong)UIView *mainView;

@property (nonatomic, strong)CPNUserAddressInfoModel *userAddressInfoModel;

@end
