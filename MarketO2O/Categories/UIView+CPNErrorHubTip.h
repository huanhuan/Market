//
//  UIView+CPNErrorHubTip.h
//  FastRecord
//
//  Created by CPN on 16/7/11.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CPNErrorHubTip)

/**
 *  连接服务错误的提示hub信息，不是接口上的正常报错的情况下需要提示，而且是不需要显示提示页面的请求接口
 *
 *  @param error 请求错误
 */
- (void)requestConnectServerErrorHubTipWithError:(CPNError *)error;


@end
