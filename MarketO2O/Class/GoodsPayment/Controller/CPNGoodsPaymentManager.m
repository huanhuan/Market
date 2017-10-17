//
//  CPNGoodsPaymentManager.m
//  MarketO2O
//
//  Created by satyapeng on 17/10/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNGoodsPaymentManager.h"
#import "CPNGoodsPaymentViewController.h"

@implementation CPNGoodsPaymentManager
CPNSingletonM(CPNGoodsPaymentManager);

- (void)gotoGoodsPaymentVC:(NSArray<CPNShopingCartItemModel *> *) selectedProductionArray
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!delegate.loginUserModel) {
        [SVProgressHUD showInfoWithStatus:@"需要登录后才能购买"];
        return;
    }
    CPNGoodsPaymentViewController *vc = [[CPNGoodsPaymentViewController alloc] init];
    vc.selectedProductionArray = selectedProductionArray;
    vc.hidesBottomBarWhenPushed = YES;
    [delegate.navigationVC pushViewController:vc animated:YES];

}

@end
