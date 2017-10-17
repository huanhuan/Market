//
//  CPNShopingCartManager.m
//  MarketO2O
//
//  Created by phh on 2017/9/17.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNShopingCartManager.h"
#import "CPNShopingCartItemModel.h"
#import "CPNHomePageProductItemModel.h"
#import "CPNDataBase.h"
#import "CPNShoppingCartViewController.h"

@implementation CPNShopingCartManager

CPNSingletonM(CPNShopingCartManager);

- (void)addToShopingCart:(CPNHomePageProductItemModel *)productionItem
{
    if (productionItem) {
        CPNShopingCartItemModel *model = [CPNShopingCartItemModel new];
        model.id = productionItem.id;
        model.count = 1;
        model.selected = YES;
        model.desc = productionItem.desc;
        model.name = productionItem.name;
        model.imageUrl = productionItem.imageUrl;
        model.points = productionItem.points;
        model.status = productionItem.status;
        [[CPNDataBase defaultDataBase] addProductionToShopCart:model];
    }
}

- (void)updateShopingCart:(CPNShopingCartItemModel *)productionItem
{
    [[CPNDataBase defaultDataBase] updateProductionFromShopCart:productionItem];

}

- (void)deleteShopingCart:(CPNShopingCartItemModel *)productionItem
{
    [[CPNDataBase defaultDataBase] deleteProductionFromShopCart:productionItem];

}

- (void)gotoShopingCartVC
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CPNShoppingCartViewController *vc = [[CPNShoppingCartViewController alloc] init];
    vc.title = @"购物车";
    vc.hidesBottomBarWhenPushed = YES;
    [delegate.navigationVC pushViewController:vc animated:YES];
}

@end
