
//
//  CPNProductionDetailBottonView.m
//  MarketO2O
//
//  Created by satyapeng on 17/10/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNProductionDetailBottonView.h"

@interface CPNProductionDetailBottonView()

@property (nonatomic, strong)UIButton *addShopCartButton;
@property (nonatomic, strong)UIButton *shoppingNowCartButton;
@property (nonatomic, strong)UIButton *shopCarButton;

@end

@implementation CPNProductionDetailBottonView

- (id)init
{
    if (self = [super init]) {
        self.addShopCartButton = [UIButton new];
        [self.addShopCartButton setBackgroundColor:CPNCommonDarkOrangeColor];
        [self.addShopCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [self.addShopCartButton addTarget:self action:@selector(addShopCartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.shoppingNowCartButton = [UIButton new];
        [self.shoppingNowCartButton setBackgroundColor:CPNCommonLightRedColor];
        [self.shoppingNowCartButton setTitle:@"立即兑换" forState:UIControlStateNormal];
        [self.shoppingNowCartButton addTarget:self action:@selector(shoppingNowCartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.shopCarButton = [UIButton new];
        [self.shopCarButton setImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
        [self.shopCarButton addTarget:self action:@selector(shopCarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:self.addShopCartButton];
        [self addSubview:self.shoppingNowCartButton];
        [self addSubview:self.shopCarButton];
        
        [self.shopCarButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.and.left.equalTo(self);
            make.width.equalTo(@60);
        }];
        
        [self.shoppingNowCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.and.right.equalTo(self);
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH - 60.0)/2);
        }];
        
        [self.addShopCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self);
            make.left.equalTo(self.shopCarButton.mas_right);
            make.right.equalTo(self.shoppingNowCartButton.mas_left);
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH - 60.0)/2);
        }];
    }
    return self;
}

- (void)addShopCartButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(addShopCar)]) {
        [self.delegate addShopCar];
    }
}

- (void)shoppingNowCartButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(buyNow)]) {
        [self.delegate buyNow];
    }
}

- (void)shopCarButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(gotoShopCar)]) {
        [self.delegate gotoShopCar];
    }
}

@end
