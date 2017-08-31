//
//  CPNInputValidUtil.h
//  
//
//  Created by CPN on 11/3/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPNInputValidUtil : NSObject

/**
 *  判断字符串是否为空
 *
 *  @param string 需要判断的字符串
 *
 *  @return BOOL
 */
+ (BOOL)isBlinkString:(NSString *)string;


/**
 *  判断字符串是否为0
 *
 *  @param text 需要判断的字符串
 *
 *  @return bool
 */
+ (BOOL)isZeroCountString:(NSString *)text;


/**
 *  去除手机号码中的特殊字符，+86，17951，12593，-
 *
 *  @param mobileNum 给定的手机号码
 *
 *  @return 返回处理之后的手机号
 */
+ (NSString *)modifyTelphoneMobile:(NSString *)mobileNum;


/**
 *  校验是否是有效的手机号码
 *
 *  @param mobileNum 给定的手机号码
 *
 *  @return bool
 */
+ (BOOL)isValidateMobileNumber:(NSString *)mobileNum;


/**
 判断是否是有效的密码
 
 @param passwordword 密码
 @return bool
 */
+ (BOOL)isValidatePasswordword:(NSString *)passwordword;

/**
 校验验证码是否正确
 
 @param verifyCode 验证码
 @return BOOL
 */
+ (BOOL)isValidateVerifyCode:(NSString *)verifyCode;

@end
