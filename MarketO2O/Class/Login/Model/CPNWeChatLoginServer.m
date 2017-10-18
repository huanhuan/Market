//
//  CPNWeChatLoginServer.m
//  MarketO2O
//
//  Created by CPN on 2017/7/15.
//  Copyright © 2017年 Maket. All rights reserved.
//

#import "CPNWeChatLoginServer.h"
#import "WXApi.h"
#import "AFHTTPSessionManager.h"
#import "CPNHTTPAgent.h"
#import "CPNRequest.h"

@interface CPNWeChatLoginServer ()<WXApiDelegate>

@property (nonatomic, copy) void (^loginSuccessBlock)();

@end

@implementation CPNWeChatLoginServer

CPNSingletonM(LoginServer)


#pragma mark - 微信登录

/**
 点击微信登录按钮事件
 */
- (void)weiChatLoginActionWithSuccessBlock:(void (^)())completeBlock{
    self.loginSuccessBlock = completeBlock;
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"wechat_sdk_coupon";
    
    if (![WXApi isWXAppInstalled]) {
        [WXApi sendAuthReq:req viewController:APPDELEGATE.navigationVC delegate:self];
    }else
    {
        [WXApi sendReq:req];
    }
    
}


#pragma mark - wxDelegate
- (void)onReq:(BaseReq *)req{
    
}


- (void)onResp:(BaseResp *)resp{
    
}


+ (void)onReq:(BaseReq *)req{
    
}


/**
 微信登录授权回调

 @param resp 回调
 */
+ (void)onResp:(BaseResp *)resp{
    if (resp.errCode == WXSuccess) {
        SendAuthResp *authResp = (SendAuthResp *)resp;
        NSString *codeString = authResp.code;
        [self weChatAuthorizationSuccessGetTokenWithCode:codeString];
    }else if (resp.errCode == WXErrCodeUserCancel){
        [SVProgressHUD showInfoWithStatus:@"您取消了微信授权"];
    }else if (resp.errCode == WXErrCodeAuthDeny){
        [SVProgressHUD showInfoWithStatus:@"您拒绝了微信授权"];
    }else{
        [SVProgressHUD showInfoWithStatus:@"微信授权失败，请重试"];
    }
}


/**
 根据授权得到的状态码获取accessToken

 @param codeString 状态码
 */
+ (void)weChatAuthorizationSuccessGetTokenWithCode:(NSString *)codeString{
    NSString *requestTokenUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",CPN_WECHATAPPKEY,CPN_WECHATAPPSECRET,codeString];
    [self requestWithUrl:requestTokenUrl
            successBlock:^(NSURLSessionDataTask *task, id responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSString *accessToken = [responseObject objectForKey:@"access_token"];
                    NSString *openId = [responseObject objectForKey:@"openid"];
                    [self weChatGetUserInfoWithAccessToken:accessToken openId:openId];
                }
            } failBlock:^(NSURLSessionDataTask *failTask, NSError *error)
     {
         
     }];
}



/**
 获取微信登录用户的信息

 @param accessToken 授权令牌
 @param openId 用户id
 */
+ (void)weChatGetUserInfoWithAccessToken:(NSString *)accessToken
                                  openId:(NSString *)openId{
    NSString *requestUserInfoUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    [self requestWithUrl:requestUserInfoUrl
            successBlock:^(NSURLSessionDataTask *task, id responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSString *unionId = responseObject[@"openid"];
                    NSString *headerImageUrl = responseObject[@"headimgurl"];
                    NSString *nickName = responseObject[@"nickname"];
                    [[[self class] sharedLoginServer] requestLoginCouponSystemWithUnionId:unionId
                                                                                 nickName:nickName
                                                                           headerImageUrl:headerImageUrl];
                }
            } failBlock:^(NSURLSessionDataTask *failTask, NSError *error)
     {
         
     }];
    
}


/**
 微信登录成功后获取到额信息上传到服务器登录请求

 @param unionId 用户微信id
 @param nickName 用户微信名称
 @param headerImgUrl 用户微信头像地址
 */
- (void)requestLoginCouponSystemWithUnionId:(NSString *)unionId
                                   nickName:(NSString *)nickName
                             headerImageUrl:(NSString *)headerImgUrl{
    [[CPNHTTPClient instanceClient] requestLoginWithUnionId:unionId
                                                   nickName:nickName
                                                headerImage:headerImgUrl
                                              completeBlock:^(CPNLoginUserInfoModel *infoModel, CPNError *error) {
                                                  if (!error) {
                                                      if (self.loginSuccessBlock) {
                                                          self.loginSuccessBlock();
                                                      }
                                                  }
                                              }];
}


/**
 GET请求方法

 @param requestUrl 请求地址
 @param successBlock 请求成功回调
 @param failBlock 请求失败回调
 */
+ (void)requestWithUrl:(NSString *)requestUrl
          successBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock
             failBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failBlock{
//    CPNHTTPAgent *agent = [CPNHTTPAgent instanceAgent];
//    CPNRequest *request = [[CPNRequest alloc] init];
//    [request setRequestMethod:CPN_REQUEST_METHOD_GET];
    
//    agent startRequest:<#(CPNRequest *)#> response:<#^(CPNResponse *response, CPNError *error)completeBlock#>
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];

    [manager GET:requestUrl
      parameters:nil
        progress:nil
         success:successBlock
         failure:failBlock];
}

@end
