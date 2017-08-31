//
//  CPNBaseViewController.h
//  
//
//  Created by CPN on 11/2/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPNNavigationController.h"
#import "CPNError.h"


@class AppDelegate;

typedef void(^CPNErrorTipViewRetryBlock)();


@interface CPNBaseViewController : UIViewController

@property(nonatomic, strong) AppDelegate    *appDelegate;
@property (nonatomic,strong) UIView         *errorTipView;

- (void)setLeftBar:(NSString *)title
  normalImageNamed:(NSString *)normalImageNamed
    highImageNamed:(NSString *)highImageNamed;

- (void)setRightBar:(NSString *)title
   normalImageNamed:(NSString *)normalImageNamed
     highImageNamed:(NSString *)highImageNamed;

- (void)setDefaultBar;
- (void)clickedLeftBarButton;
- (void)clickedRightBarButton;

- (UIView *)findFirstResponder:(UIView *)baseView;
- (UIView *)findSuperViewWithKindClass:(Class)class subView:(UIView *)subView;

- (void)setDefaultErrorTipWithError:(CPNError *)error retryBlock:(CPNErrorTipViewRetryBlock)retryAction;

/**
 *  是否需要显示请求错误的提示页面
 *
 *  @param error 请求错误
 *
 *  @return BOOL
 */
- (BOOL)isNeedShowErrorTipViewWithError:(CPNError *)error;

@end
