//
//  CPNWeChatLoginServer.h
//  MarketO2O
//
//  Created by CPN on 2017/7/15.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPNSingleton.h"


@interface CPNWeChatLoginServer : NSObject

CPNSingletonH(LoginServer)


/**
 点击微信登录按钮事件
 */
- (void)weiChatLoginActionWithSuccessBlock:(void (^)())completeBlock;

@end
