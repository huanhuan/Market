//
//  CPNInputValidUtil.m
//  
//
//  Created by CPN on 11/3/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import "CPNInputValidUtil.h"
#import "NSString+ValidPointCount.h"


@implementation CPNInputValidUtil
/**
 *  判断字符串是否为空
 *
 *  @param string 需要判断的字符串
 *
 *  @return BOOL
 */
+ (BOOL)isBlinkString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (![string isKindOfClass:[NSString class]]) {
        string = [NSString stringWithFormat:@"%@",string];
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    
    return NO;
}


/**
 *  判断字符串是否为0
 *
 *  @param text 需要判断的字符串
 *
 *  @return bool
 */
+ (BOOL)isZeroCountString:(NSString *)text{
    if ([self isBlinkString:text]) {
        return YES;
    }
    NSString *count = [text limitStringValidPointCount:3];
    if ([count isEqualToString:@"0"]
        || [count isEqualToString:@"0.0"]
        || [count isEqualToString:@"0.00"]
        || [count isEqualToString:@"0.000"]) {
        return YES;
    }
    return NO;
}



/**
 *  去除手机号码中的特殊字符，+86，17951，12593，-
 *
 *  @param mobileNum 给定的手机号码
 *
 *  @return 返回处理之后的手机号
 */
+ (NSString *)modifyTelphoneMobile:(NSString *)mobileNum{
    NSString *telphone = [mobileNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    telphone = [telphone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([telphone hasPrefix:@"+86"]) {
        telphone = [telphone substringFromIndex:4];
    }
    
    NSString *specialPreFix = @"17951";
    if ([telphone hasPrefix:specialPreFix]) {
        telphone = [telphone substringFromIndex:specialPreFix.length];
    }
    
    specialPreFix = @"12593";
    if ([telphone hasPrefix:specialPreFix]) {
        telphone = [telphone substringFromIndex:specialPreFix.length];
    }
    return telphone;
}


/**
 *  校验是否是有效的手机号码
 *
 *  @param mobileNum 给定的手机号码
 *
 *  @return bool
 */
+ (BOOL)isValidateMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}




/**
 判断是否是有效的密码

 @param passwordword 密码
 @return bool
 */
+ (BOOL)isValidatePasswordword:(NSString *)passwordword{
    NSString *newPassword = [passwordword stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([newPassword isEqualToString:@""]) {
        return NO;
    }
    
    
    NSString *strRegex = @"[\u4e00-\u9fa5]";
    BOOL isHaveChinese = NO;
    for (int i=0; i<passwordword.length; i++) {
        NSString *str = [passwordword substringWithRange:NSMakeRange(i, 1)];
        BOOL rt = [self isValidateRegularExpression:str byExpression:strRegex];
        if (rt) {
            isHaveChinese = YES;
            break;
        }
    }
    
    if (isHaveChinese) {
        return NO;
    }else{
        if (passwordword.length >= 6 && passwordword.length <= 18) {
            return YES;
        }
        return NO;
    }
}




/**
 校验验证码是否正确

 @param verifyCode 验证码
 @return BOOL
 */
+ (BOOL)isValidateVerifyCode:(NSString *)verifyCode{
    NSString *newPassword = [verifyCode stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([newPassword isEqualToString:@""]) {
        return NO;
    }
    return YES;
}


+ (BOOL)isValidateRegularExpression:(NSString *)strDestination
                       byExpression:(NSString *)strExpression

{
    NSPredicate  *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    return [predicate evaluateWithObject:strDestination];
}


@end
