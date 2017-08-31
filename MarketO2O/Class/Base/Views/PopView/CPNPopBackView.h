//
//  CPNPopBackView.h
//  
//
//  Created by CPN on 15/11/19.
//  Copyright © 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void ((^CPNPopViewCloseBlock)());




/**
 *  半透明全屏蒙版
 */
@interface CPNPopBackView : UIView

+ (CPNPopBackView *)sharedInstance;
- (void)displayPopBackView:(UIView *)superView subView:(UIView *)subView;
- (void)displayPopBackView:(UIView *)subView;
- (void)addCloseGestureWithBlock:(CPNPopViewCloseBlock)block;
- (void)removeCloseGesture;
- (void)close;



@end
