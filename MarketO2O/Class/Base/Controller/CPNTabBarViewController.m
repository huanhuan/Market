//
//  CPNTabBarViewController.m
//  
//
//  Created by CPN on 11/5/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import "CPNTabBarViewController.h"
#import "CPNNavigationController.h"
#import "CPNHomePageViewController.h"
#import "CPNPointsMarketPageViewController.h"
#import "CPNUserCenterViewController.h"
#import "CPNShoppingCartViewController.h"


@interface CPNTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation CPNTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addChildVC];
    self.tabBar.translucent = NO;
}


#pragma mark - 布局界面

/**
 *  添加子 控制器
 */
- (void) addChildVC
{
    [self addChildVCWithViewController:[[CPNHomePageViewController alloc] init] title:@"首页" imageName:@"首页icon" selectedImageName:@"首页icon-选中"];
    [self addChildVCWithViewController:[[CPNPointsMarketPageViewController alloc] init] title:@"积分商城" imageName:@"商城icon" selectedImageName:@"商城icon-选中"];
        [self addChildVCWithViewController:[[CPNShoppingCartViewController alloc] init] title:@"购物车" imageName:@"商城icon" selectedImageName:@"商城icon-选中"];
    [self addChildVCWithViewController:[[CPNUserCenterViewController alloc] init] title:@"个人中心" imageName:@"个人中心icon" selectedImageName:@"个人中心icon-选中"];
}
/**
 *  添加自控制器
 *
 *  @param viewController      控制器
 *  @param imageName           图片
 *  @param selectedImageName 选中图片
 */
- (void) addChildVCWithViewController:(UIViewController * _Nonnull)viewController title:(NSString *_Nonnull)title imageName:(NSString * _Nonnull)imageName selectedImageName:(NSString * _Nonnull)selectedImageName
{
    viewController.title = title;
    UIImage *originImage = [UIImage imageNamed:imageName];
    viewController.tabBarItem.image = [originImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image = [UIImage imageNamed:selectedImageName];
    viewController.tabBarItem.selectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    self.tabBar.tintColor = CPNCommonRedColor;
    self.tabBar.barTintColor = CPNCommonWhiteColor;
    CPNNavigationController *nav = [[CPNNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}



@end
