//
//  CPNNavigationController.m
//  
//
//  Created by CPN on 15/12/3.
//  Copyright © 2015年 . All rights reserved.
//

#import "CPNNavigationController.h"

@interface CPNNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>


@end

@implementation CPNNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = CPNCommonContrllorBackgroundColor;
    [self.navigationBar setTintColor:CPNCommonRedColor];
    self.delegate = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (navigationController.viewControllers.count == 1) {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        }else{
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    if (navigationController.viewControllers.count > 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
}





@end
