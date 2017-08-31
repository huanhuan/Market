//
//  UINavigationBar+StatusBar.m
//  MarketO2O
//
//  Created by CPN on 2017/7/9.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "UINavigationController+StatusBar.h"


@implementation UINavigationController (StatusBar)

- (UIStatusBarStyle)preferredStatusBarStyle{
    return [[self topViewController] preferredStatusBarStyle];
}

@end
