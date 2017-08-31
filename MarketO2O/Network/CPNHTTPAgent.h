//
//  CPNHTTPAgent.h
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "CPNResponse.h"

@class CPNRequest;



@interface CPNHTTPAgent : AFHTTPSessionManager

+ (CPNHTTPAgent *)instanceAgent;

- (void)startRequest:(CPNRequest  *)request
            response:(CPNHTTPCompleteBlock)completeBlock
   isNeedShowLoading:(BOOL)isNeedShowLoading;


- (void)startRequest:(CPNRequest  *)request
            response:(CPNHTTPCompleteBlock)completeBlock;


- (void)startUploadPicture:(CPNRequest *)request
                  response:(CPNHTTPCompleteBlock)completeBlock;


- (void)setRequestCommonParams:(CPNRequest *)request;

@end
