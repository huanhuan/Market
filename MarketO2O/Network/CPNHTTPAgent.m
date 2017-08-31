///
//  CPNHTTPAgent.m
//  MaketO2O
//
//  Created by CPN on 2017/6/30.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNHTTPAgent.h"
#import "CPNHTTPConst.h"
#import "CPNRequestKeys.h"
#import "NSString+Md5.h"
#import "SVProgressHUD.h"
#import "CPNRequest.h"
#import "CPNLoginUserInfoModel.h"

@protocol CPNHTTPAgentProtocol <NSObject>

@optional

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

static CPNHTTPAgent *__instanceAgent = NULL;
static const double kDefaultTimeoutInterval = 30;

@interface CPNHTTPAgent ()<CPNHTTPAgentProtocol>


@end

@implementation CPNHTTPAgent

+ (CPNHTTPAgent *)instanceAgent
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if DEBUG
        __instanceAgent = [[CPNHTTPAgent alloc] initWithBaseURL:[NSURL URLWithString:API_TEST_URL]];
#else
        __instanceAgent = [[CPNHTTPAgent alloc] initWithBaseURL:[NSURL URLWithString:API_URL]];
#endif
    });
    return __instanceAgent;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self.requestSerializer  setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        [self.requestSerializer  setTimeoutInterval:kDefaultTimeoutInterval];
        [self.responseSerializer setStringEncoding:NSUTF8StringEncoding];
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil]];
    }
    return self;
}

- (void)startRequest:(CPNRequest  *)request
            response:(CPNHTTPCompleteBlock)completeBlock{
    [self startRequest:request
              response:completeBlock
     isNeedShowLoading:YES];
}


- (void)startRequest:(CPNRequest  *)request
            response:(CPNHTTPCompleteBlock)completeBlock
   isNeedShowLoading:(BOOL)isNeedShowLoading
{
    NSString       * path         = request.requestPath;
    NSString       * method       = request.requestMethod;
    [self setRequestCommonParams:request];
    NSDictionary   *body    = request.requestBody;
    NSURLSessionDataTask * task = nil;
    NSLog(@"request path:%@ \n request body : %@",path,body);
    if (isNeedShowLoading) {
        [SVProgressHUD showProgress:-1 status:@"正在加载"];
    }
    task = [[CPNHTTPAgent instanceAgent] dataTaskWithHTTPMethod:method
                                                      URLString:path
                                                     parameters:body
                                                 uploadProgress:nil
                                               downloadProgress:nil
                                                        success:^(NSURLSessionDataTask *task, id responseObject) {
                                                            if (isNeedShowLoading) {
                                                                [SVProgressHUD dismiss];
                                                            }
                                                            [self processResult:responseObject
                                                                           task:task
                                                                          error:nil
                                                                       response:completeBlock];
                                                        }
                                                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                            if (isNeedShowLoading) {
                                                                [SVProgressHUD dismiss];
                                                            }
                                                            [self processResult:nil
                                                                           task:task
                                                                          error:error
                                                                       response:completeBlock];
                                                        }];
    
    
    [task resume];
}






- (void)startUploadPicture:(CPNRequest *)request
                  response:(CPNHTTPCompleteBlock)completeBlock
{
    NSString       * path   = request.requestPath;
    NSDictionary   * body   = request.requestBody;
    [self setRequestCommonParams:request];
    NSLog(@"HTTP request %@ \n path:%@",body,path);
    
    [[CPNHTTPAgent instanceAgent] POST:path
                            parameters:body
             constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                 if (request.pictureData == nil) {
                     return ;
                 }
                 [formData appendPartWithFileData:request.pictureData
                                             name:request.requestImageKey
                                         fileName:[NSString stringWithFormat:@"%@.png",[[NSDate date] description]]
                                         mimeType:@"image/jpeg"];
             }
                              progress:nil
                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                   [self processResult:responseObject
                                                  task:task
                                                 error:nil
                                              response:completeBlock];
                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   [self processResult:nil
                                                  task:task
                                                 error:error
                                              response:completeBlock];
                               }];
    
}


- (void)processResult:(id)responseObj
                 task:(NSURLSessionDataTask *)task
                error:(NSError *)error
             response:(CPNHTTPCompleteBlock)completeBlock
{
    CPNResponse * response = [[CPNResponse alloc] initWithResp:responseObj error:error requestPath:task.originalRequest.URL.path];
    completeBlock(response,response.error);
}

- (void)cancelAllRequest
{
    [self.operationQueue cancelAllOperations];
}


- (void)generateSignWithRequest:(CPNRequest *)request{
//    NSDictionary *body      = request.requestBody;
//    NSString *appVersion    = body[PARAM_KEY_APPVERSION];
//    NSString *timeStamp     = body[PARAM_KEY_TIMESTAMP];
//    NSString *token         = body[PARAM_KEY_TOKEN];
//    NSString *sign          = [[appVersion md5HexDigest] uppercaseString];
//    sign                    = [[[NSString stringWithFormat:@"%@%@",timeStamp,sign] md5HexDigest] uppercaseString];
//    sign                    = [[[NSString stringWithFormat:@"%@%@",token,sign] md5HexDigest] uppercaseString];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CPNLoginUserInfoModel *logUser = delegate.loginUserModel;
    if (logUser) {
        [request setInt:logUser.id forKey:PARAM_KEY_USERID];
        [request setString:[[NSString stringWithFormat:@"%ld%@", logUser.id, MD5KEY] md5HexDigest] forKey:PARAM_KEY_TOKEN];
        [request setString:logUser.unionId forKey:PARAM_KEY_UNIONID];
    }
    
}


- (void)setRequestCommonParams:(CPNRequest *)request{
    //    NSString       *platform      = @"ios";
    //    NSString       *channel       = CPN_UMCHANNEL;
    //    NSTimeInterval timeStamp      = [[NSDate date] timeIntervalSince1970];
    //    NSString       *phoneType     = [[UIDevice currentDevice] model];
    //    NSString       *systemVersion = [[UIDevice currentDevice] systemVersion];
    //    NSString       *pushToken     = [[CPNDataBase defaultDataBase] devicePushToken];
    //    [request setString:CPN_APP_VERSION forKey:PARAM_KEY_APPVERSION];
    //
    //    [request setString:platform forKey:PARAM_KEY_PLATFORM];
    //    [request setString:channel forKey:PARAM_KEY_CHANNEL];
    //    [request setInt:timeStamp forKey:PARAM_KEY_TIMESTAMP];
    //    [request setString:phoneType forKey:PARAM_KEY_PHONEMODE];
    //    [request setString:systemVersion forKey:PARAM_KEY_SYSTEMVERSION];
    //    if ([CPNInputValidUtil isBlinkString:pushToken]) {
    //        [request setString:nil forKey:PARAM_KEY_PUSHTOKEN];
    //    }else{
    //        [request setString:pushToken forKey:PARAM_KEY_PUSHTOKEN];
    //    }
    //    [request setString:CPN_APP_BOUNDLEID forKey:PARAM_KEY_PACKAGENAME];
    //    [request setString:[[CPNDataBase defaultDataBase] deviceImei] forKey:PARAM_KEY_IMEI];
    //
    //    CPNAppDelegate * delegate     = (CPNAppDelegate *)[UIApplication sharedApplication].delegate;
    //    if (delegate.userLoginModel) {
    //        [request setString:delegate.userLoginModel.token forKey:PARAM_KEY_TOKEN];
    //    }else{
    //        [request setString:@"token" forKey:PARAM_KEY_TOKEN];
    //    }
    [self generateSignWithRequest:request];
}

@end
