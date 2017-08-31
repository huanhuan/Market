//
// Created by culiumac2 on 13-8-14.
// Copyright (c) 2013 culiu－mac01. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Md5)

-(NSString *) md5HexDigest;




/**
 *  获取两个字符串之间内容的位置
 *  @param      fromStr 第一个字符串
 *  @param      toStr 第二个字符串
 *  @return     截取字符串的位置
 */
- (NSRange) rangeFromString:(NSString *)fromStr toString:(NSString *)toStr;

@end
