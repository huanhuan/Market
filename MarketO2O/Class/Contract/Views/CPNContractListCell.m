//
//  CPNContractListCell.m
//  MarketO2O
//
//  Created by satyapeng on 17/10/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNContractListCell.h"

@implementation CPNContractListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.shopName = [CPNCommonLabel commonLabelWithTitle:@"商店名称"
                                                         textFont:CPNCommonFontFifteenSize
                                                        textColor:CPNCommonMaxDarkGrayColor];
        self.shopId = [CPNCommonLabel commonLabelWithTitle:@"商店ID"
                                                  textFont:CPNCommonFontThirteenSize
                                                 textColor:CPNCommonMaxDarkGrayColor];
        
        [self.cellBackView addSubview:self.shopName];
        [self.cellBackView addSubview:self.shopId];

        
        [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(@10);
            make.right.equalTo(@-10);
            make.left.equalTo(@10);
        }];
        [self.shopId mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.shopName.mas_bottom).offset(10);
            make.right.equalTo(@-10);
            make.left.equalTo(@10);
            make.bottom.equalTo(@-10);
        }];
    }
    return self;
}

- (UIView *)cellBackView{
    if (!_cellBackView) {
        _cellBackView = [[UIView alloc] initWithFrame:CGRectZero];
        _cellBackView.backgroundColor = CPNCommonWhiteColor;
        _cellBackView.layer.cornerRadius = 5.0;
        [self.contentView addSubview:_cellBackView];
        [self.cellBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            //15, 0, self.width - 30, self.height - 10
            make.left.equalTo(@15);
            make.top.equalTo(@5);
            make.right.equalTo(@-15);
            make.bottom.equalTo(@-5);
        }];
    }
    return _cellBackView;
}

@end
