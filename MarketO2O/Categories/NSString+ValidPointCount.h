//
//  NSString+ValidPointCount.h
//  
//
//  Created by CPN on 16/7/5.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ValidPointCount)
/**
 *  限制浮点数的小数点后的有效位数
 *
 *  @param count 位数
 *
 *  @return NSString
 */
- (NSString *)limitStringValidPointCount:(NSInteger)count;

/**
 *  去除浮点字符串中无效零
 *
 *  @return NSString
 */
- (NSString *)limitStringInValidZero;

@end
