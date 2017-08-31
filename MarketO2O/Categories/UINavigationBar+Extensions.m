//
//  UINavigationBar+Extensions.m
//  
//
//  Created by CPN on 11/3/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import "UINavigationBar+Extensions.h"

@implementation UINavigationBar(Extensions)


- (void) drawRect:(CGRect)rect
{
    [self setBackgroundColor:CPNCommonWhiteColor];
}


- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self setBackgroundColor:CPNCommonWhiteColor];
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CPNCommonMiddleBlackColor, NSForegroundColorAttributeName,CPNCommonFontEighteenSize,NSFontAttributeName, nil]];
    [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [[UIImage alloc] init];
    if (self.superview != nil) {
        if (CPN_SYSTEM_VERSION_GREATER_THAN(@"7.0")) {
            self.translucent = NO;
            [self setBarTintColor:CPNCommonWhiteColor];
        }else{
            [self setBackgroundColor:CPNCommonWhiteColor];
        }
    }
}


@end
