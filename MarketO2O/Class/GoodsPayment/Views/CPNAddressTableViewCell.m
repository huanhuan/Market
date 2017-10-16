//
//  CPNAddressTableViewCell.m
//  MarketO2O
//
//  Created by satyapeng on 26/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNAddressTableViewCell.h"



@implementation CPNAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.mainView = [UIView new];
        [self.contentView addSubview:self.mainView];
        [self.mainView setBackgroundColor:CPNCommonWhiteColor];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(@10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
        }];
        
        self.name = [CPNCommonLabel commonLabelWithTitle:@"收货人："
                                                     textFont:CPNCommonFontTwelveSize
                                                    textColor:CPNCommonMaxDarkGrayColor];
        self.telePhone = [CPNCommonLabel commonLabelWithTitle:@"联系方式："
                                                textFont:CPNCommonFontTwelveSize
                                               textColor:CPNCommonMaxDarkGrayColor];
        self.address = [CPNCommonLabel commonLabelWithTitle:@"收货地址："
                                                textFont:CPNCommonFontTwelveSize
                                               textColor:CPNCommonMaxDarkGrayColor];
        
        self.backgroundColor = [UIColor clearColor];
        [self.mainView addSubview:self.name];
        [self.mainView addSubview:self.telePhone];
        [self.mainView addSubview:self.address];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(@10);
            make.right.mas_equalTo(-10);
        }];
        [self.telePhone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(10);
            make.left.equalTo(@10);
            make.right.mas_equalTo(-10);
        }];
        [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.telePhone.mas_bottom).offset(10);
            make.left.equalTo(@10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
        }];
        
//        UIView *lineView = [UIView new];
//        [self.contentView addSubview:lineView];
//        [lineView setBackgroundColor:[UIColor clearColor]];
//        
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.address.mas_bottom).offset(0);
//            make.left.equalTo(@0);
//            make.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(-10);
//            make.height.equalTo(@10);
// 
//        }];
    }
    return self;
}

- (void)setUserAddressInfoModel:(CPNUserAddressInfoModel *)userAddressInfoModel
{
    if (userAddressInfoModel) {
        _userAddressInfoModel = userAddressInfoModel;
        [self.name setText:[NSString stringWithFormat:@"收货人：%@", userAddressInfoModel.name]];
        [self.telePhone setText:[NSString stringWithFormat:@"联系方式：%@", userAddressInfoModel.telephoneNumber]];
        [self.address setText:[NSString stringWithFormat:@"收货地址：%@", [NSString stringWithFormat:@"%@%@",userAddressInfoModel.city, userAddressInfoModel.address]]];
    }
}

@end
