//
//  UIView+CPNErrorHubTip.m
//  FastRecord
//
//  Created by CPN on 16/7/11.
//  Copyright © 2016年 . All rights reserved.
//

#import "UIView+CPNErrorHubTip.h"
#import "CPNError.h"

@implementation UIView (CPNErrorHubTip)


/**
 *  连接服务错误的提示hub信息，不是接口上的正常报错的情况下需要提示，而且是不需要显示提示页面的请求接口
 *
 *  @param error 请求错误
 */
- (void)requestConnectServerErrorHubTipWithError:(CPNError *)error{
    if (error.errorCode == CPNErrorTypeServerNotAvailable) {
        [SVProgressHUD showInfoWithStatus:@"服务器异常，请重试"];
    }else if (error.errorCode == CPNErrorTypeNetworkError){
        [SVProgressHUD showInfoWithStatus:@"网络连接错误，请检查网络"];
    }else if (error.errorCode == CPNErrorTypeDataParaseError){
        [SVProgressHUD showInfoWithStatus:@"数据解析异常，请重试"];
    }
}


@end
