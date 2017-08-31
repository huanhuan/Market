//
//  CPNResponse.m
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNResponse.h"
#import "CPNError.h"
#import "CPNHTTPConst.h"


static NSString * const kRespStatus         = @"status";
static NSString * const kRespStatusData     = @"data";
static NSString * const kRespStatusMsg      = @"msg";

#define kRespSuccessCode 200

@implementation CPNResponse

- (CPNResponse *)initWithResp:(id)resp
                        error:(NSError *)error
                  requestPath:(NSString *)requestPath
{
    if (!resp) {
        self.respBody = nil;
        self.respMsg = @"操作失败";
        self.respCode = -1;
        CPNError *cpnError = [[CPNError alloc] init];
        if (error) {
            NSInteger errorCode = error.code;
            if (errorCode == kCFURLErrorTimedOut
                || errorCode == kCFURLErrorNetworkConnectionLost
                || errorCode == kCFURLErrorNotConnectedToInternet
                || errorCode == kCFURLErrorCannotConnectToHost) {
                cpnError.errorCode = CPNErrorTypeNetworkError;
                cpnError.errorMessage = CPNErrorMessageNetWorkError;
            }else{
                cpnError.errorCode = CPNErrorTypeServerNotAvailable;
                cpnError.errorMessage = CPNErrorMessageServerError;
            }
            self.error = cpnError;
        }
    }else{
        if ([resp isKindOfClass:[NSDictionary class]]) {
            NSString *      msg     = resp[kRespStatusMsg];
            NSInteger       status  = [resp[kRespStatus] intValue];
            id              data    = resp[kRespStatusData];
            self.respMsg    = msg;
            self.respCode   = status;
            self.respBody   = data;
            if (status != kRespSuccessCode) {
                CPNError *cpnError = [[CPNError alloc] init];
                cpnError.errorCode = self.respCode;
                cpnError.errorMessage = self.respMsg;
                self.error = cpnError;
            }
        }else{
            self.respMsg = CPNErrorMessageDataParaseError;
            self.respCode = -1;
            CPNError *cpnError = [[CPNError alloc] init];
            cpnError.errorCode = CPNErrorTypeDataParaseError;
            cpnError.errorMessage = self.respMsg;
            self.error = cpnError;
        }
    }
    return self;
}



#pragma mark - 请求失败的一些特殊状态码处理逻辑


@end
